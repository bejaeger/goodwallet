// Created with  @https://javiercbk.github.io/json_to_dart/
// from json (outdated, just left here as an example)
//
// {
//     "name": "name",
//     "description": "description",
//     "adminUID": "uid",
//     "adminName": "adminName",
//     "showTotalAmount": "False",
//     "invitedUsers": [
//         {
//             "uid": "uid",
//             "name": "name"
//         },
//         {
//             "uid": "uid",
//             "name": "name"
//         }
//     ],
//     "contributingUsers": [
//         {
//             "uid": "uid",
//             "name": "name"
//         },
//         {
//             "uid": "uid",
//             "name": "name"
//         }
//     ]
// }
//

import 'package:cloud_firestore/cloud_firestore.dart';

class MoneyPoolModel {
  String? name;
  String? adminUID;
  String? adminName;
  double? total;
  String? description;
  String? moneyPoolId;
  bool? showTotalAmount;
  dynamic? createdAt;

  MoneyPoolModel.empty()
      : this.name = "",
        this.adminUID = "",
        this.adminName = "",
        this.moneyPoolId = "",
        this.total = -1.0,
        this.description = "",
        this.createdAt = "",
        this.showTotalAmount = false;

  MoneyPoolModel({
    this.name,
    this.adminName,
    this.adminUID,
    this.createdAt,
    this.moneyPoolId,
    this.total = 0,
    this.description,
    this.showTotalAmount = true,
  });

  MoneyPoolModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        adminUID = json['adminUID'],
        adminName = json['adminName'],
        moneyPoolId = json['moneyPoolId'],
        showTotalAmount = json['showTotalAmount'],
        createdAt = json['createdAt'] as Timestamp?,
        total = json['total'],
        description = json['description'] {
    if (moneyPoolId == null) {
      throw Exception("Money pool ID can't be null! Fetched data not valid");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['adminUID'] = this.adminUID;
    data['moneyPoolId'] = this.moneyPoolId;
    data['adminName'] = this.adminName;
    data['total'] = this.total;
    data['createdAt'] = this.createdAt as FieldValue?;
    data['showTotalAmount'] = this.showTotalAmount;
    return data;
  }
}

class ContributingUser {
  String name;
  String uid;

  ContributingUser({required this.uid, required this.name});

  ContributingUser.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        name = json['name'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['name'] = this.name;
    return data;
  }
}
