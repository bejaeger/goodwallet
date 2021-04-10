import 'dart:async';

import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/causes/good_wallet_project_model.dart';
import 'package:good_wallet/datamodels/payments/wallet_balances_model.dart';
import 'package:good_wallet/services/globalgiving/global_giving_api_service.dart';
import 'package:good_wallet/services/userdata/user_data_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';

class WalletViewModel extends BaseModel {
  final NavigationService? _navigationService = locator<NavigationService>();
  final UserDataService? _userDataService = locator<UserDataService>();
  final GlobalGivingAPIService? _ggApiService =
      locator<GlobalGivingAPIService>();

  final log = getLogger("wallet_viewmodel.dart");

  // subscriptions to listen to wallet data and transaction history
  StreamSubscription? _transactionSubscription;

  // objects to be exposed
  List<dynamic>? _transactions;
  List<dynamic>? get transactions => _transactions;
  WalletBalancesModel _wallet = WalletBalancesModel.empty();
  WalletBalancesModel get wallet => _wallet;

  // projects to be exposed
  List<GoodWalletProjectModel>? _projects;
  List<GoodWalletProjectModel>? get projects => _projects;

  void listenToTransactions() {
    // Listen to transaction collection if user is logged in otherwise cancel
    // subscription
    // Function to be called in initialization of viewmodel or on onModelReady
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
                updatedTransactions
                    .sort((a, b) => b.createdAt.compareTo(a.createdAt));
                _transactions = updatedTransactions;
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
  }

  // Make a stream listening to projects!
  Future getProjects() async {
    List<GoodWalletProjectModel> newProjects = [];
    var newProject = await _ggApiService!.getRandomProject();
    if (newProject != null) {
      newProjects.add(newProject);
    }
    var newProject2 = await _ggApiService!.getRandomProject();
    if (newProject2 != null) {
      newProjects.add(newProject2);
    }
    var newProject3 = await _ggApiService!.getRandomProject();
    if (newProject3 != null) {
      newProjects.add(newProject3);
    }
    _projects = newProjects;
    notifyListeners();
  }

  Future navigateToSendMoneyView() async {
    await _navigationService!.navigateTo(Routes.sendMoneyView);
  }

  Future navigateToWelcomeView() async {
    await _navigationService!.navigateTo(Routes.welcomeView);
  }

  Future navigateToDonationView() async {
    await _navigationService!.navigateTo(Routes.donationView);
  }
}
