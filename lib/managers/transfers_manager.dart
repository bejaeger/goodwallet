// Managing all transfers and holding some state
// Serves as Intermediary between Firestore and Viewmodels

// Functionalities
// - Retrieve Streams of transfer documents
// - Add listeners to transfer documents

// Could potentially rename again into a "service"

import 'dart:async';
import 'package:good_wallet/apis/firestore_api.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/money_pools/payouts/money_pool_payout.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/money_transfer_query_config.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
import 'package:good_wallet/datamodels/user/user.dart';
import 'package:good_wallet/enums/transfer_type.dart';
import 'package:good_wallet/exceptions/transfers_manager_exception.dart';
import 'package:good_wallet/services/user/user_service.dart';
import 'package:good_wallet/utils/logger.dart';

class TransfersManager {
  final log = getLogger("transfers_manager.dart");

  final _firestoreApi = locator<FirestoreApi>();
  final _userService = locator<UserService>();
  User get currentUser => _userService.currentUser;

  // list of latest transactions and their subscriptions
  // Config decides which collection / documents are retrieved
  Map<MoneyTransferQueryConfig, List<MoneyTransfer>> latestTransfers = {};
  Map<MoneyTransferQueryConfig, StreamSubscription?> _transfersSubscriptions =
      {};

  // list of money pool payouts and their subscriptions
  // String will become the money pool id
  Map<String, List<MoneyPoolPayout>> moneyPoolPayouts = {};
  Map<String, StreamSubscription?> _moneyPoolPayoutsStreamSubscriptions = {};

  //////////////////////////////////////////////////////////
  ///
  /// Money Transfers

  // Get query for transaction with given direction.
  // optionally set the maximum number of documents retrieved
  Stream<List<MoneyTransfer>> getTransferDataStream(
      {required MoneyTransferQueryConfig config}) {
    // check arguments:
    if (!isValidFirestoreQueryConfig(config: config)) {
      throw TransfersManagerException(
          message:
              "The provided firestore query filter: '$config.isEqualToFilter' is not supported at the moment!");
    }
    return _firestoreApi.getTransferDataStream(
        config: config, uid: currentUser.uid);
  }

  // Get transfers for config. Using this function makes only sense
  // if a listener has been added with addTransferDataListener, seebe low
  List<MoneyTransfer> getTransfers({required MoneyTransferQueryConfig config}) {
    if (config.type == TransferType.Invalid) {
      log.w(
          "You tried to retrieve list of money transfers of invalid type. Returning empty list");
      return [];
    }

    if (!latestTransfers.containsKey(config)) {
      log.w(
          "Did not find any transfers for config $config. Please add a listener with 'addTransferDataListener()'. Returning empty list");
      return [];
    } else {
      return latestTransfers[config]!;
    }
  }

  // More generic class to listen to firestore collections for updates.
  // callback can be used to provide notifyListeners from the viewmodel
  // to the service
  Future<void>? addTransferDataListener(
      {required MoneyTransferQueryConfig config}) {
    if (_transfersSubscriptions.containsKey(config)) {
      log.v(
          "Stream with config '$config' already listened to, resuming it in case it has been paused!");
      _transfersSubscriptions[config]?.resume();
    } else {
      log.i("Setting up listener for transfers with config $config.");
      Stream<List<MoneyTransfer>> snapshot;
      try {
        snapshot = getTransferDataStream(config: config);

        // listen to combined stream and add transactions to controller
        var completer = Completer<void>();
        _transfersSubscriptions[config] = snapshot.listen(
          (transactions) {
            // Option to make the list unique!
            if (config.makeUniqueRecipient != null) {
              latestTransfers[config] =
                  getMoneyTransfersWithUniqueSender(transactions);
            } else {
              latestTransfers[config] = transactions;
            }
            if (!completer.isCompleted) {
              completer.complete();
            }
            log.v(
                "Listened to ${transactions.length} transfers with config $config. Max returns were specified with ${config.maxNumberReturns}");
          },
        );
        return completer.future;
      } catch (e) {
        rethrow;
      }
    }
  }

  // pause the listener
  void pauseTransferDataListener({required MoneyTransferQueryConfig config}) {
    log.v("Remove transfer data listener with config: '$config'");
    _transfersSubscriptions[config]?.pause();
  }

  // cancel the listener
  void cancelTransferDataListener({required MoneyTransferQueryConfig config}) {
    log.v("Remove transfer data listener with config: '$config'");
    _transfersSubscriptions[config]?.cancel();
    _transfersSubscriptions[config] = null;
  }

