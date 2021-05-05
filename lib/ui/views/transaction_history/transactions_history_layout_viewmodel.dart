import 'dart:async';

import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/transactions/transaction.dart';
import 'package:good_wallet/enums/transaction_direction.dart';
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

  num getAmount(Transaction data) {
    return data.map(
        peer2peer: (value) => value.transactionDetails.amount,
        donation: (value) => value.transactionDetails.amount,
        moneyPoolContribution: (value) => value.transactionDetails.amount,
        moneyPoolPayout: (value) => value.transactionsDetails
            .where((e) => e.recipientId == currentUser.id)
            .first
            .amount);
  }

  Future<void> initialize([TransactionDirection? type]) async {
    setBusy(true);
    if (type == null) {
      //await listenToWalletTransactions();
      await fetchListOfDonations();
      await fetchListOfTransactionsToPeers();
      await fetchListOfIncomingTransactions();
      await buildListOfWalletTransactions();
    } else if (type == TransactionDirection.Donation) {
      await fetchListOfDonations();
    } else if (type == TransactionDirection.TransferredToPeers) {
      await fetchListOfTransactionsToPeers();
    } else if (type == TransactionDirection.Incoming) {
      await fetchListOfIncomingTransactions();
    } else if (type == TransactionDirection.InOrOut) {
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
  TransactionDirection inferTransactionType(Transaction transactionData) {
    TransactionDirection direction = transactionData.maybeMap(
        peer2peer: (value) {
          if (value.transactionDetails.senderId == currentUser.id &&
              value.transactionDetails.senderId == currentUser.id) {
            return TransactionDirection.Committed;
          }
          if (value.transactionDetails.senderId == currentUser.id) {
            return TransactionDirection.TransferredToPeers;
          }
          if (value.transactionDetails.recipientId == currentUser.id) {
            return TransactionDirection.ReceivedFromPeers;
          }
          return TransactionDirection.Invalid;
        },
        donation: (value) => TransactionDirection.Donation,
        moneyPoolContribution: (value) =>
            TransactionDirection.MoneyPoolContribution,
        moneyPoolPayout: (value) => TransactionDirection.MoneyPoolPayout,
        orElse: () => TransactionDirection.Invalid);
    log.v("Inferred transaction direction: $direction");
    return direction;
  }

  void navigateBack() => _navigationService!.back();

  List<dynamic>? getTransactionsCorrespondingToType(TransactionDirection type) {
    if (type == TransactionDirection.Donation) {
      return listOfDonations;
    } else if (type == TransactionDirection.Incoming) {
      return listOfIncomingTransactions;
    } else if (type == TransactionDirection.TransferredToPeers) {
      return listOfTransactionsToPeers;
    } else if (type == TransactionDirection.InOrOut) {
      return listOfWalletTransactions;
    }
    return null;
  }

  num getBalanceCorrespondingToType(TransactionDirection type) {
    if (type == TransactionDirection.Donation) {
      return userWallet.donations;
    } else if (type == TransactionDirection.Incoming) {
      return userWallet.raised;
    } else if (type == TransactionDirection.TransferredToPeers) {
      return userWallet.transferredToPeers;
    } else if (type == TransactionDirection.InOrOut) {
      return userWallet.currentBalance;
    } else {
      return -1;
    }
  }

  String getTitleCorrespondingToType(TransactionDirection type) {
    if (type == TransactionDirection.Donation) {
      return "Total Donations";
    } else if (type == TransactionDirection.Incoming) {
      return "Total Raised";
    } else if (type == TransactionDirection.TransferredToPeers) {
      return "Total Gifted";
    } else if (type == TransactionDirection.InOrOut) {
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
