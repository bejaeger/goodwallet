import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/money_pools/base/concise_money_pool_info.dart';
import 'package:good_wallet/datamodels/money_pools/base/money_pool.dart';
import 'package:good_wallet/datamodels/money_pools/messages/message.dart';
import 'package:good_wallet/datamodels/money_pools/payouts/money_pool_payout.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/money_transfer_query_config.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/recipient_info.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/sender_info.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
import 'package:good_wallet/datamodels/user/public_user_info.dart';
import 'package:good_wallet/datamodels/user/user.dart';
import 'package:good_wallet/enums/bottom_navigator_index.dart';
import 'package:good_wallet/enums/money_source.dart';
import 'package:good_wallet/enums/search_type.dart';
import 'package:good_wallet/enums/transfer_type.dart';
import 'package:good_wallet/exceptions/firestore_api_exception.dart';
import 'package:good_wallet/services/transfers_history/transfers_history_service.dart';
import 'package:good_wallet/services/money_pools/money_pools_service.dart';
import 'package:good_wallet/services/user/user_service.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:good_wallet/ui/views/money_pools/single_money_pool_view.form.dart';

class SingleMoneyPoolViewModel extends FormViewModel {
  final MoneyPoolsService? _moneyPoolsService = locator<MoneyPoolsService>();
  final NavigationService? _navigationService = locator<NavigationService>();
  final SnackbarService? _snackbarService = locator<SnackbarService>();
  final DialogService? _dialogService = locator<DialogService>();
  final UserService? _userService = locator<UserService>();
  final TransfersHistoryService? _transfersManager =
      locator<TransfersHistoryService>();

  final log = getLogger("single_money_pool_viewmodel.dart");

  StreamSubscription<MoneyPool>? _moneyPoolStreamSubscription;

  // Get latest money pool payouts for that money pool
  // Need to add listener in listenToData() function
  String _moneyPoolId = "";
  List<MoneyPoolPayout> get payouts =>
      _transfersManager!.getMoneyPoolPayouts(mpid: _moneyPoolId);

  // Get latest messages for that money pool
  // Need to add listener in listenToData() function
  List<Message> get messages =>
      _moneyPoolsService!.getMoneyPoolMessages(mpid: _moneyPoolId);

  // Get latest money pool contributions
  // Need to add listener when model is created
  MoneyTransferQueryConfig _queryConfig =
      MoneyTransferQueryConfig(type: TransferType.Invalid);
  List<MoneyTransfer> get latestContributions =>
      _transfersManager!.getTransfers(config: _queryConfig);

  List<dynamic> activities = [];

  MoneyPool moneyPool;
  SingleMoneyPoolViewModel({required this.moneyPool}) {
    _moneyPoolId = moneyPool.moneyPoolId;
    _queryConfig = MoneyTransferQueryConfig(
      type: TransferType.User2MoneyPool,
      recipientId: _moneyPoolId,
    );
  }

  void sortListOfActivities() {
    activities = [];
    activities.addAll([...messages, ...latestContributions, ...payouts]);
    activities.sort((a, b) {
      if (b.createdAt != null && a.createdAt != null) {
        return b.createdAt.compareTo(a.createdAt);
      } else {
        return 0;
      }
    });
    notifyListeners();
  }

  Future listenToData() async {
    Completer completerOne = Completer<void>();
    Completer completerTwo = Completer<void>();
    Completer completerThree = Completer<void>();
    _transfersManager!.addTransferDataListener(
        config: _queryConfig,
        completer: completerOne,
        callback: sortListOfActivities);
    _transfersManager!.addMoneyPoolPayoutListener(
        mpid: _moneyPoolId,
        completer: completerTwo,
        callback: sortListOfActivities);
    _moneyPoolsService!.addMoneyPoolMessagesListener(
        mpid: _moneyPoolId,
        completer: completerThree,
        callback: sortListOfActivities);
    if (!completerOne.isCompleted ||
        !completerTwo.isCompleted ||
        !completerThree.isCompleted) {
      setBusy(true);
      await Future.wait([
        completerOne.future,
        completerTwo.future,
        completerThree.future,
      ]);
      setBusy(false);
    }

    // set up listener to this very money pool and update view when money pool changes
    _moneyPoolStreamSubscription = _moneyPoolsService!
        .getMoneyPoolStream(mpid: _moneyPoolId)
        .listen((event) {
      moneyPool = event;
      notifyListeners();
    })
          ..onError((e) async {
            log.wtf(
                "Something went wrong, probably the money pool has been deleted!");
            if (e is FirestoreApiException) {
              await _dialogService!
                  .showDialog(title: "Error", description: e.prettyDetails);
            }
          });
  }

