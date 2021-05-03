import 'package:good_wallet/utils/datamodel_helpers.dart';

// class holding public info of user

class PublicUserInfo {
  final String name;
  final String uid;
  final String? email;
  final String? errorMessage;

  PublicUserInfo(
      {this.uid = "", this.name = "", this.email = "", this.errorMessage});
  PublicUserInfo.error(
      {this.name = "",
      this.email = "",
      this.uid = "",
      required this.errorMessage});

  PublicUserInfo.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = returnIfAvailable(json, "email"),
        uid = returnIfAvailable(json, "uid"),
        errorMessage = null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['uid'] = this.uid;
    data['email'] = this.email;
    return data;
  }

  bool hasError() {
    return errorMessage != null;
  }
}
