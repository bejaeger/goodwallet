import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class WalletBalancesModel {
  final num currentBalance;
  final num donations;
  final num transferredToPeers;
  final num raised;

  WalletBalancesModel(
      {this.currentBalance = 0,
      this.donations = 0,
      this.transferredToPeers = 0,
      this.raised = 0});

  WalletBalancesModel.empty()
      : this.currentBalance = 0,
        this.donations = 0,
        this.transferredToPeers = 0,
        this.raised = 0;

  Map<String, dynamic> toJson() {
    var returnJson = {
      'currentBalance': currentBalance,
      'donations': donations,
      'transferredToPeers': transferredToPeers,
      'raised': raised,
    };
    return returnJson;
  }

  static WalletBalancesModel fromData(Map<String, dynamic> map) {
    var data = WalletBalancesModel(
      currentBalance: map['currentBalance'],
      donations: map['donations'],
      transferredToPeers: map['transferredToPeers'],
      raised: map['raised'],
    );
    return data;
  }
}
