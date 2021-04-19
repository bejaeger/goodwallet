import 'package:flutter/material.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/services/money_pools/money_pool_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

class SingleMoneyPoolViewModel extends BaseModel {
  final MoneyPoolService? _moneyPoolService = locator<MoneyPoolService>();
  final NavigationService? _navigationService = locator<NavigationService>();

  Future deleteMoneyPool(String poolId) async {
    setBusy(true);
    _navigationService!.clearStackAndShow(
      Routes.layoutTemplateViewMobile,
    );
    await _moneyPoolService!.deleteMoneyPool(poolId);
    setBusy(false);
  }

  void navigateBack() {
    _navigationService!.back();
  }
}
