import 'dart:async';

import 'package:good_wallet/app/locator.dart';
import 'package:good_wallet/app/router.gr.dart';
import 'package:good_wallet/enums/user_status.dart';
import 'package:good_wallet/services/authentification/authentification_service.dart';
import 'package:good_wallet/services/payments/firestore_payment_data_service.dart';
import 'package:good_wallet/services/userdata/firestore_user_service.dart';
import 'package:good_wallet/services/userdata/wallet_client_service.dart';
import 'package:good_wallet/viewmodels/base_model.dart';
import 'package:stacked_services/stacked_services.dart';

class WalletViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final UserWalletService _userWalletService = locator<UserWalletService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final FirestorePaymentDataService _firestorePaymentDataService =
      locator<FirestorePaymentDataService>();
  final FirestoreUserService _firestoreUserService =
      locator<FirestoreUserService>();

  StreamSubscription _transactionSubscription;
  StreamSubscription _balanceSubscription;

  List<dynamic> _transactions;
  List<dynamic> get transactions => _transactions;

  double _balance = 0.0;
  double get thisbalance => _balance;

  Future listenToTransactions() async {
    _authenticationService.userStateSubject.listen(
      (state) {
        if (state.status == UserStatus.SignedIn) {
          setBusy(true);
          _transactionSubscription = _firestorePaymentDataService
              .listenToTransactionsRealTime(currentUser.id)
              .listen(
            (transactionsData) {
              print("INFO: Listen to transactions");
              List<dynamic> updatedTransactions = transactionsData;
              if (updatedTransactions != null &&
                  updatedTransactions.length > 0) {
                // sort with date
                updatedTransactions
                    .sort((a, b) => b.createdAt.compareTo(a.createdAt));
                _transactions = updatedTransactions;
                notifyListeners();
              }
            },
          );
          setBusy(false);
        } else {
          print("INFO: Cancelling transaction subscription");
          _transactionSubscription?.cancel();
        }
      },
    );
  }

  Future listenToBalance() async {
    _authenticationService.userStateSubject.listen(
      (state) {
        if (state.status == UserStatus.SignedIn) {
          setBusy(true);
          _balanceSubscription = _firestoreUserService
              .listenToBalanceRealTime(currentUser.id)
              .listen(
            (balance) {
              print("INFO: Listen to balance");
              if (balance != null) {
                print("Balance: $balance");
                _balance = balance;
                notifyListeners();
              }
            },
          );
          setBusy(false);
        } else {
          print("INFO: Cancelling balance subscription");
          _balanceSubscription?.cancel();
        }
      },
    );
  }

  Future navigateToSendMoneyView() async {
    await _navigationService.navigateTo(Routes.sendMoneyView);
  }

  Future navigateToWelcomeView() async {
    await _navigationService.navigateTo(Routes.welcomeView);
  }

  Future updateBalances() async {
    if (userStatus == UserStatus.SignedIn) {
      _userWalletService.updateBalancesLocal(currentUser.id);
      notifyListeners();
    }
  }

  Future loginWithGoogle() async {
    setBusy(true);
    var result = await _authenticationService.loginWithGoogle();
    if (!result) print("WARNING: Failed logging in user!");
    notifyListeners();
    setBusy(false);
  }
}
