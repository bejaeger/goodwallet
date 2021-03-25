import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class WalletBalancesModel {
  final num currentBalance;
  final num donations;
  final num transferredToPeers;

  WalletBalancesModel(
      {this.currentBalance, this.donations, this.transferredToPeers});

  WalletBalancesModel.empty()
      : this.currentBalance = 0,
        this.donations = 0,
        this.transferredToPeers = 0;

  Map<String, dynamic> toJson() {
    var returnJson = {
      'currentBalance': currentBalance,
      'donations': donations,
      'transferredToPeers': transferredToPeers,
    };
    return returnJson;
  }

  static WalletBalancesModel fromData(Map<String, dynamic> map) {
    var data = WalletBalancesModel(
      currentBalance: map['currentBalance'],
      donations: map['donations'],
      transferredToPeers: map['transferredToPeers'],
    );
    return data;
  }
}
