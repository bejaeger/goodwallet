import 'dart:convert';

import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';

class QRCodeViewModel extends BaseModel {
  String getUserInfo() {
    Map<String, String> userInfoMap = {
      "id": currentUser!.id.toString(),
      "name": currentUser!.fullName.toString(),
    };
    // Format for data stored in QR image
    // the format: key1: name, key2: name
    // easily converted later on
    return jsonEncode(userInfoMap);
  }
}
