import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/money_pools/base/concise_money_pool_info.dart';
import 'package:good_wallet/datamodels/money_pools/base/money_pool.dart';
import 'package:good_wallet/datamodels/money_pools/payouts/money_pool_payout.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/money_transfer_query_config.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/recipient_info.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/sender_info.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
import 'package:good_wallet/datamodels/user/public_user_info.dart';
import 'package:good_wallet/enums/bottom_navigator_index.dart';
import 'package:good_wallet/enums/money_source.dart';
import 'package:good_wallet/enums/search_type.dart';
import 'package:good_wallet/enums/transfer_type.dart';
import 'package:good_wallet/services/money_pools/money_pool_service.dart';
import 'package:good_wallet/services/userdata/user_data_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';

class SingleMoneyPoolViewModel extends BaseModel {
  final MoneyPoolService? _moneyPoolService = locator<MoneyPoolService>();
  final NavigationService? _navigationService = locator<NavigationService>();
  final SnackbarService? _snackbarService = locator<SnackbarService>();
  final DialogService? _dialogService = locator<DialogService>();
  final UserDataService? _userDataService = locator<UserDataService>();

  final log = getLogger("single_money_pool_viewmodel.dart");

  List<MoneyPoolPayout> payouts = [];

  MoneyTransferQueryConfig _queryConfig =
      MoneyTransferQueryConfig(type: TransferType.Invalid);
  // get latest money pool contributions for send money bottom sheet view
  // Need to add listeners otherwise this will be empty
  // List<MoneyTransfer> get latestContributions =>
  //     _userDataService!.getTransfers(config: _queryConfig);
  Stream<List<MoneyTransfer>> get latestContributions =>
      _userDataService!.getTransferDataStream(config: _queryConfig);

  MoneyPool moneyPool;

  SingleMoneyPoolViewModel({required this.moneyPool}) {
    _queryConfig = _queryConfig.copyWith(
      type: TransferType.MoneyPoolContribution,
      isEqualToFilter: {"moneyPoolInfo.moneyPoolId": moneyPool.moneyPoolId},
    );
    // _userDataService!.addTransferDataListener(
    //     config: _queryConfig, callback: () => notifyListeners());
  }

  Future fetchPayouts([bool force = false]) async {
    setBusy(true);
    if (payouts.isEmpty || force) {
      payouts =
          await _moneyPoolService!.getMoneyPoolPayouts(moneyPool.moneyPoolId);
    }
    // if not done listening the listener callback from the constructor
    // will set the model business false;
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

  void showSearchViewAndInviteUser() async {
    setBusy(true);
    String? messageToShow;
    dynamic userInfo = await _navigationService!.navigateTo(Routes.searchView,
        arguments:
            SearchViewArguments(searchType: SearchType.UserToInviteToMP));
    if (userInfo is PublicUserInfo) {
      log.i(
          "Selected user to invite to money pool with name ${userInfo.name}!");
      try {
        if (moneyPool.invitedUserIds
            .any((element) => element == userInfo.uid)) {
          messageToShow = "User has already been invited.";
        } else if (moneyPool.contributingUserIds.contains(userInfo.uid)) {
          messageToShow = "User participates already in money pool.";
        } else {
          // push to firestore
          await _moneyPoolService!.addInvitedUserToMoneyPool(
              userInfo: userInfo, moneyPool: moneyPool);

          // Delay makes it look more user friendly
          await Future.delayed(Duration(milliseconds: 500));
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
    final recipientInfo = RecipientInfo.moneyPool(
      name: moneyPool.name,
      id: moneyPool.moneyPoolId,
      moneyPoolInfo: ConciseMoneyPoolInfo(
          total: moneyPool.total,
          name: moneyPool.name,
          moneyPoolId: moneyPool.moneyPoolId),
    );
    var result = await _navigationService!.navigateTo(
      Routes.transferFundsAmountView,
      arguments: TransferFundsAmountViewArguments(
          senderInfo: SenderInfo(moneySource: MoneySource.Bank),
          type: TransferType.MoneyPoolContribution,
          recipientInfo: recipientInfo),
    );
    if (result == "contributed") {
      await updateMoneyPool();
    }
  }

  // Fetch and thus update money pool e.g. after contribution has been made
  Future updateMoneyPool() async {
    this.moneyPool =
        await _moneyPoolService!.getMoneyPool(moneyPool.moneyPoolId);

    // can already be done for transfer_view
    fetchPayouts(true);
    notifyListeners();
  }

  Future showMoneyPoolPayoutDetailsDialog(MoneyPoolPayout data) async {
    List<String> paidOutUserNames = [];
    List<num> paidOutAmounts = [];
    data.transfersDetails.forEach((element) {
      paidOutUserNames.add(element.recipientName);
      paidOutAmounts.add(element.amount);
    });
    List<String> newList = [
      for (int i = 0; i < paidOutUserNames.length; i += 1)
        paidOutUserNames[i] + " -> " + formatAmount(paidOutAmounts[i])
    ];
    await _dialogService!.showDialog(
        title: "Money pool payout",
        description:
            "Date: ${formatDate(data.createdAt.toDate())}, paid out users: ${newList.join(", ")}");
  }

  ////////////////////////////////////////////////////
  /// Navigations
  ///
  Future navigateToDisburseMoneyPoolView() async {
    var result = await _navigationService!.navigateTo(
        Routes.disburseMoneyPoolView,
        arguments: DisburseMoneyPoolViewArguments(moneyPool: moneyPool));
    if (result == "paidOut") {
      // could have a fancy animation here
      await updateMoneyPool();
    }
  }
}
