import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/money_transfer_query_config.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/sender_info.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
import 'package:good_wallet/enums/bottom_navigator_index.dart';
import 'package:good_wallet/enums/bottom_sheet_type.dart';
import 'package:good_wallet/enums/featured_app_type.dart';
import 'package:good_wallet/enums/money_source.dart';
import 'package:good_wallet/enums/transfer_type.dart';
import 'package:good_wallet/services/qrcode/qrcode_service.dart';
import 'package:good_wallet/services/userdata/user_data_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';

class HomeViewModel extends BaseModel {
  final BottomSheetService? _bottomSheetService = locator<BottomSheetService>();
  final NavigationService? _navigationService = locator<NavigationService>();
  final QRCodeService? _qrCodeService = locator<QRCodeService>();
  final UserDataService? _userDataService = locator<UserDataService>();
  final log = getLogger("home_viewmodel.dart");

  // get latest outgoing peer 2 peer transfers used in send money bottom sheet view
  // Need to add listeners otherwise this will be empty
  MoneyTransferQueryConfig _queryConfigTransactionToPeers =
      MoneyTransferQueryConfig(
          type: TransferType.Peer2PeerSent, makeUnique: true);
  List<MoneyTransfer> get latestTransactionToPeers =>
      _userDataService!.getTransfers(config: _queryConfigTransactionToPeers);

  // get latest donations for give bottom sheet view
  // Need to add listeners otherwise this will be empty
  MoneyTransferQueryConfig _queryConfigDonations =
      MoneyTransferQueryConfig(type: TransferType.Donation, makeUnique: true);
  List<MoneyTransfer> get latestDonations =>
      _userDataService!.getTransfers(config: _queryConfigDonations);

  // Listen to streams of latest donations and transactions to be displayed
  // instantly when pulling up bottom sheets
  Future listenToData() async {
    _userDataService!
        .addTransferDataListener(config: _queryConfigTransactionToPeers);
    _userDataService!.addTransferDataListener(config: _queryConfigDonations);
  }

  Future fetchData() async {
    // Dummy so far...could consider changing the balance!
    // so far we listen to the wallet with a stream
    Future.delayed(Duration(milliseconds: 500));
    notifyListeners();
  }

  Future navigateToDonationView() async {
    await _navigationService!.replaceWith(Routes.layoutTemplateViewMobile,
        arguments: LayoutTemplateViewMobileArguments(
            initialBottomNavBarIndex: BottomNavigatorIndex.Give.index));
  }

  String getQRCodeUserInfoString() {
    return _qrCodeService!.getEncodedUserInfo(currentUser);
  }

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

  Future showSendMoneyBottomSheet() async {
    var sheetResponse = await _bottomSheetService!.showCustomSheet(
      variant: BottomSheetType.SendMoney,
      barrierDismissible: true,
      customData: latestTransactionToPeers,
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

  Future navigateToSingleFeaturedAppView(FeaturedAppType type) async {
    log.i("Navigating to single featured app view");
    await _navigationService!.navigateTo(Routes.singleFeaturedAppView,
        arguments: SingleFeaturedAppViewArguments(type: type));
  }

  Future navigateToSettingsView() async {
    log.e("Not yet implemented");
  }

  Future navigateToTransactionsHistoryView() async {
    _navigationService!.navigateTo(
      Routes.transfersHistoryView,
    );
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

  Future navigateToTransferFundAmountView() async {
    await _navigationService!.navigateTo(Routes.transferFundsAmountView,
        arguments: TransferFundsAmountViewArguments(
            senderInfo: SenderInfo(moneySource: MoneySource.Bank),
            type: TransferType.Commitment));
  }

  Future navigateToFavoriteCharitiesView() async {
    await _navigationService!.navigateTo(Routes.layoutTemplateViewMobile,
        arguments: LayoutTemplateViewMobileArguments(
            initialBottomNavBarIndex: BottomNavigatorIndex.Give.index,
            initialTabBarIndex: 2));
  }

  @override
  void dispose() {
    _userDataService!
        .pauseTransferDataListener(config: _queryConfigTransactionToPeers);
    _userDataService!.pauseTransferDataListener(config: _queryConfigDonations);
    super.dispose();
  }
}
