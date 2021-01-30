import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class WalletBalancesModel {
  final double currentBalance;
  final double donated;
  final double sentToPeer;

  WalletBalancesModel({this.currentBalance, this.donated, this.sentToPeer});

  WalletBalancesModel.empty()
      : this.currentBalance = 0,
        this.donated = 0,
        this.sentToPeer = 0;

  Map<String, dynamic> toJson() {
    var returnJson = {
      'currentBalance': currentBalance,
      'donated': donated,
      'sentToPeer': sentToPeer,
    };
    return returnJson;
  }

  static WalletBalancesModel fromMap(Map<String, dynamic> map) {
    var data = WalletBalancesModel(
      currentBalance: map['currentBalance'],
      donated: map['donated'],
      sentToPeer: map['sentToPeer'],
    );
    return data;
  }
}
