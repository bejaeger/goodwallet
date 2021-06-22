import 'dart:async';

import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/services/transfers_history/transfers_history_service.dart';
import 'package:good_wallet/services/money_pools/money_pools_service.dart';
import 'package:good_wallet/services/user/user_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfileViewModel extends BaseModel {
  final NavigationService? _navigationService = locator<NavigationService>();
  final UserService? _userService = locator<UserService>();
  final MoneyPoolsService? _moneyPoolsService = locator<MoneyPoolsService>();
  final TransfersHistoryService? _transfersManager =
      locator<TransfersHistoryService>();

  Future logout() async {
    setBusy(true);
    _moneyPoolsService!.clearData();
    _transfersManager!.clearData();
    await _userService!.handleLogoutEvent();
    await navigateToLoginView();
    setBusy(false);
  }

  Future navigateToLoginView() async {
    _navigationService!.replaceWith(Routes.loginView);
  }

  Future navigateToDonationsHistoryView() async {
    _navigationService!.navigateTo(Routes.transfersHistoryView);
  }

  Future navigateToSettingsView() async {
    _navigationService!.navigateTo(Routes.settingsView);
  }

  Future navigateToTransactionsHistoryView() async {
    _navigationService!.navigateTo(Routes.transfersHistoryView);
  }

  Future navigateToManageMoneyPoolsView() async {
    _navigationService!.navigateTo(Routes.moneyPoolsView);
  }

  void navigateBack() => _navigationService!.back();
}
