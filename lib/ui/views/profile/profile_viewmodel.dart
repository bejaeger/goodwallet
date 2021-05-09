import 'dart:async';

import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/enums/transfer_direction.dart';
import 'package:good_wallet/services/userdata/user_data_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfileViewModel extends BaseModel {
  final NavigationService? _navigationService = locator<NavigationService>();
  final UserDataService? _userDataService = locator<UserDataService>();

  Future logout() async {
    setBusy(true);
    await _userDataService!.handleLogoutEvent();
    await navigateToLoginView();
    setBusy(false);
  }

  Future navigateToLoginView() async {
    _navigationService!.replaceWith(Routes.loginView);
  }

  Future navigateToDonationsHistoryView() async {
    _navigationService!.navigateTo(Routes.transfersHistoryView);
  }

  Future navigateToTransactionsHistoryView() async {
    _navigationService!.navigateTo(Routes.transfersHistoryView);
  }

  Future navigateToManageMoneyPoolsView() async {
    _navigationService!.navigateTo(Routes.moneyPoolsView);
  }

  void navigateBack() => _navigationService!.back();
}
