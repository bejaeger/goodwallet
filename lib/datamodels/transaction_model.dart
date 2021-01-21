import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class TransactionModel {
  final String recipientUid;
  final String recipientName;
  final String senderUid;
  final String senderName;
  final num amount;
  final String currency;
  String message;
  Timestamp createdAt;
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
    this.transactionId,
    this.message,
    this.createdAt,
    this.status,
    this.topUp,
  });

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
      'createdAt': createdAt,
      'status': status,
      'topUp': topUp,
    };
    return returnJson;
  }

  static TransactionModel fromMap(Map<String, dynamic> map) {
    var data = TransactionModel(
        recipientUid: map['recipientUid'],
        recipientName: map['recipientName'],
        senderUid: map['senderUid'],
        senderName: map['senderName'],
        amount: map['amount'],
        currency: map['currency']);
    if (map.containsKey("transactionId")) {
      data.transactionId = map["transactionId"];
    }
    if (map.containsKey("message")) {
      data.message = map["message"];
    }
    if (map.containsKey("createdAt")) {
      data.createdAt = map["createdAt"];
    }
    if (map.containsKey("status")) {
      data.status = map["status"];
    }
    if (map.containsKey("topUp")) {
      data.topUp = map["topUp"];
    }
    return data;
  }
}
