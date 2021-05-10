// user data model

import 'package:good_wallet/utils/datamodel_helpers.dart';

class GWUser {
  final String id;
  final String fullName;
  final String email;
  final num currentBalance;
  final num transferredToPeers;
  final num donations;
  final num raised;

  GWUser(
      {required this.transferredToPeers,
      required this.donations,
      required this.id,
      required this.fullName,
      required this.email,
      required this.currentBalance,
      required this.raised});

  GWUser.empty()
      : id = "",
        fullName = "",
        email = "",
        currentBalance = 0,
        transferredToPeers = 0,
        donations = 0,
        raised = 0;

  GWUser.dummy()
      : id = "USERID",
        fullName = "USERNAME",
        email = "dummy@gmail.com",
        currentBalance = 0,
        transferredToPeers = 0,
        donations = 0,
        raised = 0;

  GWUser.fromData(Map<String, dynamic> data)
      : id = data['id'],
        fullName = data['fullName'],
        email = data['email'],
        currentBalance = data['currentBalance'],
        transferredToPeers = data['transferredToPeers'],
        donations = data['donations'],
        raised = data['raised'];

  Map<String, dynamic> toJson([bool addSearchKeywords = false]) {
    var returnJson = {
      'id': id,
      'fullName': fullName,
      'email': email,
      'currentBalance': currentBalance,
      'transferredToPeers': transferredToPeers,
      'donations': donations,
      'raised': raised
    };
    // create search keywords for user
    if (addSearchKeywords) {
      List<String> splitList = fullName.split(' ');
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

  static GWUser fromMap(Map<String, dynamic> map) {
    var data = GWUser(
        id: map['id'],
        fullName: map['fullName'],
        email: map['email'],
        currentBalance: map['currentBalance'],
        transferredToPeers: map['transferredToPeers'],
        donations: map['donations'],
        raised: map['raised']);
    return data;
  }
}
