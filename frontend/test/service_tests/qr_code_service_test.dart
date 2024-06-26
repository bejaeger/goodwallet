import 'package:flutter_test/flutter_test.dart';
import 'package:good_wallet/datamodels/user/public_user_info.dart';
import 'package:good_wallet/datamodels/user/user.dart';
import 'package:good_wallet/datamodels/user/user_settings.dart';
import 'package:good_wallet/exceptions/qrcode_service_exception.dart';
import 'package:good_wallet/services/qrcode/qrcode_service.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

void main() {
  group('QrCodeServiceTest -', () {
    group('encodeUserInfo -', () {
      test('Function that encodes user information as a string in json style',
          () {
        var service = QRCodeService();
        var info = service.getEncodedUserInfo(User(
            uid: "USERID",
            fullName: "USERNAME",
            email: "EMAIL",
            userSettings: UserSettings()));
        expect(info, "{\"uid\":\"USERID\",\"name\":\"USERNAME\"}");
      });
    });

    group('readScanResult -', () {
      test(
          'When users\' Good Wallet QR code is scanned should return user info as map',
          () {
        var service = QRCodeService();
        var barcode = Barcode("{\"uid\": \"USERID\", \"name\": \"USERNAME\"}",
            BarcodeFormat.qrcode, null);
        var result = service.analyzeScanResult(barcode);
        var expectedResult = PublicUserInfo(uid: "USERID", name: "USERNAME");
        expect(result.uid, expectedResult.uid);
        expect(result.name, expectedResult.name);
      });

      test('When an invalid code is scanned, service should throw an error',
          () {
        var service = QRCodeService();
        var barcode = Barcode("SOME RESULT", BarcodeFormat.qrcode, null);
        expect(() => service.analyzeScanResult(barcode),
            throwsA(isA<QRCodeServiceException>()));
      });
    });
  });
}
