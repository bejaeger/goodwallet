import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/user/user.dart';
import 'package:good_wallet/services/payments/dummy_payment_service.dart';
import 'package:good_wallet/services/user/user_service.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:http/http.dart' as http;
import 'payments_view.form.dart';

class PaymentViewModel extends FormViewModel {
  final _snackbarService = locator<SnackbarService>();
  final _userService = locator<UserService>();
  final _dummyPaymentService = locator<DummyPaymentService>();

  User get currentUser => _userService.currentUser;

  Map<String, dynamic>? _paymentSheetData;

  Map<String, dynamic>? get getPaymentSheetData => _paymentSheetData;

  String? customValidationMessage;
  void setCustomValidationMessage(String msg) {
    customValidationMessage = msg;
  }

  Future<Map<String, dynamic>> _createTestPaymentSheet() async {
    final http.Response response = await http.post(Uri.parse(
        ' https://us-central1-gooddollarsmarketplace.cloudfunctions.net/user-onStripeCreatePaymentIntent'));
    if (response.body != null) {
      return json.decode(response.body);
    } else {
      _snackbarService.showSnackbar(
          title: "Error Message.",
          message: 'Error code: ${_paymentSheetData!['error']}',
          duration: Duration(seconds: 2));
    }
    return json.decode(response.body);
  }

  // Validate user input, very important function, TODO: should be unit tested!
  bool isValidData() {
    // amount = num.parse(amountValue!);
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
    }

    return customValidationMessage == null;
  }

  Future initPaymentSheet() async {
    try {
      if (amountValue! != null) {}

      // 1. create payment intent on the server
      _paymentSheetData = await _createTestPaymentSheet();

      if (_paymentSheetData!['error'] != null) {
        _snackbarService.showSnackbar(
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
          merchantCountryCode: 'CAD',
          merchantDisplayName: currentUser.fullName,
          customerId: _paymentSheetData!['customer'],
          paymentIntentClientSecret: _paymentSheetData!['paymentIntent'],
          customerEphemeralKeySecret: _paymentSheetData!['ephemeralKey'],
        ),
      );
    } catch (e) {
      _snackbarService.showSnackbar(
          title: "Error Message.",
          message: "Error: $e",
          duration: Duration(seconds: 2));
    }
  }

  sendAmount({required String amount}) {
    setBusy(true);
    int recvdAmount = int.parse(amount);
    //= int.parse(amount);
    try {
      if (recvdAmount != null) {
        _dummyPaymentService.createsStripeUser(
            email: _userService.currentUser.email);

        _dummyPaymentService.createStripePaymentIntent(
            amount: recvdAmount.toString(),
            currency: 'CAD',
            paymentMethod: PaymentMethodParams.card());
      } else {
        log.i('Amount is Null $recvdAmount!');
      }
    } catch (e) {
      _snackbarService.showSnackbar(
          title: "Error Message.",
          message: "Error: $e",
          duration: Duration(seconds: 2));
    }
    setBusy(false);
    notifyListeners();
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

      _snackbarService.showSnackbar(
          title: "Payment Made Successfully.",
          message: 'Payment succesfully completed',
          duration: Duration(seconds: 2));
    } catch (e) {
      _snackbarService.showSnackbar(
          title: "Error Message.",
          message: "Error: $e",
          duration: Duration(seconds: 2));
    }
    setBusy(false);
    notifyListeners();
  }

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }
}
