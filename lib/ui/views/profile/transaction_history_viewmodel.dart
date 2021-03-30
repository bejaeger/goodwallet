import 'dart:async';

import 'package:flutter/material.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/services/userdata/user_data_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

class TransactionHistoryViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final UserDataService _userDataService = locator<UserDataService>();

  // subscriptions to listen to transaction history of payments collection
  // payments into the users Good Wallet as well as payments
  // of the user into someone else's GW
  StreamSubscription _transactionSubscription;
  List<dynamic> transactions;

  // subscriptions to listen to transactions in and out of wallet
  // incoming money into the wallet and donations
  StreamSubscription _walletTransactionSubscription;
  List<dynamic> walletTransactions;

  Future listenToTransactions() async {
    setBusy(true);
    // Listen to transaction collection if user is logged in otherwise cancel
    // subscription
    // Function to be called in initialization of viewmodel or on onModelReady
    Future.delayed(Duration(seconds: 2));
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
    Future.delayed(Duration(seconds: 2));
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

  void navigateBack() => _navigationService.back();
}
