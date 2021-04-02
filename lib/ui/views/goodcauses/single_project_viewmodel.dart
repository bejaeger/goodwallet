import 'package:flutter/material.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/services/payments/dummy_payment_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

class SingleProjectViewModel extends BaseModel {
  final _dialogService = locator<DialogService>();
  final _dummyPaymentService = locator<DummyPaymentService>();

  Future showConfirmationDialog(
      String projectTitle, String donationAmount) async {
    DialogResponse response = await _dialogService.showConfirmationDialog(
      title: 'Confirmation',
      description:
          "Are you sure that you want to donate $donationAmount good dollars to $projectTitle",
      confirmationTitle: 'Yes',
      dialogPlatform: DialogPlatform.Material,
      cancelTitle: 'No',
    );
    _dummyPaymentService.processDonation(currentUser.id, "Dummy");
    print('DialogResponse: ${response?.confirmed}');
  }

  Future showAmountTooHighDialog(String donationAmount) async {
    await _dialogService.showConfirmationDialog(
      title: 'Donation Amount Too High',
      description:
          'You cannot pay \$ ${donationAmount} with just \$ ${userWallet.currentBalance}',
    );
  }

  Future confirmationOrCancellationDistributor(
      String projectTitle, int donationAmount) {
    if ((userWallet.currentBalance - donationAmount) < 0) {
      showAmountTooHighDialog(donationAmount.toString());
    } else {
      showConfirmationDialog(projectTitle, donationAmount.toString());
    }
  }
}
