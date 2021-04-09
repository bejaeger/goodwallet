// user data model

import 'package:good_wallet/utils/datamodel_helpers.dart';

class MyUser {
  final String? id;
  final String? fullName;
  final String? email;
  final num? balance;
  final num? implicitDonations;
  final num? donations;

  MyUser(
      {this.implicitDonations,
      this.donations,
      this.id,
      this.fullName,
      this.email,
      this.balance});

  MyUser.fromData(Map<String, dynamic> data)
      : id = data['id'],
        fullName = data['fullName'],
        email = data['email'],
        balance = data['balance'],
        implicitDonations = data['implicitDonations'],
        donations = data['donations'];

  Map<String, dynamic> toJson([bool addSearchKeywords = false]) {
    var returnJson = {
      'id': id,
      'fullName': fullName,
      'email': email,
      'balance': balance,
      'implicitDonations': implicitDonations,
      'donations': donations,
    };
    // create search keywords for user
    if (addSearchKeywords) {
      List<String> splitList = fullName!.split(' ');
      List<String> searchKeywords = [];
      for (int i = 0; i < splitList.length; i++) {
        for (int j = 1; j <= splitList[i].length; j++) {
          searchKeywords.add(splitList[i].substring(0, j).toLowerCase());
        }
      }
      returnJson["searchKeywords"] = searchKeywords;
    }
    return returnJson;
  }

  String getInitials() {
    return getInitialsFromName(this.fullName!);
  }

  static MyUser fromMap(Map<String, dynamic> map) {
    var data = MyUser(
        id: map['id'],
        fullName: map['fullName'],
        email: map['email'],
        balance: map['balance'],
        implicitDonations: map['implicitDonations'],
        donations: map['donations']);
    return data;
  }  
}
