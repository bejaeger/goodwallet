import 'package:flutter/material.dart';
import 'package:good_wallet/enums/transaction_type.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/transactions_history_entry_style.dart';

getTransactionsHistoryEntryStyleFromType(TransactionType type, dynamic data) {
  if (type == TransactionType.Donation) {
    return TransactionHistoryEntryStyle(
        color: ColorSettings.primaryColor,
        descriptor: "Donated to",
        nameToDisplay: data.projectName,
        icon: Icon(Icons.favorite, color: ColorSettings.primaryColorLight));
  } else if (type == TransactionType.Incoming) {
    return TransactionHistoryEntryStyle(
        color: MyColors.paletteTurquoise,
        descriptor: "Reveiced from",
        nameToDisplay: data.senderName,
        icon: Icon(Icons.people_rounded, color: ColorSettings.whiteTextColor));
  } else if (type == TransactionType.TransferredToPeers) {
    return TransactionHistoryEntryStyle(
        color: ColorSettings.primaryColorLight,
        descriptor: "Gifted to",
        nameToDisplay: data.recipientName,
        icon: Icon(Icons.person, color: ColorSettings.whiteTextColor));
  }
  return null;
}
