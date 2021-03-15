import 'package:good_wallet/app/locator.dart';
import 'package:good_wallet/enums/bottom_sheet_type.dart';
import 'package:good_wallet/ui/views/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseModel {
  final _bottomSheetService = locator<BottomSheetService>();

  Future showRaiseMoneyBottomSheet() async {
    var sheetResponse = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.raise,
      title: 'Raise Money',
      //description: 'scan QR code or search for user name',
    );
    print('confirmationResponse confirmed: ${sheetResponse?.confirmed}');

    if (sheetResponse != null) {
      if (sheetResponse.responseData == "Test1") {
        print("TEST 1 WAHNSINN!");
        // var userInfoMap = await QRScanner.getQRCodeScan();
        // if (userInfoMap != null) {
        //   _navigationService.navigateTo(Routes.transferView,
        //       arguments: TransferViewArguments(userInfoMap: userInfoMap));
        // }
      } else {
        print("Not Test 1 das ist ja unfassbar!");
      }
    }
  }
}
