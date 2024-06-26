import 'dart:convert';

import 'package:good_wallet/datamodels/user/public_user_info.dart';
import 'package:good_wallet/datamodels/user/user.dart';
import 'package:good_wallet/exceptions/qrcode_service_exception.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

// This class provides functionality to encode user info into a string
// displayed in terms of a QR image and to read results back from QR Code

class QRCodeService {
  final log = getLogger("qr_code_service.dart");

  String getEncodedUserInfo(User currentUser) {
    // Format for data stored in QR image
    // the format: key1: name, key2: name
    // easily converted later on
    return jsonEncode({
      "uid": currentUser.uid.toString(),
      "name": currentUser.fullName.toString()
    });
  }

  PublicUserInfo analyzeScanResult(Barcode result) {
    try {
      var json = jsonDecode(result.code);
      if (json["uid"] != null && json["name"] != null) {
        return PublicUserInfo(uid: json["uid"], name: json["name"]);
      }
      throw QRCodeServiceException(
          message:
              "QR code has wrong format. If this error persists please contact support.",
          prettyDetails:
              "QR code has wrong format. If this error persists please contact support.");
    } on FormatException catch (e) {
      log.e(
          "Scanned code does not seem to be a Good Wallet users QR code. Failed with error ${e.toString()}");
      throw QRCodeServiceException(
          message:
              "Scanned code does not seem to be a Good Wallet users' QR code. Please try again.",
          prettyDetails:
              "Scanned code does not seem to be a Good Wallet users' QR code. Please try again.");
    } catch (e) {
      log.e(
          "Could not find user information in scanned code because of error ${e.toString()}");
      throw QRCodeServiceException(
          message:
              "Failed to scan QR code. Try to increase the brightness of your screen.",
          prettyDetails:
              "Failed to scan QR code. Try to increase the brightness of your screen.");
    }
  }
}
