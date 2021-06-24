import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/recipient_info.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/sender_info.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
import 'package:good_wallet/datamodels/transfers/transfer_details.dart';
import 'package:good_wallet/datamodels/user/statistics/user_statistics.dart';
import 'package:good_wallet/datamodels/user/user.dart';
import 'package:good_wallet/enums/bottom_navigator_index.dart';
import 'package:good_wallet/enums/money_source.dart';
import 'package:good_wallet/enums/transfer_type.dart';
import 'package:good_wallet/exceptions/firestore_api_exception.dart';
import 'package:good_wallet/exceptions/money_transfer_exception.dart';
import 'package:good_wallet/exceptions/user_service_exception.dart';
import 'package:good_wallet/services/payments/dummy_payment_service.dart';
import 'package:good_wallet/services/user/user_service.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:good_wallet/ui/views/transfer_funds/transfer_funds_amount_view.form.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

/////////////////////////////////////////////////////////////////
///
/// Viewmodel handling the logic for different types of payments
///
/// This has lot of if () {} else if () {} logic!
/// This can be improved by thinking about a cleaner configuration
///
/// Make unions for senderInfo and recipientInfo to distinguish money transfer types
///

class TransferFundsAmountViewModel extends FormViewModel {
  final NavigationService? _navigationService = locator<NavigationService>();
  final BottomSheetService? _bottomSheetService = locator<BottomSheetService>();
  final SnackbarService? _snackbarService = locator<SnackbarService>();
  final UserService? _userService = locator<UserService>();
  final DialogService? _dialogService = locator<DialogService>();
  User get currentUser => _userService!.currentUser;
  final DummyPaymentService _dummyPaymentService =
      locator<DummyPaymentService>();

  final log = getLogger("transfer_funds_amount_viewmodel.dart");

  StreamSubscription<UserStatistics>? _walletSubscription;

  UserStatistics get userStats => _userService!.userStats!;

  final TransferType type;

  final RecipientInfo? recipientInfo;

  final SenderInfo senderInfo;

  num? amount;

  // TODO: Validate inputs here... if Donation, recipientInfo must not be null!
  TransferFundsAmountViewModel(
      {required this.type, this.recipientInfo, required this.senderInfo});

  // The functionality from stacked's form view is
  // not working properly (not sure exactly why).
  // This has to do with how we wrap the entire
  // App with the Unfocuser, see main.dart.
  // For the time being we just use our own validation
  // message string
  String? customValidationMessage;
  void setCustomValidationMessage(String msg) {
    customValidationMessage = msg;
  }

  //User get currentUser => _userService.currentUser;

  Map<String, dynamic>? _paymentSheetData;

  Map<String, dynamic>? get getPaymentSheetData => _paymentSheetData;

  Future<Map<String, dynamic>> _createTestPaymentSheet() async {
    final http.Response response =
        await http.post(Uri.parse('Cloud FUNCTION URL, $amountValue!'));
    if (response.body != null) {
      return json.decode(response.body);
    } else {
      _snackbarService!.showSnackbar(
          title: "Error Message.",
          message: 'Error code: ${_paymentSheetData!['error']}',
          duration: Duration(seconds: 2));
    }
    return json.decode(response.body);
  }

