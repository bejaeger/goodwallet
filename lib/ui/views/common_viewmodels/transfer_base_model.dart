// Model that has holds some functions for showing transfer information

import 'package:flutter/foundation.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
import 'package:good_wallet/enums/transfer_type.dart';
import 'package:good_wallet/services/userdata/user_data_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:intl/intl.dart';
import 'package:stacked_services/stacked_services.dart';

abstract class TransferBaseViewModel extends BaseModel {
  final UserDataService? _userDataService = locator<UserDataService>();
  final DialogService? _dialogService = locator<DialogService>();

  Future showMoneyTransferInfoDialog(MoneyTransfer transfer) async {
    final details = transfer.transferDetails;
    final String senderName = details.senderName;
    final String recipientName = details.recipientName;
    final String amount = formatAmount(details.amount);
    final String source = describeEnum(details.sourceType.toString());
    final String date =
        DateFormat.yMd().add_jm().format(transfer.createdAt.toDate());
    return await _dialogService!.showDialog(
      title: "Transfer details:",
      description:
          "From: $senderName\nTo: $recipientName\nAmount: $amount\nDate: $date\nSource: $source",
    );
  }

  // helper function that figures out transaction
  // type based on transaction data
  TransferType inferTransactionType(MoneyTransfer transfer) {
    return _userDataService!.inferTransactionType(transfer: transfer);
  }
}
