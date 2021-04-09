import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:good_wallet/utils/datamodel_helpers.dart';

class DonationModel {
  final String? projectId;
  final String? projectName;
  final num? amount;
  final String? currency;
  String? organizationName;
  String? message;
  Timestamp? createdAt;
  String? transactionId;
  String? status;

  DonationModel({
    required this.projectId,
    required this.projectName,
    required this.amount,
    required this.currency,
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
    // TODO: How to catch error if map does not contain keys?
    DonationModel returnData;
    try {
      returnData = DonationModel(
          projectId: map['projectId'],
          projectName: map['projectName'],
          amount: map['amount'],
          currency: map['currency']);
      returnData.organizationName = returnIfAvailable(map, 'organizationName');
      returnData.transactionId = returnIfAvailable(map, "transactionId");
      returnData.message = returnIfAvailable(map, "message");
      returnData.createdAt = returnIfAvailable(map, "createdAt");
      returnData.status = returnIfAvailable(map, "status");
    } catch (e) {
      rethrow;
    }
    return returnData;
  }
}
