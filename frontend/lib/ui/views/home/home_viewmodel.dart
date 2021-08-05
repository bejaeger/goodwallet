import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/money_pools/base/money_pool.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/money_transfer_query_config.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/sender_info.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
import 'package:good_wallet/datamodels/user/user.dart';
import 'package:good_wallet/enums/bottom_navigator_index.dart';
import 'package:good_wallet/enums/bottom_sheet_type.dart';
import 'package:good_wallet/enums/dialog_type.dart';
import 'package:good_wallet/enums/featured_app_type.dart';
import 'package:good_wallet/enums/money_source.dart';
import 'package:good_wallet/enums/transfer_type.dart';
import 'package:good_wallet/services/money_pools/money_pools_service.dart';
import 'package:good_wallet/services/transfers_history/transfers_history_service.dart';
import 'package:good_wallet/services/qrcode/qrcode_service.dart';
import 'package:good_wallet/services/user/user_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/social_functions_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';

class HomeViewModel extends SocialFunctionsViewModel {
  final BottomSheetService? _bottomSheetService = locator<BottomSheetService>();
  final DialogService? _dialogService = locator<DialogService>();
  final NavigationService? _navigationService = locator<NavigationService>();
  final QRCodeService? _qrCodeService = locator<QRCodeService>();
  final UserService? _userService = locator<UserService>();
  final TransfersHistoryService? _transfersManager =
      locator<TransfersHistoryService>();
  final log = getLogger("home_viewmodel.dart");
  final MoneyPoolsService? _moneyPoolsService = locator<MoneyPoolsService>();
  final SnackbarService? _snackbarService = locator<SnackbarService>();

  // get latest outgoing peer 2 peer transfers used in send money bottom sheet view
  // Need to add listeners otherwise this will be empty
  MoneyTransferQueryConfig _queryConfigTransfersToPeers =
      MoneyTransferQueryConfig(
          type: TransferType.User2UserSent, makeUniqueRecipient: true);
  List<MoneyTransfer> get latestTransfersToPeers =>
      _transfersManager!.getTransfers(config: _queryConfigTransfersToPeers);

  // get latest donations for give bottom sheet view
  // Need to add listeners otherwise this will be empty
  MoneyTransferQueryConfig _queryConfigDonations = MoneyTransferQueryConfig(
      type: TransferType.User2ProjectSent, makeUniqueRecipient: true);
  List<MoneyTransfer> get latestDonations =>
      _transfersManager!.getTransfers(config: _queryConfigDonations);

  // get last three money transfers
  MoneyTransferQueryConfig _queryConfigLatestTransfers =
      MoneyTransferQueryConfig(
          type: TransferType.AllInvolvingUser, maxNumberReturns: 3);
  List<MoneyTransfer> get latestTransfers =>
      _transfersManager!.getTransfers(config: _queryConfigLatestTransfers);

  List<User> get friends => _userService!.friends;

  List<MoneyPool> get moneyPools => _moneyPoolsService!.moneyPools;
  List<MoneyPool> get moneyPoolsInvitedTo =>
      _moneyPoolsService!.moneyPoolsInvitedTo;

  // Listen to streams of latest donations and transactions to be displayed
  // instantly when pulling up bottom sheets
  Future listenToData() async {
    setBusy(true);
    _transfersManager!
        .addTransferDataListener(config: _queryConfigTransfersToPeers);
    _transfersManager!.addTransferDataListener(config: _queryConfigDonations);
    Future? one = _transfersManager!
        .addTransferDataListener(config: _queryConfigLatestTransfers);
    Future? two = _moneyPoolsService!.listenToMoneyPools(uid: currentUser.uid);
    Future? three = listenToFriends();
    await Future.wait([one as Future<dynamic>, two as Future<dynamic>, three]);
    setBusy(false);
  }

  Future fetchData() async {
    // Dummy so far...could consider changing the balance!
    // so far we listen to the wallet with a stream
    await Future.delayed(Duration(milliseconds: 200));
    notifyListeners();
  }

  ///////////////////////////////////
  // helpers

  String getQRCodeUserInfoString() {
    return _qrCodeService!.getEncodedUserInfo(currentUser);
  }

  ///////////////////////////////////////////////////
  /// Dialogs
  Future showStatsDialog() async {
    await _dialogService!.showCustomDialog(
      barrierDismissible: true,
      variant: DialogType
          .Stats, // Which builder you'd like to call that was assigned in the builders function above.
      customData: userStats,
    );
  }

  ////////////////////////////////////////////////////////////////////
  /// Bottom sheets

  Future showRaiseMoneyBottomSheet() async {
    var sheetResponse = await _bottomSheetService!.showCustomSheet(
      variant: BottomSheetType.Raise,
      barrierDismissible: true,
    );
    if (sheetResponse != null) {
      log.i("Response data from bottom sheet: ${sheetResponse.responseData}");
      if (sheetResponse.responseData is Function) sheetResponse.responseData();
    }
  }

  Future showHomeViewMoreBottomSheet() async {
    var sheetResponse = await _bottomSheetService!.showCustomSheet(
      variant: BottomSheetType.HomeViewMore,
      barrierDismissible: true,
    );
    if (sheetResponse != null) {
      log.i("Response data from bottom sheet: ${sheetResponse.responseData}");
      if (sheetResponse.responseData is Function) sheetResponse.responseData();
    }
  }

  Future showSendMoneyBottomSheet() async {
    var sheetResponse = await _bottomSheetService!.showCustomSheet(
      variant: BottomSheetType.SendMoney,
      barrierDismissible: true,
      customData: latestTransfersToPeers,
    );
    if (sheetResponse != null) {
      log.i("Response data from bottom sheet: ${sheetResponse.responseData}");
      if (sheetResponse.responseData is Function) sheetResponse.responseData();
    }
  }

