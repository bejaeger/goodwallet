import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/money_pools/payouts/money_pool_payout.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
import 'package:good_wallet/enums/transfer_type.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/image_icon_paths.dart';
import 'package:good_wallet/ui/shared/money_transfers/transfer_history_entry_style.dart';

import 'package:good_wallet/utils/logger.dart';

final _log = getLogger("money_transfer_style_helpers.dart");

// Get style for entry in recent activities / transfer history view
TransferHistoryEntryStyle getTransactionsCorrespondingToTypeHistoryEntryStyle(
    {required MoneyTransfer data, required TransferType type}) {
  return data.map(
    donation: (value) => TransferHistoryEntryStyle(
      color: ColorSettings.primaryColor,
      descriptor: "Donated to",
      nameToDisplay: value.transferDetails.recipientName,
      icon: Icon(Icons.favorite, color: ColorSettings.whiteTextColor, size: 22),
    ),
    peer2peer: (value) => TransferHistoryEntryStyle(
      color: type == TransferType.Peer2PeerSent
          ? MyColors.paletteBlue
          : MyColors.paletteTurquoise,
      descriptor:
          type == TransferType.Peer2PeerSent ? "Gifted to" : "Received from",
      nameToDisplay: type == TransferType.Peer2PeerSent
          ? value.transferDetails.recipientName
          : value.transferDetails.senderName,
      icon: Image.asset(ImageIconPaths.huggingPeople,
          height: 18, color: ColorSettings.whiteTextColor),
    ),
    moneyPoolContribution: (value) => TransferHistoryEntryStyle(
      color: MyColors.paletteGreen,
      descriptor: "Contributed to money pool",
      nameToDisplay: value.moneyPoolInfo.name,
      icon: Icon(Icons.people_rounded, color: ColorSettings.whiteTextColor),
    ),
    moneyPoolPayoutTransfer: (value) => TransferHistoryEntryStyle(
      color: MyColors.paletteGreen,
      descriptor: "From money pool",
      nameToDisplay: value.moneyPoolInfo.name,
      icon: Icon(Icons.people_rounded, color: ColorSettings.whiteTextColor),
    ),
  );
}
