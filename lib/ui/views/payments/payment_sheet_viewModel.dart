import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/user/user.dart';
import 'package:good_wallet/server_local/config.dart';
import 'package:good_wallet/services/user/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:http/http.dart' as http;

class PaymentViewModel extends BaseViewModel {
  final _snackbarService = locator<SnackbarService>();
  final _userService = locator<UserService>();

  User get currentUser => _userService.currentUser;

  Map<String, dynamic>? _paymentSheetData;

  Map<String, dynamic>? get getPaymentSheetData => _paymentSheetData;

  Future<Map<String, dynamic>> _createTestPaymentSheet() async {
    final url = Uri.parse('$kApiUrl/payment-sheet');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'a': 'a',
      }),
    );
    return json.decode(response.body);
  }

  Future<void> initPaymentSheet() async {
    try {
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
          merchantCountryCode: 'DE',
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
}
