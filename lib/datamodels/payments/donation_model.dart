import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:good_wallet/utils/datamodel_helpers.dart';

class DonationModel {
  final String projectId;
  final String projectName;
  final num amount;
  final String currency;
  String organizationName;
  String message;
  Timestamp createdAt;
  String transactionId;
  String status;

  DonationModel({
    @required this.projectId,
    @required this.projectName,
    @required this.amount,
    @required this.currency,
    this.organizationName,
    this.transactionId,
    this.message,
    this.createdAt,
    this.status,
  });

  Map<String, dynamic> toJson() {
    var returnJson = {
      'projectId': projectId,
      'projectName': projectName,
      'amount': amount,
      'currency': currency,
      'organizationName': organizationName,
      'transactionId': transactionId,
      'message': message,
      'createdAt': createdAt,
      'status': status,
    };
    return returnJson;
  }

  static DonationModel fromMap(Map<String, dynamic> map) {
    var data = DonationModel(
        projectId: map['projectId'],
        projectName: map['projectName'],
        amount: map['amount'],
        currency: map['currency']);
    data.organizationName = returnIfAvailable(map, 'organizationName');
    data.transactionId = returnIfAvailable(map, "transactionId");
    data.message = returnIfAvailable(map, "message");
    data.createdAt = returnIfAvailable(map, "createdAt");
    data.status = returnIfAvailable(map, "status");
    return data;
  }
}
