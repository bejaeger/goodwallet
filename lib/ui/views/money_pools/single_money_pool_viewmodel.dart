import 'package:flutter/material.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/money_pools/money_pool_model.dart';
import 'package:good_wallet/datamodels/user/public_user_info.dart';
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

  List<PublicUserInfo> invitedUsers = [];
  List<ContributingUser> contributingUsers = [];

  late final MoneyPoolModel _moneyPool;
  void setMoneyPool(MoneyPoolModel moneyPool) {
    _moneyPool = moneyPool;
  }

  Future fetchUserContributions([bool force = false]) async {
    setBusy(true);
    if (invitedUsers.isEmpty || force) {
      invitedUsers =
          await _moneyPoolService!.getInvitedUsers(_moneyPool.moneyPoolId!);
    }
    if (contributingUsers.isEmpty || force) {
      contributingUsers = await _moneyPoolService!
          .getContributingUsers(_moneyPool.moneyPoolId!);
    }
    setBusy(false);
  }

  Future deleteMoneyPool(String poolId) async {
    setBusy(true);
    _navigationService!.clearStackAndShow(
      Routes.layoutTemplateViewMobile,
    );
    await _moneyPoolService!.deleteMoneyPool(poolId);
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
        if (invitedUsers.any((element) => element.uid == userInfo.uid)) {
          messageToShow = "User has already been invited.";
        } else if (contributingUsers
            .any((element) => element.uid == userInfo.uid)) {
          messageToShow = "User participates already in money pool.";
        } else {
          // push to firestore
          await _moneyPoolService!
              .addInviteUserDocument(_moneyPool.moneyPoolId!, userInfo);
          // Delay makes it look more user friendly
          await Future.delayed(Duration(milliseconds: 1000));
          // add to invitedUsers
          invitedUsers.add(userInfo);
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

  // Future inviteUser(PublicUserInfo userInfo) async {
  //   // TODO: Reconsider public user info and QRCodeuserinfo and so on!
  //   // This is confusing!
  //   //
  //   MoneyPoolModel moneyPool = MoneyPoolModel(
  //       invitedUsers: [ContributingUser(uid: "DUMMY", name: userInfo.name)]);
  //   try {
  //     await _moneyPoolService!.updateMoneyPool(moneyPool);
  //   } catch (e) {
  //     log.e(
  //         "Failed to update money pool with ${moneyPool.toJson()}, error thrown: ${e.toString()}");
  //     rethrow;
  //   }
  // }
  //
}
