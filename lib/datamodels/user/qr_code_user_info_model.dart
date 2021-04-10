// class to use to store user info in QR code
//

import 'dart:convert';

class QRCodeUserInfo {
  final String name;
  final String id;
  final String? errorMessage;

  QRCodeUserInfo({this.name = "", this.id = "", this.errorMessage});
  QRCodeUserInfo.error(
      {this.name = "", this.id = "", required this.errorMessage});

  String toJsonString() {
    return jsonEncode({"id": id, "name": name});
  }

  bool hasError() {
    return errorMessage != null;
  }
}