  Future showDonationBottomSheet() async {
    var sheetResponse = await _bottomSheetService!.showCustomSheet(
      variant: BottomSheetType.Donate,
      barrierDismissible: true,
      customData: latestDonations,
    );
    if (sheetResponse != null) {
      log.i("Response data: ${sheetResponse.responseData}");
      if (sheetResponse.responseData is Function) sheetResponse.responseData();
    }
  }

  //////////////////////////////////////////////////////////
  /// Navigation
  ///

  Future navigateToDonationView() async {
    await _navigationService!.replaceWith(Routes.layoutTemplateViewMobile,
        arguments: LayoutTemplateViewMobileArguments(
            initialBottomNavBarIndex: BottomNavigatorIndex.Give.index));
  }

  Future navigateToSingleFeaturedAppView(FeaturedAppType type) async {
    log.i("Navigating to single featured app view");
    await _navigationService!.navigateTo(Routes.singleFeaturedAppView,
        arguments: SingleFeaturedAppViewArguments(type: type));
  }

  Future navigateToSettingsView() async {
    log.e("Not yet implemented");
  }

  Future navigateToTransfersHistoryView() async {
    _navigationService!.navigateTo(
      Routes.transfersHistoryView,
    );
  }

  void navigateToNotificationsView() {
    _navigationService!.navigateTo(Routes.inAppNotificationsView);
  }

  void navigateToQRCodeView() {
    _navigationService!.navigateTo(Routes.qRCodeViewMobile,
        arguments: QRCodeViewMobileArguments(initialIndex: 1));
  }

  void navigateToProfileView() {
    _navigationService!.navigateTo(Routes.profileViewMobile);
  }

  Future navigateToAcceptPaymentsView() async {
    log.i("Clicked navigating to accept payments view (not yet implemented!)");
    await _navigationService!.navigateTo(Routes.qRCodeViewMobile,
        arguments: QRCodeViewMobileArguments(initialIndex: 1));
  }

  Future navigateToCreateMoneyPoolsView() async {
    // await _navigationService!.navigateTo(Routes.layoutTemplateViewMobile,
    //     arguments: LayoutTemplateViewMobileArguments(
    //         index: BottomNavigatorIndex.ManageMoneyPools.index));
    await _navigationService!.navigateTo(Routes.createMoneyPoolIntroView);
  }

  Future navigateToCommitMoneyView() async {
    await _navigationService!.navigateTo(Routes.transferFundsAmountView,
        arguments: TransferFundsAmountViewArguments(
            senderInfo: SenderInfo(moneySource: MoneySource.Bank),
            type: TransferType.User2OwnGoodWallet));
  }

  Future navigateToFavoriteCharitiesView() async {
    await _navigationService!.navigateTo(Routes.layoutTemplateViewMobile,
        arguments: LayoutTemplateViewMobileArguments(
            initialBottomNavBarIndex: BottomNavigatorIndex.Give.index,
            initialTabBarIndex: 2));
  }

  void navigateToHomeWithAnimation() {
    _navigationService!.navigateTo(Routes.layoutTemplateViewMobile,
        arguments: LayoutTemplateViewMobileArguments(showDialog: true));
  }

  void navigateToProfileViewMobile() {
    _navigationService!.navigateTo(Routes.publicProfileViewMobile,
        arguments: PublicProfileViewMobileArguments(uid: currentUser.uid));
    //    _navigationService!.navigateTo(Routes.publicProfileViewMobile);
  }

  Future showDialog() async {
    await _dialogService!.showDialog(title: "DIAALOG SUPER!");
  }

  Future navigateToSingleMoneyPoolView(MoneyPool moneyPool) async {
    await _navigationService!.navigateTo(Routes.singleMoneyPoolView,
        arguments: SingleMoneyPoolViewArguments(moneyPool: moneyPool));
  }

  void navigateToMoneyPoolsView() {
    _navigationService!.navigateTo(Routes.moneyPoolsView);
  }

  void navigateToCreateMoneyPoolView() {
    _navigationService!.navigateTo(Routes.createMoneyPoolIntroView);
  }

  Future showInvitationBottomSheet(int index) async {
    var sheetResponse = await _bottomSheetService!.showCustomSheet(
      variant: BottomSheetType.MoneyPoolInvitation,
      data: moneyPoolsInvitedTo[index],
      barrierDismissible: true,
    );
    if (sheetResponse != null) {
      log.i("Response data from bottom sheet: ${sheetResponse.responseData}");
      if (sheetResponse.responseData is Function) sheetResponse.responseData();

      if (sheetResponse.confirmed) {
        setBusy(true);
        // accepted invitation
        bool success = await _moneyPoolsService!.acceptInvitation(
            currentUser.uid, currentUser.fullName, moneyPoolsInvitedTo[index]);
        if (success is String)
          _snackbarService!.showSnackbar(
              title: "Invitation could not be accepted",
              message: success as String);
        else
          _snackbarService!.showSnackbar(message: "Accepted invitation");
        setBusy(false);
      } else {
        // devlined invitation
        await _moneyPoolsService!
            .declineInvitation(currentUser.uid, moneyPoolsInvitedTo[index]);
        _snackbarService!.showSnackbar(message: "Declined invitation");
      }
    }
  }

  @override
  void dispose() {
    _transfersManager!
        .pauseTransferDataListener(config: _queryConfigTransfersToPeers);
    _transfersManager!.pauseTransferDataListener(config: _queryConfigDonations);
    super.dispose();
  }
}
