import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class TransactionModel {
  final String recipientUID;
  final String recipientName;
  final String senderUID;
  final String senderName;
  final num amount;
  final String currency;
  final String message;
  final FieldValue createdAt;
  final Timestamp timestamp;

  TransactionModel(
      {@required this.recipientUID,
      @required this.recipientName,
      @required this.senderUID,
      @required this.senderName,
      @required this.amount,
      @required this.currency,
      this.message,
      this.timestamp,
      this.createdAt});

  Map<String, dynamic> toJson() {
    var returnJson = {
      'recipientUID': recipientUID,
      'recipientName': recipientName,
      'senderUID': senderUID,
      'senderName': senderName,
      'amount': amount,
      'currency': currency,
      'message': message,
      'createdAt': createdAt,
      'timestamp': timestamp,
    };
    return returnJson;
  }

  static TransactionModel fromMap(Map<String, dynamic> map) {
    return TransactionModel(
        recipientUID: map['recipienUID'],
        recipientName: map['recipientName'],
        senderUID: map['senderUID'],
        senderName: map['senderName'],
        amount: map['amount'],
        currency: map['currency'],
        timestamp: map['createdAt']);
  }
}
