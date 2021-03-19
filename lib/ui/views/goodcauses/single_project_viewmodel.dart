import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:good_wallet/app/locator.dart';
import 'package:good_wallet/datamodels/goodcauses/global_giving_project_model.dart';
import 'package:good_wallet/datamodels/goodcauses/good_wallet_project_model.dart';
import 'package:good_wallet/ui/views/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

class SingleProjectViewModel extends BaseModel {
  final _dialogService = locator<DialogService>();

  void donationPopup() {
    print('funktioniert');
  }

  Future showConfirmationDialog(String projectTitle) async {
    DialogResponse response = await _dialogService.showConfirmationDialog(
      title: 'Confirmation',
      description:
          "Are you sure that you want to donate N good dollars to $projectTitle",
      confirmationTitle: 'Yes',
      dialogPlatform: DialogPlatform.Material,
      cancelTitle: 'No',
    );

    print('DialogResponse: ${response?.confirmed}');
  }
}
