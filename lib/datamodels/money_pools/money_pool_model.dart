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
import 'package:good_wallet/datamodels/user/public_user_info.dart';

class MoneyPoolModel {
  String name;
  String adminUID;
  String adminName;
  num total;
  String currency;
  String? description;
  String? moneyPoolId;
  bool? showTotal;
  dynamic? createdAt;
  List<ContributingUser> contributingUsers;
  List<PublicUserInfo> invitedUsers;
  // for querying purposes
  List<String> contributingUserIds;
  List<String> invitedUserIds;

  MoneyPoolModel.empty()
      : this.name = "",
        this.adminUID = "",
        this.adminName = "",
        this.moneyPoolId = "",
        this.total = -1.0,
        this.currency = "",
        this.description = "",
        this.createdAt = "",
        this.contributingUsers = [],
        this.contributingUserIds = [],
        this.invitedUsers = [],
        this.invitedUserIds = [],
        this.showTotal = false;

  MoneyPoolModel({
    required this.name,
    required this.adminName,
    required this.adminUID,
    this.createdAt,
    this.moneyPoolId,
    this.total = 0,
    this.currency = "cad",
    this.description,
    this.showTotal = true,
    required this.contributingUserIds,
    required this.contributingUsers,
    required this.invitedUserIds,
    required this.invitedUsers,
  });

  MoneyPoolModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        adminUID = json['adminUID'],
        adminName = json['adminName'],
        moneyPoolId = json['moneyPoolId'],
        showTotal = json['showTotal'],
        createdAt = json['createdAt'] as Timestamp?,
        total = json['total'],
        currency = json['currency'],
        description = json['description'],
        contributingUsers = [],
        contributingUserIds = [],
        invitedUsers = [],
        invitedUserIds = [] {
    if (json['contributingUsers'] != null) {
      contributingUsers = [];
      json['contributingUsers'].forEach((v) {
        contributingUsers.add(ContributingUser.fromJson(v));
      });
    }
    if (json['contributingUserIds'] != null) {
      contributingUserIds = [];
      json['contributingUserIds'].forEach((v) {
        contributingUserIds.add(v);
      });
    }
    if (json['invitedUsers'] != null) {
      invitedUsers = [];
      json['invitedUsers'].forEach((v) {
        invitedUsers.add(PublicUserInfo.fromJson(v));
      });
    }
    if (json['invitedUserIds'] != null) {
      invitedUserIds = [];
      json['invitedUserIds'].forEach((v) {
        invitedUserIds.add(v);
      });
    }
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
    data['currency'] = this.currency;
    try {
      this.createdAt as FieldValue?;
      data['createdAt'] = this.createdAt as FieldValue?;
    } catch (e) {
      // Don't add field to json if it's not a field value!
      print("createdAt left as is!");
    }
    data['showTotal'] = this.showTotal;
    data['contributingUserIds'] = this.contributingUserIds;
    data['contributingUsers'] =
        this.contributingUsers.map((v) => v.toJson()).toList();
    data['invitedUserIds'] = this.invitedUserIds;
    data['invitedUsers'] = this.invitedUsers.map((v) => v.toJson()).toList();
    return data;
  }
}

class ContributingUser {
  String name;
  String uid;
  num contribution;

  ContributingUser(
      {required this.uid, required this.name, this.contribution = 0.0});

  ContributingUser.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        name = json['name'],
        contribution = json['contribution'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['contribution'] = this.contribution;
    return data;
  }
}
