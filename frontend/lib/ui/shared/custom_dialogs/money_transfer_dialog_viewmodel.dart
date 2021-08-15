import 'dart:async';

import 'package:good_wallet/datamodels/helpers/money_transfer_status_model.dart';
import 'package:good_wallet/enums/money_transfer_dialog_status.dart';
import 'package:good_wallet/enums/transfer_type.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:good_wallet/utils/logger.dart';

class MoneyTransferDialogViewModel extends BaseModel {
  final log = getLogger("money_transfer_dialog_viewmodel.dart");

  MoneyTransferStatusModel? moneyTransferStatus;
  TransferDialogStatus? status;

  String? title;
  String? description;
  String? mainButtonTitle;
  String? secondaryButtonTitle;

  waitForTransfer({required dynamic request}) async {
    if (request.data["moneyTransferStatus"] == null) {
      log.w(
          "Somehow the completer could not be parsed to the money transfer dialog!");
      _setStatusText(TransferDialogStatus.warning, request);
    } else {
      setBusy(true);
      moneyTransferStatus = request.data["moneyTransferStatus"]!;
      await _waitForTransferAndSetStatusText(moneyTransferStatus!, request);
      setBusy(false);
    }
  }

  Future _waitForTransferAndSetStatusText(
      MoneyTransferStatusModel moneyTransferStatus, dynamic request) async {
    status = await moneyTransferStatus.futureStatus;
    _setStatusText(status!, request, moneyTransferStatus.type);
  }

// Set text for status
// TODO: Ultimately put in app strings file!
  void _setStatusText(TransferDialogStatus status, dynamic request,
      [TransferType? type]) {
    if (status == TransferDialogStatus.error) {
      title = "Transfer Failed";
      description =
          "An internal error occured on our side. Please apologize and try again later";
      mainButtonTitle = "Got it";
    } else if (status == TransferDialogStatus.success) {
      if (type == TransferType.User2OwnPrepaidFund) {
        title = "Top-up Successful!";
        mainButtonTitle = "Go Back";
      } else if (type == TransferType.User2UserSent) {
        title = "Transfer Successful!";
        mainButtonTitle = "Go Back";
      } else if (type == TransferType.User2Project) {
        title = "Donation Successful!";
        description = "You just made a difference in the world, Thank you!";
        secondaryButtonTitle = "View More Projects";
        mainButtonTitle = "Go Back";
      } else if (type == TransferType.User2MoneyPool) {
        title = "Contribution Successful!";
        mainButtonTitle = "Go Back";
      } else {
        title = "Success!!";
        description = "You are the best!";
        mainButtonTitle = "Go Back";
      }
    } else {
      title = "Warning";
      description =
          "Your transaction could not be processed because of an internal error. We apologize, please try again later.";
      mainButtonTitle = "Go Back";
    }
  }
}
