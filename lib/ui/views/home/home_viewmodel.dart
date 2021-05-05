import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/causes/preview_details/project_preview_details.dart';
import 'package:good_wallet/datamodels/user/user_model.dart';
import 'package:good_wallet/enums/bottom_navigator_index.dart';
import 'package:good_wallet/enums/bottom_sheet_type.dart';
import 'package:good_wallet/enums/featured_app_type.dart';
import 'package:good_wallet/enums/fund_transfer_type.dart';
import 'package:good_wallet/enums/transaction_direction.dart';
import 'package:good_wallet/services/qrcode/qrcode_service.dart';
import 'package:good_wallet/services/userdata/user_data_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:good_wallet/datamodels/transactions/transaction.dart'
    as gwmodel;

class HomeViewModel extends BaseModel {
  final BottomSheetService? _bottomSheetService = locator<BottomSheetService>();
  final NavigationService? _navigationService = locator<NavigationService>();
  final QRCodeService? _qrCodeService = locator<QRCodeService>();
  final UserDataService? _userDataService = locator<UserDataService>();
  final log = getLogger("home_viewmodel.dart");

  // get latest peer 2 peer transactions for send money bottom sheet view
  // Need to add listeners otherwise this will be empty
  List<gwmodel.Peer2PeerTransaction> get latestTransactionToPeers =>
      _userDataService!
          .getTransactionsForDirection<gwmodel.Peer2PeerTransaction>(
              direction: TransactionDirection.TransferredToPeers);

  // get latest donations for give bottom sheet view
  // Need to add listeners otherwise this will be empty
  List<gwmodel.Donation> get latestDonations =>
      _userDataService!.getTransactionsForDirection<gwmodel.Donation>(
          direction: TransactionDirection.Donation);

  // Listen to stream of latest donations and transactions
  Future listenToData() async {
    _userDataService!.addTransactionListener(
        direction: TransactionDirection.TransferredToPeers, maxNumber: 10);
    _userDataService!.addTransactionListener(
        direction: TransactionDirection.Donation, maxNumber: 5);
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
      variant: BottomSheetType.raise,
      barrierDismissible: true,
    );
    if (sheetResponse != null) {
      log.i("Response data from bottom sheet: ${sheetResponse.responseData}");
      if (sheetResponse.responseData is Function) sheetResponse.responseData();
    }
  }

  Future showSendMoneyBottomSheet() async {
    var sheetResponse = await _bottomSheetService!.showCustomSheet(
      variant: BottomSheetType.sendMoney,
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
      variant: BottomSheetType.donate,
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
    _navigationService!.navigateTo(Routes.transactionsView);
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
            type: FundTransferType.commitment));
  }

  Future navigateToFavoriteCharitiesView() async {
    await _navigationService!.navigateTo(Routes.layoutTemplateViewMobile,
        arguments: LayoutTemplateViewMobileArguments(
            initialBottomNavBarIndex: BottomNavigatorIndex.Give.index,
            initialTabBarIndex: 2));
  }
}
