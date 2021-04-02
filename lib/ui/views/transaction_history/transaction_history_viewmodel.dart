import 'dart:async';

import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/enums/transaction_type.dart';
import 'package:good_wallet/services/userdata/user_data_service.dart';
import 'package:good_wallet/style/transactions_history_entry_style.dart';
import 'package:good_wallet/ui/shared/transactions_history_entry_style.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

class TransactionHistoryViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final UserDataService _userDataService = locator<UserDataService>();

  // will be fetched from firestore
  List<dynamic> listOfDonations = <dynamic>[];
  List<dynamic> listOfIncomingTransactions = <dynamic>[];
  List<dynamic> listOfTransactionsToPeers = <dynamic>[];
  List<dynamic> listOfWalletTransactions = <dynamic>[];

  // subscriptions to listen to transaction history of payments collection
  // payments into the users Good Wallet as well as payments
  // of the user into someone else's GW
  StreamSubscription _transactionSubscription;
  List<dynamic> transactions;

  // subscriptions to listen to transactions in and out of wallet
  // incoming money into the wallet and donations
  StreamSubscription _walletTransactionSubscription;
  List<dynamic> walletTransactions;

  @override
  void dispose() {
    _transactionSubscription?.cancel();
    _walletTransactionSubscription?.cancel();
    super.dispose();
  }

  Future<void> initialize([TransactionType type]) async {
    setBusy(true);
    if (type == null) {
      //await listenToWalletTransactions();
      await fetchListOfDonations();
      await fetchListOfTransactionsToPeers();
      await fetchListOfIncomingTransactions();
      await buildListOfWalletTransactions();
    } else if (type == TransactionType.Donation) {
      fetchListOfDonations();
    } else if (type == TransactionType.TransferredToPeers) {
      fetchListOfTransactionsToPeers();
    } else if (type == TransactionType.Incoming) {
      fetchListOfIncomingTransactions();
    } else if (type == TransactionType.InOrOut) {
      buildListOfWalletTransactions();
    }
    setBusy(false);
    notifyListeners();
  }

  Future buildListOfWalletTransactions() async {
    List<dynamic> newListOfWalletTransactions = <dynamic>[];
    var outgoing = await _userDataService.getListOfDonations();
    var incoming = await _userDataService.getListOfIncomingTransactions();
    newListOfWalletTransactions.addAll(outgoing);
    newListOfWalletTransactions.addAll(incoming);
    try {
      newListOfWalletTransactions
          .sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } catch (e) {
      log.e(
          "List of transactions could not be sorted properly! Possibly the field createdAt is missing! Check transactions in the backend!");
    }
    listOfWalletTransactions = newListOfWalletTransactions;
    log.i(
        "Fetched list of in/out transactions with length = ${listOfWalletTransactions.length}");
  }

  Future fetchListOfDonations() async {
    listOfDonations = await _userDataService.getListOfDonations();
    log.i("Fetched list of donations with length = ${listOfDonations.length}");
  }

  Future fetchListOfIncomingTransactions() async {
    listOfIncomingTransactions =
        await _userDataService.getListOfIncomingTransactions();
    log.i(
        "Fetched list of incoming transfers with length = ${listOfIncomingTransactions.length}");
  }

  Future fetchListOfTransactionsToPeers() async {
    listOfTransactionsToPeers =
        await _userDataService.getListOfTransactionsToPeers();
    log.i(
        "Fetched list of transfers to peers with length = ${listOfTransactionsToPeers.length}");
  }

  TransactionType inferTransactionType(dynamic transactionData) {
    // helper function that figures out transaction
    // type based on transaction data

    // TODO: Add logic for top-up

    TransactionType type;
    var tmpVar;
    try {
      tmpVar = transactionData.recipientUid;
      var incoming = (transactionData.recipientUid == currentUser.id);
      type = incoming
          ? TransactionType.Incoming
          : TransactionType.TransferredToPeers;
    } catch (e) {
      tmpVar = transactionData
          .projectName; // only applicable if the transaction is a donation, i.e. outgoing
      type = TransactionType.Donation;
    }
    if (type == null) {
      log.e(
          "Could not find type of transaction data, returning TransactionType.Invalid");
      return TransactionType.Invalid;
    }
    return type;
  }

  void navigateBack() => _navigationService.back();

  TransactionHistoryEntryStyle getTransactionsHistoryEntryStyle(dynamic data) {
    // function that retrieves the style for an entry in a transactions history
    // First, it figures out the type of transaction, then the style is retrieved

    TransactionType type = inferTransactionType(data);
    // top-level function to get style (to avoid defining styles in viewmodels)
    TransactionHistoryEntryStyle style =
        getTransactionsHistoryEntryStyleFromType(type, data);
    if (style == null) {
      log.e("Could not find proper style for transaction list tile!");
    }
    return style;
  }

  List<dynamic> getTransactions(TransactionType type) {
    if (type == TransactionType.Donation) {
      return listOfDonations;
    } else if (type == TransactionType.Incoming) {
      return listOfIncomingTransactions;
    } else if (type == TransactionType.TransferredToPeers) {
      return listOfTransactionsToPeers;
    } else if (type == TransactionType.InOrOut) {
      return listOfWalletTransactions;
    }
    return null;
  }

  num getBalanceStringCorrespondingToType(TransactionType type) {
    if (type == TransactionType.Donation) {
      return userWallet.donations;
    } else if (type == TransactionType.Incoming) {
      return 0;
    } else if (type == TransactionType.TransferredToPeers) {
      return userWallet.transferredToPeers;
    } else if (type == TransactionType.InOrOut) {
      return userWallet.currentBalance;
    }
    return null;
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
    _userDataService.userStateSubject.listen(
      (state) {
        if (isUserSignedIn) {
          _transactionSubscription =
              _userDataService.listenToTransactionsRealTime().listen(
            (transactionsData) {
              List<dynamic> updatedTransactions = transactionsData;
              if (updatedTransactions != null &&
                  updatedTransactions.length > 0) {
                log.i("Start listening to user wallet data");
                // sort with date
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
    _userDataService.userStateSubject.listen(
      (state) {
        if (isUserSignedIn) {
          _walletTransactionSubscription =
              _userDataService.listenToWalletTransactionsRealTime().listen(
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
