import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:flutter/material.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/money_pools/money_pool_model.dart';
import 'package:good_wallet/datamodels/money_pools/money_pool_payout_model.dart';
import 'package:good_wallet/datamodels/money_pools/users/paid_out_user.dart';
import 'package:good_wallet/datamodels/transactions/transaction_details.dart';
import 'package:good_wallet/enums/bottom_navigator_index.dart';
import 'package:good_wallet/enums/money_source.dart';
import 'package:good_wallet/services/money_pools/money_pool_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:good_wallet/ui/views/money_pools/components/user_payout_form.dart';
import 'package:good_wallet/ui/views/money_pools/components/user_payout_form_model.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/datamodels/transactions/transaction.dart';

class DisburseMoneyPoolViewModel extends BaseModel {
  MoneyPoolModel moneyPool;
  final BottomSheetService? _bottomSheetService = locator<BottomSheetService>();
  final MoneyPoolService? _moneyPoolService = locator<MoneyPoolService>();
  final NavigationService? _navigationService = locator<NavigationService>();
  // Available balance
  late num availableBalance;
  DisburseMoneyPoolViewModel({required this.moneyPool}) {
    availableBalance = moneyPool.total;
  }

  String? validationMessage;

  final log = getLogger("disburse_money_pool_viewmodel.dart");

  int formCounter = 0;
  List<UserPayoutForm> userPayoutForms = [];

  // calculate current balance, that is
  // total raised - selected disbursements
  Future<void> updateAvailableBalance() async {
    availableBalance = moneyPool.total - getSummedPayoutAmount();
    if (availableBalance < 0) {
      setValidationMessage(
          "Sum of entered payout amounts exceeds total of money pool.");
    }
    log.v("Updated available balance to $availableBalance");
    notifyListeners();
  }

  num getSummedPayoutAmount() {
    num returnValue = 0;
    userPayoutForms.forEach((element) {
      returnValue += element.userPayoutFormModel.getAmount();
    });
    return scaleAmountForStripe(returnValue);
  }

  // Add payment form with user input and input for amount
  void addUserPayoutForm() {
    userPayoutForms.add(UserPayoutForm(
        key: ValueKey(formCounter),
        userPayoutFormModel: UserPayoutFormModel(
            usersInfo: moneyPool.contributingUsers,
            onSetFormStatus: updateAvailableBalance)));
    formCounter++;
    log.v("Added another form for the total of $formCounter forms");
    notifyListeners();
  }

  // Add user to payout
  void removeUserPayoutForm(Key key) {
    log.v("Remove payout form with index $key");
    userPayoutForms.removeWhere((e) => e.key == key);
    updateAvailableBalance();
    notifyListeners();
  }

  // Check if input data is valid
  bool isValidPayoutData() {
    setValidationMessage(null);
    bool singleFormsValid = userPayoutForms.length > 0
        ? !userPayoutForms
            .any((element) => !element.userPayoutFormModel.isValidInput())
        : false;
    if (!singleFormsValid) return false;
    if (getSummedPayoutAmount() > moneyPool.total) return false;
    return true;
  }

  // Sets validation method; if filled form is not valid
  void setValidationMessage(String? msg) {
    validationMessage = msg;
  }

