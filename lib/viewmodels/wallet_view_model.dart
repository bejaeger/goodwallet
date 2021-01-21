import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:good_wallet/app/locator.dart';
import 'package:good_wallet/app/router.gr.dart';
import 'package:good_wallet/datamodels/transaction_model.dart';
import 'package:good_wallet/enums/user_status.dart';
import 'package:good_wallet/services/authentification/authentification_service.dart';
import 'package:good_wallet/services/finances/firestore_payment_data_service.dart';
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

  List<dynamic> _transactions;
  List<dynamic> get transactions => _transactions;

  void listenToTransactions() {
    // Sort transactions and add them to _transactions
    if (userStatus == UserStatus.SignedIn) {
      setBusy(true);
      _firestorePaymentDataService
          .listenToTransactionsRealTime(currentUser.id)
          .listen((transactionsData) {
        List<dynamic> updatedTransactions = transactionsData;
        if (updatedTransactions != null && updatedTransactions.length > 0) {
          // sort with date
          updatedTransactions
              .sort((a, b) => b.createdAt.compareTo(a.createdAt));
          _transactions = updatedTransactions;
          notifyListeners();
        }
      });

      setBusy(false);
    }
  }

  // Future navigateToSendMoneyView() async {
  //   await _navigationService.navigateTo(Routes.sendMoneyView);
  // }

  Future updateBalances() async {
    if (userStatus == UserStatus.SignedIn) {
      _userWalletService.updateBalancesLocal(currentUser.id);
      super.notifyListeners();
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
