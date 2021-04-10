import 'dart:convert';

import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/user/qr_code_user_info_model.dart';
import 'package:good_wallet/services/qrcode/qr_code_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class QRCodeViewModel extends BaseModel {
  final log = getLogger("qrcode_viewmodel.dart");
  final QRCodeService? _qrCodeService = locator<QRCodeService>();
  final SnackbarService? _snackbarService = locator<SnackbarService>();
  final NavigationService? _navigationService = locator<NavigationService>();

  String getUserInfo() {
    return _qrCodeService!.getEncodedUserInfo(currentUser!);
  }

  Future analyzeScanResult([Barcode? result]) async {
    if (isBusy) {
      return null;
    }
    setBusy(true);
    var deadTime = Duration(seconds: 3);
    log.i(
        "Scanned code with result '${result?.code}' and format '${result?.format}");
    QRCodeUserInfo userInfo = _qrCodeService!.analyzeScanResult(result);
    if (userInfo.hasError()) {
      log.e("Error when reading QR Code");
      // set busy to avoid showing snack bar multiple times
      _snackbarService!.showSnackbar(
          title: "Could not read QR code",
          message: "${userInfo.errorMessage}",
          duration: deadTime);
      await Future.delayed(deadTime);
    } else {
      log.i(
          "Successfully read user information from QR Code, navigate to send money view");
      await _navigationService!.navigateTo(Routes.sendMoneyViewMobile,
          arguments: SendMoneyViewMobileArguments(userInfo: userInfo));
    }

    setBusy(false);
  }
}
