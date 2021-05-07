import 'dart:async';

import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/money_pools/payouts/money_pool_payout.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
import 'package:good_wallet/enums/transfer_direction.dart';
import 'package:good_wallet/services/userdata/user_data_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';

class TransactionHistoryLayoutViewModel extends BaseModel {
  final NavigationService? _navigationService = locator<NavigationService>();
  final UserDataService? _userDataService = locator<UserDataService>();

  final log = getLogger("transactions_history_layout_viewmodel.dart");

  // will be fetched from firestore
  List<dynamic> listOfDonations = <dynamic>[];
  List<dynamic> listOfIncomingTransactions = <dynamic>[];
  List<dynamic> listOfTransactionsToPeers = <dynamic>[];
  List<dynamic> listOfWalletTransactions = <dynamic>[];

  // subscriptions to listen to transaction history of payments collection
  // payments into the users Good Wallet as well as payments
  // of the user into someone else's GW
  StreamSubscription? _transactionSubscription;
  List<dynamic>? transactions;

  // subscriptions to listen to transactions in and out of wallet
  // incoming money into the wallet and donations
  StreamSubscription? _walletTransactionSubscription;
  List<dynamic>? walletTransactions;

  @override
  void dispose() {
    _transactionSubscription?.cancel();
    _walletTransactionSubscription?.cancel();
    super.dispose();
  }

  num getAmount(dynamic data) {
    if (data is MoneyPoolPayout) {
      return data.transfersDetails
          .where((details) => details.recipientId == currentUser.id)
          .first
          .amount;
    } else {
      return data.map(
          peer2peer: (value) => value.transferDetails.amount,
          donation: (value) => value.transferDetails.amount,
          moneyPoolContribution: (value) => value.transferDetails.amount);
    }
  }

  Future<void> initialize([TransferDirection? type]) async {
    setBusy(true);
    if (type == null) {
      //await listenToWalletTransactions();
      await fetchListOfDonations();
      await fetchListOfTransactionsToPeers();
      await fetchListOfIncomingTransactions();
      await buildListOfWalletTransactions();
    } else if (type == TransferDirection.Donation) {
      await fetchListOfDonations();
    } else if (type == TransferDirection.TransferredToPeers) {
      await fetchListOfTransactionsToPeers();
    } else if (type == TransferDirection.Incoming) {
      await fetchListOfIncomingTransactions();
    } else if (type == TransferDirection.InOrOut) {
      await buildListOfWalletTransactions();
    }
    setBusy(false);
  }

  Future buildListOfWalletTransactions() async {
    List<dynamic> newListOfWalletTransactions = <dynamic>[];
    var outgoing = await _userDataService!.getListOfDonations();
    var incoming = await _userDataService!.getListOfIncomingTransactions();
    var moneyPools = await _userDataService!.getListOfMoneyPoolPayouts();

    newListOfWalletTransactions.addAll(outgoing);
    newListOfWalletTransactions.addAll(incoming);
    try {
      newListOfWalletTransactions
          .sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } catch (e) {
      log.e(
          "List of transactions could not be sorted properly! Possibly the field createdAt is missing! Check transactions in the backend!");
    }
    newListOfWalletTransactions.addAll(moneyPools);

    listOfWalletTransactions = newListOfWalletTransactions;
    log.i(
        "Fetched list of in/out transactions with length = ${listOfWalletTransactions.length}");
  }

  Future fetchListOfDonations() async {
    listOfDonations = await _userDataService!.getListOfDonations();
    log.i("Fetched list of donations with length = ${listOfDonations.length}");
  }

  Future fetchListOfIncomingTransactions() async {
    List<dynamic> newListOfTransactions = <dynamic>[];
    var fromPeers = await _userDataService!.getListOfIncomingTransactions();
    var moneyPools = await _userDataService!.getListOfMoneyPoolPayouts();

    newListOfTransactions.addAll(fromPeers);
    newListOfTransactions.addAll(moneyPools);
    listOfIncomingTransactions = newListOfTransactions;
    //TODO: Sort by date!
    log.i(
        "Fetched list of incoming transfers with length = ${listOfIncomingTransactions.length}");
  }

  Future fetchListOfTransactionsToPeers() async {
    listOfTransactionsToPeers =
        await _userDataService!.getListOfTransactionsToPeers();
    log.i(
        "Fetched list of transfers to peers with length = ${listOfTransactionsToPeers.length}");
  }

