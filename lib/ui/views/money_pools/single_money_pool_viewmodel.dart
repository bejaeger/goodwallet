import 'package:flutter/material.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/money_pools/money_pool_contribution.dart';
import 'package:good_wallet/datamodels/money_pools/money_pool_model.dart';
import 'package:good_wallet/datamodels/user/public_user_info.dart';
import 'package:good_wallet/enums/bottom_navigator_index.dart';
import 'package:good_wallet/enums/fund_transfer_type.dart';
import 'package:good_wallet/enums/search_type.dart';
import 'package:good_wallet/services/money_pools/money_pool_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';

class SingleMoneyPoolViewModel extends BaseModel {
  final MoneyPoolService? _moneyPoolService = locator<MoneyPoolService>();
  final NavigationService? _navigationService = locator<NavigationService>();
  final SnackbarService? _snackbarService = locator<SnackbarService>();

  final log = getLogger("single_money_pool_viewmodel.dart");

  List<MoneyPoolContributionModel> contributions = [];

  MoneyPoolModel moneyPool;
  SingleMoneyPoolViewModel({required this.moneyPool});

  Future fetchUserContributions([bool force = false]) async {
    setBusy(true);
    if (contributions.isEmpty || force) {
      contributions = await _moneyPoolService!
          .getMoneyPoolContributions(moneyPool.moneyPoolId!);
    }
    setBusy(false);
  }

  Future deleteMoneyPool(String poolId) async {
    setBusy(true);
    await _moneyPoolService!.deleteMoneyPool(poolId);
    _navigationService!.clearStackAndShow(Routes.layoutTemplateViewMobile,
        arguments: LayoutTemplateViewMobileArguments(
            initialBottomNavBarIndex: BottomNavigatorIndex.RaiseMoney.index));
    setBusy(false);
  }

  void showSearchViewAndInviteUser(MoneyPoolModel currentMoneyPool) async {
    setBusy(true);
    String? messageToShow;
    dynamic userInfo = await _navigationService!.navigateTo(Routes.searchView,
        arguments:
            SearchViewArguments(searchType: SearchType.userToInviteToMP));
    if (userInfo is PublicUserInfo) {
      log.i(
          "Selected user to invite to money pool with name ${userInfo.name}!");
      try {
        if (currentMoneyPool.invitedUserIds
            .any((element) => element == userInfo.uid)) {
          messageToShow = "User has already been invited.";
        } else if (currentMoneyPool.contributingUserIds
            .contains(userInfo.uid)) {
          messageToShow = "User participates already in money pool.";
        } else {
          // push to firestore
          await _moneyPoolService!.addInvitedUserToMoneyPool(
              userInfo: userInfo, moneyPool: currentMoneyPool);

          // Delay makes it look more user friendly
          await Future.delayed(Duration(milliseconds: 1000));
          // add to invitedUsers
          messageToShow = "Invited ${userInfo.name}";
        }
      } catch (e) {
        log.e("Error inviting user: ${e.toString()}");
        messageToShow =
            "Error! An error occured when inviting the user, please contact support.";
      }
    }
    if (messageToShow != null) {
      _snackbarService!.showSnackbar(title: messageToShow, message: "");
    }
    setBusy(false);
    notifyListeners();
  }

  Future navigateToTransferFundAmountView(dynamic moneyPool) async {
    await _navigationService!.navigateTo(Routes.transferFundsAmountView,
        arguments: TransferFundsAmountViewArguments(
            type: FundTransferType.moneyPoolContributionFromBank,
            receiverInfo: moneyPool));
  }

  // update money pool
  Future updateMoneyPool() async {
    this.moneyPool =
        await _moneyPoolService!.getMoneyPool(moneyPool.moneyPoolId!);

    // can already be done for transfer_view
    contributions = await _moneyPoolService!
        .getMoneyPoolContributions(moneyPool.moneyPoolId!);
    notifyListeners();
  }
}
