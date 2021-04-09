import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/user/user_model.dart';
import 'package:good_wallet/enums/bottom_navigator_index.dart';
import 'package:good_wallet/enums/bottom_sheet_type.dart';
import 'package:good_wallet/enums/featured_app_type.dart';
import 'package:good_wallet/services/userdata/user_data_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';

class HomeViewModel extends BaseModel {
  final BottomSheetService? _bottomSheetService = locator<BottomSheetService>();
  final NavigationService? _navigationService = locator<NavigationService>();

  final log = getLogger("home_viewmodel.dart");

  Future navigateToDonationView() async {
    await _navigationService!.replaceWith(Routes.layoutTemplateViewMobile,
        arguments: LayoutTemplateViewMobileArguments(
            index: BottomNavigatorIndex.Give.index));
  }

  Future showRaiseMoneyBottomSheet() async {
    var sheetResponse = await _bottomSheetService!.showCustomSheet(
      variant: BottomSheetType.raise,
      barrierDismissible: true,
    );
    if (sheetResponse != null) {
      print("Response data: ${sheetResponse.responseData}");
      if (sheetResponse.responseData is Function) sheetResponse.responseData();
    }
  }

  Future showSendMoneyBottomSheet() async {
    var sheetResponse = await _bottomSheetService!.showCustomSheet(
      variant: BottomSheetType.sendMoney,
      barrierDismissible: true,
    );
    if (sheetResponse != null) {
      print("Response data: ${sheetResponse.responseData}");
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
}
