import 'dart:async';

import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/causes/project.dart';
import 'package:good_wallet/apis/global_giving_api.dart';
import 'package:good_wallet/services/user/user_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';

class WalletViewModel extends BaseModel {
  final NavigationService? _navigationService = locator<NavigationService>();
  final GlobalGivingApi? _ggApiService = locator<GlobalGivingApi>();

  final log = getLogger("wallet_viewmodel.dart");

  // subscriptions to listen to wallet data and transaction history
  StreamSubscription? _transactionSubscription;

  // objects to be exposed
  List<dynamic>? _transactions;
  List<dynamic>? get transactions => _transactions;

  // projects to be exposed
  List<Project>? _projects;
  List<Project>? get projects => _projects;

  // Make a stream listening to projects!
  Future getProjects() async {
    List<Project> newProjects = [];
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
}
