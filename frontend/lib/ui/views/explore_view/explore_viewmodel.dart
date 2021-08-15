import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/recipient_info.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/sender_info.dart';
import 'package:good_wallet/datamodels/user/public_user_info.dart';
import 'package:good_wallet/enums/featured_app_type.dart';
import 'package:good_wallet/enums/money_source.dart';
import 'package:good_wallet/enums/search_type.dart';
import 'package:good_wallet/enums/transfer_type.dart';
import 'package:good_wallet/services/user/user_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/social_functions_viewmodel.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class ExploreViewModel extends SocialFunctionsViewModel {
  List<PublicUserInfo> userInfoList = [];
  final NavigationService? _navigationService = locator<NavigationService>();
  final UserService _userService = locator<UserService>();
  final log = getLogger("search_viewmodel.dart");

  int animationDurationInMs = 2000;
  int delayDurationinMs = 100;

  //num get actualTotalDonationsGlobal => _userService.totalDonationsGlobal;

  num getAmountToAddPerStep(totalDonations) {
    return totalDonations / (animationDurationInMs / delayDurationinMs);
  }

  num runningTotalDonationsGlobal = 0;
  Future fetchTotalDonationsGlobal() async {
    setBusy(true);

    // Could also set up listener here.
    // But we probably don't want to do that considering that there will be
    // a large number writes to the summary document so this would be
    // read every time, which will cause a lot of reads!
    // Add a refresh button instead :)
    // await _userService.listenToGlobalStats();

    num tmpTotalDonations = await _userService.getTotalDonationsGlobal();
    num toAddPerStep = getAmountToAddPerStep(tmpTotalDonations);
    while (runningTotalDonationsGlobal < tmpTotalDonations) {
      runningTotalDonationsGlobal += toAddPerStep;
      await Future.delayed(Duration(milliseconds: delayDurationinMs));
      notifyListeners();
    }

    // _userService.totalDonationsGlobalSubject.listen((value) {
    //   runningTotalDonationsGlobal = value;
    //   notifyListeners();
    // });
    setBusy(false);
  }

  Future refresh() async {
    runningTotalDonationsGlobal = await _userService.getTotalDonationsGlobal();
    notifyListeners();
  }
  /////////////////////////////////////////////////
  /// Navigation

  void navigateToScanQRCodeView() {
    _navigationService!.navigateTo(Routes.qRCodeViewMobile,
        arguments: QRCodeViewMobileArguments(initialIndex: 0));
  }

  void navigateToProfileView() {
    _navigationService!.navigateTo(Routes.publicProfileViewMobile,
        arguments: PublicProfileViewMobileArguments(uid: currentUser.uid));
  }

  Future navigateToTransferView(String uid, int index) async {
    _navigationService!.navigateTo(Routes.transferFundsAmountView,
        arguments: TransferFundsAmountViewArguments(
            senderInfo: SenderInfo(moneySource: MoneySource.Bank),
            type: TransferType.User2UserSent,
            recipientInfo: RecipientInfo.user(
                name: userInfoList[index].name, id: userInfoList[index].uid)));
  }

  Future navigateToSingleFeaturedAppView(FeaturedAppType type) async {
    log.i("Navigating to single featured app view");
    await _navigationService!.navigateTo(Routes.singleFeaturedAppView,
        arguments: SingleFeaturedAppViewArguments(type: type));
  }
}