  //
  MoneyPoolPayoutModel _getPayoutDataFromForms() {
    List<PaidOutUser> paidOutUsers = [];
    List<String> paidOutIds = [];
    List<TransactionDetails> allDetails = [];
    try {
      userPayoutForms.forEach((element) {
        TransactionDetails details = TransactionDetails(
          senderName: moneyPool.name,
          senderId: moneyPool.moneyPoolId!,
          sourceType: MoneySource.MoneyPool,
          amount: scaleAmountForStripe(element.userPayoutFormModel.getAmount()),
          currency: moneyPool.currency,
          recipientId: element.userPayoutFormModel.selectedUser!.uid,
          recipientName: element.userPayoutFormModel.selectedUser!.name,
        );
        allDetails.add(details);

        PaidOutUser user = PaidOutUser(
            uid: element.userPayoutFormModel.selectedUser!.uid,
            name: element.userPayoutFormModel.selectedUser!.name,
            amount:
                scaleAmountForStripe(element.userPayoutFormModel.getAmount()));
        paidOutUsers.add(user);

        paidOutIds.add(user.uid);
      });
      bool keepMoneyPoolAlive = false;
      if (getSummedPayoutAmount() < moneyPool.total) keepMoneyPoolAlive = true;

      MoneyPoolPayoutModel data = MoneyPoolPayoutModel(
          moneyPool: moneyPool,
          paidOutUsers: paidOutUsers,
          paidOutUsersIds: paidOutIds,
          keepMoneyPoolAlive: keepMoneyPoolAlive);

      // Transaction data2 = Transaction.moneyPoolPayout(
      //     transactionsInfo: allDetails,
      //     moneyPool: moneyPool,
      //     paidOutUsersIds: paidOutIds,
      //     status: "initialized",
      //     transactionId: "DUMMY",
      //     createdAt: firestore.FieldValue.serverTimestamp());

      return data;
    } catch (e) {
      log.e(
          "Could not construct payout data from forms, error thrown: ${e.toString()}");
      rethrow;
    }
  }

  // Function constructing the MoneyPoolPayoutModel from the available forms.
  // Is called when pressing payout button
  // 1. check if inputs are valid
  // 2. show bottom sheet and ask for confirmation
  // 3. then construct money pool payout object
  // 4. push to firebase
  // 5. cloud function takes care of the payouts
  // 6. Ask user to close or keep money pool and navigate accordingly
  Future submitMoneyPoolPayout() async {
    // 1
    if (!isValidPayoutData()) {
      setValidationMessage("The entered payout data is not valid.");
      notifyListeners();
      return;
    }

    // 2
    // delay to allow for keyboard to disappear
    await Future.delayed(Duration(milliseconds: 300));
    var sheetResponse = await _showConfirmationBottomSheet();
    if (sheetResponse?.confirmed == true) {
      // 3
      try {
        setBusy(true);
        MoneyPoolPayoutModel data = _getPayoutDataFromForms();
        // 4 & 5
        // TODO: This could also provide a return value to be sure things have been dealt with
        await _moneyPoolService!.submitMoneyPoolPayout(data);
        setBusy(false);

        // 6
        var sheetResponse2 = await _showBottomSheetAfterPayout();
        if (sheetResponse2?.confirmed == true) {
          // navigate to money pool
          _navigationService!.back(result: "paidOut");
        } else {
          // delete money pool and navigate back
          setBusy(true);
          await _moneyPoolService!.deleteMoneyPool(moneyPool.moneyPoolId!);
          _navigationService!.clearTillFirstAndShow(
              Routes.layoutTemplateViewMobile,
              arguments: LayoutTemplateViewMobileArguments(
                  initialBottomNavBarIndex:
                      BottomNavigatorIndex.RaiseMoney.index));
          setBusy(false);
        }
      } catch (e) {
        log.e("Could not handle money pool payout, error: ${e.toString()}");
        await _showErrorBottomSheet();
        setBusy(false);
      }
    }
  }

  //////////////////////////////////////////////////////////////////
  // Some helper functions

  Future _showConfirmationBottomSheet() async {
    String description =
        "Are you sure you would like to disburse and close this money pool?";
    if (getSummedPayoutAmount() < moneyPool.total)
      description =
          "Please note that your specified disbursement does not cover the total money pool, you can continue to use the money pool?";
    return await _bottomSheetService!.showBottomSheet(
      title: 'Confirmation',
      description: description,
      confirmButtonTitle: 'Yes',
      cancelButtonTitle: 'No',
    );
  }

  Future _showErrorBottomSheet() async {
    return await _bottomSheetService!.showBottomSheet(
      title: 'Error',
      description:
          "There was an error when processing the payout. We apologize! Please try again later or contact support.",
    );
  }

  Future _showBottomSheetAfterPayout() async {
    return await _bottomSheetService!.showBottomSheet(
      title: 'Success!',
      description:
          "Would you like to continue to use this money pool or delete it?",
      confirmButtonTitle: 'Continue usage',
      cancelButtonTitle: 'Delete',
    );
  }
}
