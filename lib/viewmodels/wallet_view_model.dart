import 'dart:async';

import 'package:good_wallet/app/locator.dart';
import 'package:good_wallet/app/router.gr.dart';
import 'package:good_wallet/datamodels/goodcauses/global_giving_project_model.dart';
import 'package:good_wallet/datamodels/payments/wallet_balances_model.dart';
import 'package:good_wallet/enums/user_status.dart';
import 'package:good_wallet/services/authentification/authentification_service.dart';
import 'package:good_wallet/services/globalgiving/global_giving_api_service.dart';
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
  final GlobalGivingAPIService _ggApiService =
      locator<GlobalGivingAPIService>();

  StreamSubscription _transactionSubscription;
  StreamSubscription _balanceSubscription;

  List<dynamic> _transactions;
  List<dynamic> get transactions => _transactions;

  WalletBalancesModel _wallet = WalletBalancesModel.empty();
  WalletBalancesModel get wallet => _wallet;

  List<GlobalGivingProjectModel> _projects;
  List<GlobalGivingProjectModel> get projects => _projects;

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

  Future listenToBalances() async {
    _authenticationService.userStateSubject.listen(
      (state) {
        if (state.status == UserStatus.SignedIn) {
          setBusy(true);
          _balanceSubscription = _firestoreUserService
              .listenToBalanceRealTime(currentUser.id)
              .listen(
            (walletData) {
              print("INFO: Listen to balance");
              if (walletData != null) {
                _wallet = walletData;
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

  // Make a stream listening to projects!
  Future getProjects() async {
    List<GlobalGivingProjectModel> newProjects = [];
    var newProject = await _ggApiService.getRandomProject();
    if (newProject != null) {
      newProjects.add(newProject);
    }
    var newProject2 = await _ggApiService.getRandomProject();
    if (newProject2 != null) {
      newProjects.add(newProject2);
    }
    _projects = newProjects;
    notifyListeners();
  }

  Future navigateToSendMoneyView() async {
    await _navigationService.navigateTo(Routes.sendMoneyView);
  }

  Future navigateToWelcomeView() async {
    await _navigationService.navigateTo(Routes.welcomeView);
  }

  Future navigateToDonationView() async {
    await _navigationService.navigateTo(Routes.donationView);
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
