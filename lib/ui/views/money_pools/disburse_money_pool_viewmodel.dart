import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/money_pools/money_pool_model.dart';
import 'package:good_wallet/datamodels/user/public_user_info.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:good_wallet/ui/views/money_pools/components/user_payout_form.dart';
import 'package:good_wallet/ui/views/money_pools/components/user_payout_form_model.dart';
import 'package:good_wallet/ui/views/money_pools/disburse_money_pool_view.dart';
import 'package:good_wallet/utils/logger.dart';

class DisburseMoneyPoolViewModel extends BaseModel {
  MoneyPoolModel moneyPool;
  DisburseMoneyPoolViewModel({required this.moneyPool});

  final log = getLogger("disburse_money_pool_viewmodel.dart");

  int formCounter = 0;
  List<UserPayoutForm> userPayoutForms = [];

  // calculate current balance, that is
  // total raised - selected disbursements
  num getCurrentBalance() {
    return moneyPool.total;
  }

  // Add user to payout
  void addUserPayoutForm() {
    // userPayoutForms.add(UserPayoutForm(
    //     key: ValueKey(formCounter), usersInfo: moneyPool.contributingUsers));
    userPayoutForms.add(UserPayoutForm(
        key: ValueKey(formCounter),
        userPayoutFormModel:
            UserPayoutFormModel(usersInfo: moneyPool.contributingUsers)));
    formCounter++;
    log.i("Added another form for the total of $formCounter forms");
    notifyListeners();
  }

  // Add user to payout
  void removeUserPayoutForm(Key key) {
    log.i("Remove payout form with index $key");
    userPayoutForms.removeWhere((e) => e.key == key);
    notifyListeners();
  }

  // TODO
  void submitMoneyPoolPayout() {
    // 1. check if inputs are valid
    // 2. Then construct money pool payout object
    // 3. push to firebase
    // 4. write cloud function that takes care of the payouts
  }
}