  Future refresh() async {
    notifyListeners();
  }

  Future deleteMoneyPool(String poolId) async {
    if (moneyPool.total != 0.0) {
      await _dialogService!.showDialog(
        title: "You can't delete the Impact Pool",
        description:
            "You should first disburse the Impact Pool into your individual accounts ;)",
      );
      notifyListeners();
      return;
    }
    if (moneyPool.adminUID != currentUser.uid) {
      await _dialogService!.showDialog(
        title: "You can't delete the Impact Pool",
        description:
            "You are not the owner of the money pool so you can't delete it ;)",
      );
      notifyListeners();
      return;
    }
    setBusy(true);
    await _moneyPoolsService!.deleteMoneyPool(poolId);
    _navigationService!.clearStackAndShow(Routes.layoutTemplateViewMobile,
        arguments: LayoutTemplateViewMobileArguments(
            initialBottomNavBarIndex: BottomNavigatorIndex.Home.index));
    setBusy(false);
  }

  void showSearchViewAndInviteUser() async {
    String? messageToShow;
    dynamic userInfo = await _navigationService!.navigateTo(Routes.searchView,
        arguments: SearchViewArguments(
            searchType: SearchType.UserToInviteToMP, autofocus: true));
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

  Future addMessageToMoneyPool() async {
    if (isValidMessage(messageValue)) {
      log.i("Adding message $messageValue to message board");
      Message message = Message(
          message: messageValue!,
          uid: currentUser.uid,
          createdAt: FieldValue.serverTimestamp(),
          name: currentUser.fullName);
      await _moneyPoolsService!
          .addMessageToMoneyPool(mpid: _moneyPoolId, message: message);
      notifyListeners();
      setData({});
    } else {
      log.i(
          "Not adding message to money pool because the following is not a valid message: $messageValue");
    }
  }

  bool isValidMessage(String? message) {
    if (message == null) return false;
    if (message.isEmpty) return false;
    return true;
  }

  //////////////////////////////////////////////
  /// Dialogs

  Future showMoneyPoolMessageDetailsDialog(Message message) async {
    await _dialogService!.showDialog(
        title: "Message from ${message.name}",
        description: message.message,
        cancelTitle: formatDateShort(message.createdAt?.toDate()),
        cancelTitleColor: Colors.black87);
  }

  Future showMoneyTransferInfoDialog(MoneyTransfer transfer) async {
    final details = transfer.transferDetails;
    final String senderName = details.senderName;
    final String recipientName = details.recipientName;
    final String amount = formatAmount(details.amount);
    final String source = describeEnum(details.sourceType.toString());
    final String date =
        DateFormat.yMd().add_jm().format(transfer.createdAt.toDate());
    return await _dialogService!.showDialog(
      title: "Details",
      description:
          "From: $senderName\nTo: $recipientName\nAmount: $amount\nDate: $date\nSource: $source",
    );
  }

  ////////////////////////////////////////////////////
  /// Navigations
  ///
  Future navigateToDisburseMoneyPoolView() async {
    await _navigationService!.navigateTo(Routes.disburseMoneyPoolView,
        arguments: DisburseMoneyPoolViewArguments(moneyPool: moneyPool));
  }

  void navigateToAllMembersView() {
    _navigationService!.navigateTo(Routes.membersListView,
        arguments: MembersListViewArguments(
            contributingUsers: moneyPool.contributingUsers,
            invitedUsers: moneyPool.invitedUsers,
            currentUserId: currentUser.uid,
            adminId: moneyPool.moneyPoolId,
            adminName: moneyPool.adminName,
            onInviteMemberPressed: showSearchViewAndInviteUser));
  }

  @override
  void dispose() {
    log.v("Disposing single money pool viewmodel");
    super.dispose();
    _transfersManager!.cancelMoneyPoolPayoutListener(mpid: _moneyPoolId);
    _transfersManager!.cancelTransferDataListener(config: _queryConfig);
    _moneyPoolsService!
        .cancelMoneyPoolMessageListener(mpid: moneyPool.moneyPoolId);
    _moneyPoolStreamSubscription?.cancel();
    _moneyPoolStreamSubscription = null;
  }

  //-----------------------------------------
  // FROM BASEVIEWMODEL
  User get currentUser => _userService!.currentUser;
  void showNotImplementedSnackbar() {
    _snackbarService!.showSnackbar(
        title: "Not yet implemented.",
        message: "I know... it's sad",
        duration: Duration(seconds: 2));
  }

  void navigateBack() {
    _navigationService!.back();
  }
  // ---------------------------------------------------

  // ------------------------------
  // For form validation
  @override
  void setFormStatus() {}
}