  Future<void> initPaymentSheet() async {
    try {
      // 1. create payment intent on the server
      _paymentSheetData = await _createTestPaymentSheet();

      if (_paymentSheetData!['error'] != null) {
        _snackbarService!.showSnackbar(
            title: "Error Message.",
            message: 'Error code: ${_paymentSheetData!['error']}',
            duration: Duration(seconds: 2));

        return;
      }
      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          applePay: true,
          googlePay: true,
          style: ThemeMode.dark,
          testEnv: true,
          merchantCountryCode: 'DE',
          merchantDisplayName: currentUser.fullName,
          customerId: _paymentSheetData!['customer'],
          paymentIntentClientSecret: _paymentSheetData!['paymentIntent'],
          customerEphemeralKeySecret: _paymentSheetData!['ephemeralKey'],
        ),
      );
    } catch (e) {
      _snackbarService!.showSnackbar(
          title: "Error Message.",
          message: "Error: $e",
          duration: Duration(seconds: 2));
    }
  }

  Future<void> displayPaymentSheet() async {
    setBusy(true);
    try {
      // 3. display the payment sheet.
      await Stripe.instance.presentPaymentSheet(
          parameters: PresentPaymentSheetParameters(
        clientSecret: _paymentSheetData!['paymentIntent'],
        confirmPayment: true,
      ));

      _paymentSheetData = null;

      _snackbarService!.showSnackbar(
          title: "Payment Made Successfully.",
          message: 'Payment succesfully completed',
          duration: Duration(seconds: 2));
    } catch (e) {
      _snackbarService!.showSnackbar(
          title: "Error Message.",
          message: "Error: $e",
          duration: Duration(seconds: 2));
    }
    setBusy(false);
    notifyListeners();
  }

  Future showBottomSheetAndProcessPayment() async {
    if (!isValidData()) {
      log.e("Entered amount not valid");
      notifyListeners();
    } else {
      amount = num.parse(amountValue!);
      if (type == TransferType.User2OwnPrepaidFund)
        await handleTopUpPayment();
      else if (type == TransferType.User2UserSent) {
        await handleTransfer(type: type);
      } else if (type == TransferType.User2Project) {
        await handleTransfer(type: type);
      } else if (type == TransferType.User2MoneyPool) {
        await handleTransfer(type: type);
      } else {
        _snackbarService!.showSnackbar(
            title: "Not yet implemented.", message: "I know... it's sad");
      }
    }
  }

  // Validate user input, very important function, TODO: should be unit tested!
  bool isValidData() {
    // check if amount is valid!
    if (amountValue == null) {
      log.i("No valid amount");
      setCustomValidationMessage("Please enter valid amount.");
    } else if (amountValue == "") {
      log.i("No valid amount");
      setCustomValidationMessage("Please enter valid amount.");
    } else if (double.parse(amountValue!) < 0) {
      log.i("Amount < 0");
      setCustomValidationMessage("Please enter valid amount.");
    } else if (double.parse(amountValue!) > 1000) {
      log.i("Amount = ${double.parse(amountValue!)}  > 1000");
      setCustomValidationMessage(
          "Are you sure you want to top up as much as ${formatAmount(double.parse(amountValue!), true)}");
    } else if (type == TransferType.User2Project &&
        scaleAmountForStripe(double.parse(amountValue!)) >
            userStats.currentBalance) {
      setCustomValidationMessage(
          "Your requested donation is higher than your account balance. You can donate from your bank account directly, or choose a smaller amount.");
    }
    return customValidationMessage == null;
  }

  // Function for the user to change the money source for the payment
  // Will replace the current view with the one corresponding to the
  // selected payment method
  Future changePaymentMethod() async {
    if (type == TransferType.User2MoneyPool) {
      SheetResponse? sheetResponse = await _bottomSheetService!.showBottomSheet(
          title: "Select Payment Method",
          description: "OR add new payment method +",
          confirmButtonTitle: "Bank Account",
          cancelButtonTitle: "Prepaid Fund");
      if (sheetResponse?.confirmed == true &&
          senderInfo.moneySource == MoneySource.GoodWallet) {
        await _navigationService!.replaceWith(Routes.transferFundsAmountView,
            arguments: TransferFundsAmountViewArguments(
                type: type,
                senderInfo: senderInfo.copyWith(moneySource: MoneySource.Bank),
                recipientInfo: recipientInfo));
      }
      if (sheetResponse?.confirmed == false &&
          senderInfo.moneySource == MoneySource.Bank) {
        await _navigationService!.replaceWith(Routes.transferFundsAmountView,
            arguments: TransferFundsAmountViewArguments(
                type: type,
                senderInfo:
                    senderInfo.copyWith(moneySource: MoneySource.PrepaidFund),
                recipientInfo: recipientInfo));
      }
    }

    if (type == TransferType.User2Project) {
      SheetResponse? sheetResponse = await _bottomSheetService!.showBottomSheet(
          title: "Select Payment Method",
          description: "OR add new payment method +",
          confirmButtonTitle: "Bank Account",
          cancelButtonTitle: "Good Wallet");
      if (sheetResponse?.confirmed == true &&
          senderInfo.moneySource == MoneySource.GoodWallet) {
        await _navigationService!.replaceWith(Routes.transferFundsAmountView,
            arguments: TransferFundsAmountViewArguments(
                senderInfo: senderInfo.copyWith(moneySource: MoneySource.Bank),
                type: type,
                recipientInfo: recipientInfo));
      }
      if (sheetResponse?.confirmed == false &&
          senderInfo.moneySource == MoneySource.Bank) {
        await _navigationService!.replaceWith(Routes.transferFundsAmountView,
            arguments: TransferFundsAmountViewArguments(
                senderInfo:
                    senderInfo.copyWith(moneySource: MoneySource.GoodWallet),
                type: type,
                recipientInfo: recipientInfo));
      }
    }
  }

  // TODO: TO BE Deprecated
  // include in handleTransfer
  Future handleTopUpPayment() async {
    SheetResponse? sheetResponse = await _showPaymentMethodBottomSheet();
    log.i("Response data from bottom sheet: ${sheetResponse?.confirmed}");
    if (sheetResponse?.confirmed == false) {
      // FOR now, implemented dummy payment processing here
      showNotYetImplementedSnackbar();
    } else {
      // Properly add Gpay / Credit card pay / ...
      showNotYetImplementedSnackbar();
    }
  }

  Future handleTransfer({required TransferType type}) async {
    SheetResponse? sheetResponse =
        await _showPaymentMethodBottomSheet(type: type);
    if (sheetResponse?.confirmed == false) {
      // Ask for another final confirmation
      SheetResponse? finalConfirmation =
          await _showFinalConfirmationBottomSheet();
      if (finalConfirmation?.confirmed == false) {
        await _showAndAwaitSnackbar("You can come back any time :)");
        setBusy(false);
        navigateBack();
        return;
      }

      // FOR now, implemented dummy payment processing here
      setBusy(true);
      try {
        final data = prepareTransferData();

        await _dummyPaymentService.processTransfer(moneyTransfer: data);

        log.i("Processed transfer: $data");
      } catch (e) {
        if (e is MoneyTransferException) {
          await _showFailureDialog(e.prettyDetails);
        } else if (e is UserServiceException) {
          await _showFailureDialog(e.prettyDetails);
        } else if (e is FirestoreApiException) {
          await _showFailureDialog(e.prettyDetails);
        } else {
          rethrow;
        }
        setBusy(false);
        clearTillFirstAndShowHomeScreen();
        return;
      }
      await _showAndAwaitSnackbar("Success! You are great :)");
      setBusy(false);

      if (type == TransferType.User2MoneyPool) {
        // navigate back to money pool
        navigateBack();
      } else {
        // clear view
        clearTillFirstAndShowHomeScreen();
      }
    } else if (sheetResponse?.confirmed == true) {
      await _showAndAwaitSnackbar("Not supported at the moment, sorry!");
    }
  }

  // returning the money transfer object that will be pushed to firestore
  MoneyTransfer prepareTransferData() {
    try {
      RecipientInfo actualRecipientId = recipientInfo ??
          RecipientInfo.user(
              name: senderInfo.name ?? currentUser.fullName,
              id: senderInfo.id ?? currentUser.uid);
      final transferDetails = TransferDetails(
        recipientId: actualRecipientId.id,
        recipientName: actualRecipientId.name,
        senderId: senderInfo.id ?? currentUser.uid,
        senderName: senderInfo.name ?? currentUser.fullName,
        sourceType: senderInfo.moneySource,
        amount: scaleAmountForStripe(amount!),
        currency: 'cad',
      );

      MoneyTransfer data = actualRecipientId.maybeMap(
        donation: (value) => MoneyTransfer.donation(
          transferDetails: transferDetails,
          projectInfo: value.projectInfo,
        ),
        moneyPool: (value) => MoneyTransfer.moneyPoolContribution(
          transferDetails: transferDetails,
          moneyPoolInfo: value.moneyPoolInfo,
        ),
        orElse: () => MoneyTransfer.peer2peer(
          transferDetails: transferDetails,
        ),
      );
      return data;
    } catch (e) {
      log.e(
          "Could not fill transaction model, Failed with error ${e.toString()}");
      throw MoneyTransferException(
          message:
              "Something went wrong when preparing the transfer. We apologize, please contact support or try again later.",
          prettyDetails:
              "Something went wrong when preparing the transfer. We apologize, please contact support or try again later.",
          devDetails: '$e');
    }
  }

  void navigateBack() {
    _navigationService!.back(result: "contributed");
  }

  /////////////////////////////////////////////////////////////////////
  // Pop-ups!

  Future _showAndAwaitSnackbar(String message) async {
    _snackbarService!.showSnackbar(
        duration: Duration(seconds: 2), title: message, message: "");
    await Future.delayed(Duration(seconds: 2));
  }

  Future _showPaymentMethodBottomSheet({TransferType? type}) async {
    String description = "OR add new payment method +";
    if (type != null && type == TransferType.User2Project) {
      description =
          "To keep growing and reach more people, the Good Wallet Foundation will take a default 5\% of your donation. You are free to choose a any other amount (NOT YET IMPLEMENTED). Thank you for your support!";
    }
    return await _bottomSheetService!.showBottomSheet(
        title: "Select Payment Method",
        description: description,
        confirmButtonTitle: "Credit Card / Google Pay",
        cancelButtonTitle: "Test Payment");
  }

  Future _showFailureDialog(String? message) async {
    return await _dialogService!.showDialog(
      title: 'Error',
      description: message,
      dialogPlatform: DialogPlatform.Material,
    );
  }

  Future _showFinalConfirmationBottomSheet() async {
    return await _bottomSheetService!.showBottomSheet(
      title: 'Confirmation',
      description:
          "Are you sure you would like to send ${formatAmount(amount, true)}${getSenderInfoString(senderInfo)}${getRecipientInfoString(recipientInfo)}?",
      confirmButtonTitle: 'Yes',
      cancelButtonTitle: 'No',
    );
  }

  String getSenderInfoString(senderInfo) {
    String returnString = "";
    if (senderInfo.moneySource == MoneySource.Bank) {
      returnString = " from your Bank";
    } else if (senderInfo.moneySource == MoneySource.GoodWallet) {
      returnString = " from your Good Wallet";
    } else if (senderInfo.moneySource == MoneySource.PrepaidFund) {
      returnString = " from your Prepaid Fund";
    }
    return returnString;
  }

  String getRecipientInfoString(senderInfo) {
    String returnString = "";
    if (recipientInfo != null) {
      returnString = recipientInfo!.map(
          user: (value) => " to ${value.name}",
          moneyPool: (value) => " to money pool with name ${value.name}",
          donation: (value) => " to project with name ${value.name}");
    }
    return returnString;
  }

  Future showNotYetImplementedSnackbar() async {
    _snackbarService!.showSnackbar(
        title: "Not yet implemented.", message: "I know... it's sad");
  }

  ////////////////////////////////////////////////////////////////
  // Navigations
  //
  void clearTillFirstAndShowHomeScreen() {
    _navigationService!.clearTillFirstAndShow(Routes.layoutTemplateViewMobile,
        arguments: LayoutTemplateViewMobileArguments(
            initialBottomNavBarIndex: BottomNavigatorIndex.Home.index));
  }

  Future navigateToSingleProjectScreen({required String projectId}) async {
    await _navigationService!.navigateTo(Routes.singleProjectViewMobile,
        arguments: SingleProjectViewMobileArguments(projectId: projectId));
  }

  ////////////////////////////////////////////////////////////////
  /// Technicalities
  //
  @override
  void dispose() {
    _walletSubscription?.cancel();
    super.dispose();
  }

  @override
  void setFormStatus() async {
    // THIS IS A HACK!
    // Otherwise the customvalidation message is overwritten before showing!
    // Need to fix this properly at some point!
    await Future.delayed(Duration(seconds: 4));
    log.i("Set custom Form status");
    customValidationMessage = null;
  }
}