  ////////////////////////////////////////////////////////
  ///
  /// Money Pools

  // listen to money pool payouts
  Future<void>? addMoneyPoolPayoutListener({required String mpid}) async {
    if (_moneyPoolPayoutsStreamSubscriptions[mpid] == null) {
      final snapshot = _firestoreApi.getMoneyPoolPayoutsStream(mpid: mpid);
      var completer = Completer<void>();
      _moneyPoolPayoutsStreamSubscriptions[mpid] = snapshot.listen((snapshot) {
        moneyPoolPayouts[mpid] = snapshot;
        if (!completer.isCompleted) {
          completer.complete();
        }
        log.v("Listened to ${moneyPoolPayouts[mpid]!.length} moneyPoolPayouts");
      });
      return completer.future;
    } else {
      log.w(
          "Money pool payout stream already listened to, not adding another listener");
    }
  }

  // Get transfers for config. Using this function makes only sense
  // if a listener has been added with addTransferDataListener, seebe low
  List<MoneyPoolPayout> getMoneyPoolPayouts({required String mpid}) {
    if (!moneyPoolPayouts.containsKey(mpid)) {
      log.w(
          "Did not find any payouts for money pool with id $mpid. Please add a listener with 'addMoneyPoolPayoutListener()'. Returning empty list");
      return [];
    } else {
      return moneyPoolPayouts[mpid]!;
    }
  }

  // pause the listener
  void cancelMoneyPoolPayoutListener({required String mpid}) {
    log.v("Pause transfer data listener with config: '$mpid'");
    _moneyPoolPayoutsStreamSubscriptions[mpid]?.cancel();
    _moneyPoolPayoutsStreamSubscriptions[mpid] = null;
  }

  ///////////////////////////////////////////////
  ///
  /// Helpers

  /// Return list with removed duplicates
  List<MoneyTransfer> getMoneyTransfersWithUniqueSender(
      List<MoneyTransfer> transfer) {
    List<MoneyTransfer> returnTransfers = [];
    transfer.forEach((element) {
      if (!returnTransfers.any((returnElement) =>
          returnElement.transferDetails.recipientId ==
          element.transferDetails.recipientId)) returnTransfers.add(element);
    });
    return returnTransfers;
  }

  bool isValidFirestoreQueryConfig({required MoneyTransferQueryConfig config}) {
    if (config.isEqualToFilter != null && config.isEqualToFilter!.length > 1)
      return false;
    if (config.type == TransferType.Invalid) return false;
    return true;
  }

  // helper function that figures out transaction
  // type based on transaction data
  TransferType inferTransactionType({required MoneyTransfer transfer}) {
    if (transfer is MoneyPoolPayout) {
      return TransferType.MoneyPoolPayout;
    } else if (transfer is MoneyTransfer) {
      TransferType direction = transfer.maybeMap(
        // peer 2 peer transaction could go in 3 directions
        peer2peer: (value) {
          if (value.transferDetails.senderId ==
              value.transferDetails.recipientId) {
            return TransferType.Commitment;
          }
          if (value.transferDetails.senderId == currentUser.uid) {
            return TransferType.Peer2PeerSent;
          }
          if (value.transferDetails.recipientId == currentUser.uid) {
            return TransferType.Peer2PeerReceived;
          }
          log.wtf(
              "Found unknown type of transaction data. This should never happen, please check your code!");
          return TransferType.Invalid;
        },
        donation: (value) => TransferType.Donation,
        moneyPoolContribution: (value) => TransferType.MoneyPoolContribution,
        moneyPoolPayoutTransfer: (value) =>
            TransferType.MoneyPoolPayoutTransfer,
        orElse: () => TransferType.Invalid,
      );
      log.v("Inferred transaction direction: $direction");
      return direction;
    } else {
      log.wtf(
          "Found unknown type of transaction data. This should never happen, please check your code!");
      return TransferType.Invalid;
    }
  }

  //////////////////////////
  /// clean-up
  ///
  void clearData() {
    _moneyPoolPayoutsStreamSubscriptions.forEach((key, value) {
      value?.cancel();
    });
    _moneyPoolPayoutsStreamSubscriptions.clear();

    // cancel all listeners and reset list
    _transfersSubscriptions.forEach((key, value) {
      value?.cancel();
    });
    _transfersSubscriptions.clear();

    log.i("Cleared lists of money pools");
  }
}
