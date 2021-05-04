import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/money_pools/money_pool_model.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:good_wallet/ui/views/money_pools/components/user_payout_form.form.dart';
import 'package:good_wallet/utils/logger.dart';

class UserPayoutFormModel extends FormViewModel {
  final List<ContributingUser> usersInfo;
  final void Function() onSetFormStatus;
  UserPayoutFormModel({required this.usersInfo, required this.onSetFormStatus});

  final log = getLogger("user_payout_form_model.dart");

  ContributingUser? selectedUser;
  bool get hasSelectedUser => selectedUser != null;
  String? selectedUserName;

  // Gets current user input
  // Called from DisburseMoneyPoolModel
  num getAmount() {
    if (amountValue != null && amountValue != "") {
      try {
        num valueToParse = num.parse(amountValue!);
        return valueToParse;
      } catch (e) {
        log.v(
            "Returning zero because somehow string is not formatted correctly! Error thrown ${e.toString()}");
        return 0;
      }
    } else {
      return 0;
    }
  }

  List<String> getUserNames() {
    //return ["hi", "WAS GEHT", "YES", "SO LONG", "MORE", "MORE", "ANOTHER"];
    return usersInfo.map((e) => e.name).toList();
  }

  // When user is selected from dropdown
  void selectUser(String selection) {
    Map<String, dynamic> data = {NameValueKey: selection};
    setData(data);
    // set data for form view model
    selectedUser =
        usersInfo.where((element) => element.name == selection).first;
    selectedUserName = selection;
    notifyListeners();
    log.i("Selected User: $selectedUserName");
  }

  // When selected user is clicked we want to show the dropdown again!
  void editSelectedUser() {
    log.i("Remove user");
    selectedUser = null;
    notifyListeners();
  }

  // Check if inputs are valid
  bool isValidInput() {
    if (!hasSelectedUser) return false;
    if (amountValue == null) return false;
    if (getAmount() == 0) return false;
    if (getAmount() < 0) return false;
    return true;
  }

  // Implement callback function to change values in DisburseMoneyPoolViewModel
  @override
  void setFormStatus() {
    onSetFormStatus();
  }
}