  // helper function that figures out transaction
  // type based on transaction data
  TransferDirection inferTransactionType(dynamic transactionData) {
    if (transactionData is MoneyPoolPayout) {
      return TransferDirection.MoneyPoolPayout;
    } else if (transactionData is MoneyTransfer) {
      TransferDirection direction = transactionData.maybeMap(
          // peer 2 peer transaction could go in 3 directions
          peer2peer: (value) {
            if (value.transferDetails.senderId == currentUser.id &&
                value.transferDetails.senderId == currentUser.id) {
              return TransferDirection.Committed;
            }
            if (value.transferDetails.senderId == currentUser.id) {
              return TransferDirection.TransferredToPeers;
            }
            if (value.transferDetails.recipientId == currentUser.id) {
              return TransferDirection.ReceivedFromPeers;
            }
            log.wtf(
                "Found unknown type of transaction data. This should never happen, please check your code!");

            return TransferDirection.Invalid;
          },
          donation: (value) => TransferDirection.Donation,
          moneyPoolContribution: (value) =>
              TransferDirection.MoneyPoolContribution,
          orElse: () => TransferDirection.Invalid);
      log.v("Inferred transaction direction: $direction");
      return direction;
    } else {
      log.wtf(
          "Found unknown type of transaction data. This should never happen, please check your code!");
      return TransferDirection.Invalid;
    }
  }

  void navigateBack() => _navigationService!.back();

  List<dynamic>? getTransactionsCorrespondingToType(TransferDirection type) {
    if (type == TransferDirection.Donation) {
      return listOfDonations;
    } else if (type == TransferDirection.Incoming) {
      return listOfIncomingTransactions;
    } else if (type == TransferDirection.TransferredToPeers) {
      return listOfTransactionsToPeers;
    } else if (type == TransferDirection.InOrOut) {
      return listOfWalletTransactions;
    }
    return null;
  }

  num getBalanceCorrespondingToType(TransferDirection type) {
    if (type == TransferDirection.Donation) {
      return userWallet.donations;
    } else if (type == TransferDirection.Incoming) {
      return userWallet.raised;
    } else if (type == TransferDirection.TransferredToPeers) {
      return userWallet.transferredToPeers;
    } else if (type == TransferDirection.InOrOut) {
      return userWallet.currentBalance;
    } else {
      return -1;
    }
  }

  String getTitleCorrespondingToType(TransferDirection type) {
    if (type == TransferDirection.Donation) {
      return "Total Donations";
    } else if (type == TransferDirection.Incoming) {
      return "Total Raised";
    } else if (type == TransferDirection.TransferredToPeers) {
      return "Total Gifted";
    } else if (type == TransferDirection.InOrOut) {
      return "Good Wallet Balance";
    } else
      return "";
  }

  //===================================================
  // The following is deprecated for now, we don't use streams
  // but fetch the transaction info once! To be revisited
  // when adding pagination!

  Future listenToTransactions() async {
    // Listen to transaction collection if user is logged in otherwise cancel
    // subscription
    // Function to be called in initialization of viewmodel or in onModelReady

    setBusy(true);
    _userDataService!.userStateSubject.listen(
      (state) {
        if (isUserSignedIn) {
          _transactionSubscription =
              _userDataService!.listenToTransactionsRealTime().listen(
            (transactionsData) {
              List<dynamic> updatedTransactions = transactionsData;
              if (updatedTransactions != null &&
                  updatedTransactions.length > 0) {
                log.i("Start listening to user wallet data");
                // sort with date
                // add try/catch phrase cause this is risky
                updatedTransactions
                    .sort((a, b) => b.createdAt.compareTo(a.createdAt));
                transactions = updatedTransactions;
                notifyListeners();
              } else {
                log.w(
                    "Not able to listen to transaction data. Maybe there are no transactions for that user recorded yet?");
              }
            },
          );
        } else {
          log.i("Cancelling subsciption to listen to user transactions");
          _transactionSubscription?.cancel();
        }
      },
    );
    setBusy(false);
  }

  Future listenToWalletTransactions() async {
    setBusy(true);

    // Listen to transaction collection if user is logged in otherwise cancel
    // subscription
    // Function to be called in initialization of viewmodel or on onModelReady
    _userDataService!.userStateSubject.listen(
      (state) {
        if (isUserSignedIn) {
          _walletTransactionSubscription =
              _userDataService!.listenToWalletTransactionsRealTime().listen(
            (transactionsData) {
              List<dynamic> updatedTransactions = transactionsData;
              if (updatedTransactions != null &&
                  updatedTransactions.length > 0) {
                log.i("Start listening to user wallet data");
                // sort with date
                updatedTransactions
                    .sort((a, b) => b.createdAt.compareTo(a.createdAt));
                walletTransactions = updatedTransactions;
                notifyListeners();
              } else {
                log.w(
                    "Not able to listen to transaction data. Maybe there are no transactions for that user recorded yet?");
              }
            },
          );
        } else {
          log.i("Cancelling subsciption to listen to user transactions");
          _walletTransactionSubscription?.cancel();
        }
      },
    );
    setBusy(false);
  }
}
