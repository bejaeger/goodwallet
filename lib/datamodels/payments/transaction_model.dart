import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:good_wallet/utils/datamodel_helpers.dart';

class TransactionModel {
  final String recipientUid;
  final String recipientName;
  final String senderUid;
  final String senderName;
  final num amount;
  final String currency;
  String message;
  dynamic createdAt;
  String transactionId;
  String status;
  bool topUp; // if topping up own Good Wallet

  TransactionModel({
    @required this.recipientUid,
    @required this.recipientName,
    @required this.senderUid,
    @required this.senderName,
    @required this.amount,
    @required this.currency,
    @required this.createdAt,
    this.transactionId,
    this.message,
    this.status,
    this.topUp,
  });

  // to be used when data is pushed to firestore (createdAt casted to FieldValue)
  Map<String, dynamic> toJson() {
    var returnJson = {
      'recipientUid': recipientUid,
      'recipientName': recipientName,
      'senderUid': senderUid,
      'senderName': senderName,
      'amount': amount,
      'currency': currency,
      'transactionId': transactionId,
      'message': message,
      'createdAt': createdAt as FieldValue,
      'status': status,
      'topUp': topUp,
    };
    return returnJson;
  }

  // to be used when data is fetched from firestore (createdAt casted to Timestamp)
  static TransactionModel fromMap(Map<String, dynamic> map) {
    var data = TransactionModel(
        recipientUid: map['recipientUid'],
        recipientName: map['recipientName'],
        senderUid: map['senderUid'],
        senderName: map['senderName'],
        amount: map['amount'],
        currency: map['currency'],
        createdAt: map['createdAt'] as Timestamp);
    data.transactionId = returnIfAvailable(map, "transactionId");
    data.message = returnIfAvailable(map, "message");
    data.status = returnIfAvailable(map, "status");
    data.topUp = returnIfAvailable(map, "topUp");
    return data;
  }
}
