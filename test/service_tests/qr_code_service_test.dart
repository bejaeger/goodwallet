import 'package:flutter_test/flutter_test.dart';
import 'package:good_wallet/datamodels/user/qr_code_user_info_model.dart';
import 'package:good_wallet/datamodels/user/user_model.dart';
import 'package:good_wallet/services/qrcode/qr_code_service.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

void main() {
  group('QrCodeServiceTest -', () {
    group('encodeUserInfo -', () {
      test('Function that encodes user information as a string in json style',
          () {
        var service = QRCodeService();
        var info = service
            .getEncodedUserInfo(MyUser(id: "USERID", fullName: "USERNAME"));
        expect(info, "{\"id\":\"USERID\",\"name\":\"USERNAME\"}");
      });
    });

    group('readScanResult -', () {
      test(
          'When users\' Good Wallet QR code is scanned should return user info as map',
          () {
        var service = QRCodeService();
        var barcode = Barcode("{\"id\": \"USERID\", \"name\": \"USERNAME\"}",
            BarcodeFormat.qrcode, null);
        var result = service.analyzeScanResult(barcode);
        var expectedResult = QRCodeUserInfo(id: "USERID", name: "USERNAME");
        expect(result.id, expectedResult.id);
        expect(result.name, expectedResult.name);
      });

      test(
          'When an invalid code is scanned, service should return proper error message',
          () {
        var service = QRCodeService();
        var barcode = Barcode("SOME RESULT", BarcodeFormat.qrcode, null);
        var result = service.analyzeScanResult(barcode);
        expect(result.hasError(), true);
      });
    });
  });
}
