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
import 'package:good_wallet/exceptions/firestore_api_exception.dart';
import 'package:good_wallet/services/transfers_history/transfers_history_service.dart';
import 'package:good_wallet/services/money_pools/money_pools_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';

class SingleMoneyPoolViewModel extends BaseModel {
  final MoneyPoolsService? _moneyPoolsService = locator<MoneyPoolsService>();
  final NavigationService? _navigationService = locator<NavigationService>();
  final SnackbarService? _snackbarService = locator<SnackbarService>();
  final DialogService? _dialogService = locator<DialogService>();
  final TransfersHistoryService? _transfersManager =
      locator<TransfersHistoryService>();

  final log = getLogger("single_money_pool_viewmodel.dart");

  // Get latest money pool payouts for that money pool
  // Need to add listener in listenToData() function
  String _moneyPoolId = "";
  List<MoneyPoolPayout> get payouts =>
      _transfersManager!.getMoneyPoolPayouts(mpid: _moneyPoolId);

  // Get latest money pool contributions
  // Need to add listener when model is created
  MoneyTransferQueryConfig _queryConfig =
      MoneyTransferQueryConfig(type: TransferType.Invalid);
  List<MoneyTransfer> get latestContributions =>
      _transfersManager!.getTransfers(config: _queryConfig);

  MoneyPool moneyPool;
  SingleMoneyPoolViewModel({required this.moneyPool}) {
    _moneyPoolId = moneyPool.moneyPoolId;
    _queryConfig = MoneyTransferQueryConfig(
      type: TransferType.User2MoneyPool,
      recipientId: _moneyPoolId,
    );
  }

  Future listenToData() async {
    setBusy(true);
    await _transfersManager!.addTransferDataListener(config: _queryConfig);
    await _transfersManager!.addMoneyPoolPayoutListener(mpid: _moneyPoolId);
    // set up listener to this very money pool and update view when money pool changes
    _moneyPoolsService!.getMoneyPoolStream(mpid: _moneyPoolId).listen((event) {
      moneyPool = event;
      notifyListeners();
    }).onError((e) async {
      log.wtf(
          "Something went wrong, probably the money pool has been deleted!");
      if (e is FirestoreApiException) {
        await _dialogService!
            .showDialog(title: "Error", description: e.prettyDetails);
      }
    });

    setBusy(false);
  }

  Future deleteMoneyPool(String poolId) async {
    setBusy(true);
    await _moneyPoolsService!.deleteMoneyPool(poolId);
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
          await _moneyPoolsService!.addInvitedUserToMoneyPool(
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
    await _navigationService!.navigateTo(
      Routes.transferFundsAmountView,
      arguments: TransferFundsAmountViewArguments(
          senderInfo: SenderInfo(moneySource: MoneySource.Bank),
          type: TransferType.User2MoneyPool,
          recipientInfo: recipientInfo),
    );
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
        formatAmount(paidOutAmounts[i]) + " -> " + paidOutUserNames[i]
    ];
    await _dialogService!.showDialog(
        title: "Money pool payout",
        description:
            "Date: ${formatDateDetails(data.createdAt.toDate())}\nRecipients:\n  ${newList.join("\n  ")}");
  }

  ////////////////////////////////////////////////////
  /// Navigations
  ///
  Future navigateToDisburseMoneyPoolView() async {
    await _navigationService!.navigateTo(Routes.disburseMoneyPoolView,
        arguments: DisburseMoneyPoolViewArguments(moneyPool: moneyPool));
  }

  @override
  void dispose() {
    super.dispose();
    _transfersManager!.cancelMoneyPoolPayoutListener(mpid: _moneyPoolId);
    _transfersManager!.cancelTransferDataListener(config: _queryConfig);
  }
}
