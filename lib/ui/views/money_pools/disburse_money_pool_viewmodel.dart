import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:flutter/material.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/money_pools/base/money_pool.dart';
import 'package:good_wallet/datamodels/money_pools/payouts/money_pool_payout.dart';
import 'package:good_wallet/datamodels/transfers/transfer_details.dart';
import 'package:good_wallet/enums/bottom_navigator_index.dart';
import 'package:good_wallet/enums/money_source.dart';
import 'package:good_wallet/services/money_pools/money_pools_service.dart';
import 'package:good_wallet/services/payments/dummy_payment_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:good_wallet/ui/views/money_pools/components/user_payout_form.dart';
import 'package:good_wallet/ui/views/money_pools/components/user_payout_form_model.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class DisburseMoneyPoolViewModel extends BaseModel {
  MoneyPool moneyPool;
  final BottomSheetService? _bottomSheetService = locator<BottomSheetService>();
  final MoneyPoolsService? _moneyPoolsService = locator<MoneyPoolsService>();
  final NavigationService? _navigationService = locator<NavigationService>();
  final DummyPaymentService? _dummyPaymentService =
      locator<DummyPaymentService>();
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
  MoneyPoolPayout _getPayoutDataFromForms() {
    List<String> paidOutIds = [];
    List<TransferDetails> allDetails = [];
    try {
      userPayoutForms.forEach((element) {
        TransferDetails details = TransferDetails(
          senderName: moneyPool.name,
          senderId: moneyPool.moneyPoolId,
          sourceType: MoneySource.MoneyPool,
          amount: scaleAmountForStripe(element.userPayoutFormModel.getAmount()),
          currency: moneyPool.currency,
          recipientId: element.userPayoutFormModel.selectedUser!.uid,
          recipientName: element.userPayoutFormModel.selectedUser!.name,
        );
        allDetails.add(details);
        paidOutIds.add(element.userPayoutFormModel.selectedUser!.uid);
      });
      MoneyPoolPayout data = MoneyPoolPayout(
        transfersDetails: allDetails,
        moneyPool: moneyPool,
        paidOutUsersIds: paidOutIds,
        createdAt: firestore.FieldValue.serverTimestamp(),
        deleteMoneyPool: getSummedPayoutAmount() == moneyPool.total,
      );
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
  // 4. Ask user to close or keep money pool and navigate accordingly
  // 5. push to firestore
  // 6. cloud function takes care of the payouts
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
        MoneyPoolPayout data = _getPayoutDataFromForms();

        MoneyPoolPayout? newData;
        // if money pool is setup for deletion, ask user if he really wants
        // to discontinue the usaage of the money pool
        if (data.deleteMoneyPool == true) {
          var sheetResponse2 = await _showDeletionConfirmationBottomSheet();
          if (sheetResponse2?.confirmed == true) {
            newData = data.copyWith(deleteMoneyPool: false);
          }
        }
        newData = newData ?? data;

        // 4 & 5
        // TODO: This could also provide a return value to be sure things have been dealt with
        setBusy(true);
        await _dummyPaymentService!.submitMoneyPoolPayout(newData);
        setBusy(false);

        if (newData.deleteMoneyPool == false) {
          // navigate to money pool
          _navigationService!.back(result: "paidOut");
        } else {
          // delete money pool and navigate back
          setBusy(true);
          await _moneyPoolsService!.deleteMoneyPool(moneyPool.moneyPoolId);
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
        "Are you sure you would like to payout this money pool?";
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

  Future _showDeletionConfirmationBottomSheet() async {
    return await _bottomSheetService!.showBottomSheet(
      title: "Would you like to continue to use this money pool or delete it?",
      confirmButtonTitle: 'Continue usage',
      cancelButtonTitle: 'Delete',
    );
  }
}
