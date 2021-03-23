import 'package:good_wallet/app/locator.dart';
import 'package:good_wallet/app/router.gr.dart';
import 'package:good_wallet/enums/bottom_navigator_index.dart';
import 'package:good_wallet/enums/bottom_sheet_type.dart';
import 'package:good_wallet/services/authentification/authentification_service.dart';
import 'package:good_wallet/ui/views/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseModel {
  final _bottomSheetService = locator<BottomSheetService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future navigateToDonationView() async {
    await _navigationService.navigateTo(Routes.layoutTemplateViewMobile,
        arguments: LayoutTemplateViewMobileArguments(
            index: BottomNavigatorIndex.Give.index));
  }

  Future showRaiseMoneyBottomSheet() async {
    var sheetResponse = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.raise,
    );
    if (sheetResponse != null) {
      print("Response data: ${sheetResponse.responseData}");
      if (sheetResponse.responseData is Function) sheetResponse.responseData();
    }
  }

  Future showSendMoneyBottomSheet() async {
    var sheetResponse = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.sendMoney,
    );
    if (sheetResponse != null) {
      print("Response data: ${sheetResponse.responseData}");
      if (sheetResponse.responseData is Function) sheetResponse.responseData();
    }
  }
}
