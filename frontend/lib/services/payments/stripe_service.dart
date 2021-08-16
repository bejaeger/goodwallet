import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/constants/constants.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
import 'package:good_wallet/exceptions/firestore_api_exception.dart';
import 'package:good_wallet/flavor_config.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

// Not in use at the moment
//

class StripeService {
  final FlavorConfigProvider _flavorConfigProvider =
      locator<FlavorConfigProvider>();
  final log = getLogger('StripeService');

  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
  //convert the payment URL to URI
  static Uri paymentApiUri = Uri.parse(paymentApiUrl);
  Map<String, dynamic>? _paymentSheetData;

  static String secret =
      'sk_test_51HsIjGKMG1WPogVf8sli5xa2YiwRSBnUfZCrekLIypLRwNnOdIA9RWLOM7qm5WazBNmNtWpzJ6k6CfX3JU16n8UH00Df9H4KTH';
  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  // DEPRECATED. Handled in backend
  ///NEW PLUGIN STARTS HERES.
  Future<String> createSetupIntentOnBackend(String email) async {
    final url = Uri.parse('$paymentApiUri/payment_intents');
    final response = await http.post(
      url,
      headers: headers,
      /*  headers: {
        'Content-Type': 'application/json',
      }, */

      body: json.encode({
        'email': email,
      }),
    );
    final Map<String, dynamic> bodyResponse = json.decode(response.body);
    final clientSecret = bodyResponse['clientSecret'] as String;
    log.i('Client token  $clientSecret');

    return clientSecret;
  }

  Future<Map<String, dynamic>> chargeCardOffSession(
      {required String email}) async {
    final url = Uri.parse('$paymentApiUri/charge-card-off-session');
    final response = await http.post(
      url,
      headers: headers,
      /*      headers: {
        'Content-Type': 'application/json',
      }, */
      body: json.encode({'email': email}),
    );
    return json.decode(response.body);
  }

  //NEW PLUGIN ENDS

  // static init() {
  //   StripePayment.setOptions(StripeOptions(
  //       publishableKey:
  //           'pk_test_51HsIjGKMG1WPogVfkBOAiW59LeE9tjOleUdOAShJjTavXqj16ionV9t3pJrhzSML1UDEqQ0xqfNYKLxlqC3J9Jvq00Mm2DkWjz',
  //       merchantId: 'Harguilar Nhanga',
  //       androidPayMode: 'Test'));
  // }

  Map<String, dynamic>? get getPaymentSheetData => _paymentSheetData;

  static Future<Map<String, dynamic>?> _createPaymentIntent(
      {String? amount,
      String? currency,
      String? customer,
      var paymentMethod}) async {
    try {
      /*    var paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest()); */
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'customer': customer,
        'payment_method': 'CreditCard'
      };
      var response =
          await http.post(paymentApiUri, headers: headers, body: body);
      return jsonDecode(response.body);
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  static final HttpsCallable CREATE_INTENT =
      FirebaseFunctions.instance.httpsCallable('onStripeCreatePaymentIntent');

  // static Future<StripeTransactionResponse?> payWithNewCard(
  //     {required String amount,
  //     required String currency,
  //     required String customer}) async {
  //   try {
  //     var paymentMethod = await StripePayment.paymentRequestWithCardForm(
  //         CardFormPaymentRequest());

  //     var paymentIntent = await _createPaymentIntent(
  //         amount: amount,
  //         currency: currency,
  //         customer: customer,
  //         paymentMethod: paymentMethod.card!);

  //     var response = StripePayment.confirmPaymentIntent(PaymentIntent(
  //         clientSecret: paymentIntent!['client_secret'],
  //         paymentMethodId: paymentMethod.id));

  //     StripeService.CREATE_INTENT.call(<String, dynamic>{
  //       'amount': amount,
  //       'currency': 'USD',
  //       'paymentMethod': paymentMethod.card
  //     });

  //     return StripeTransactionResponse(
  //         message: 'Transaction Successfull', success: true);
  //   } catch (error) {
  //     return StripeTransactionResponse(
  //         message: 'Transaction $error', success: true);
  //   }
  //   return null;
  // }

  //New Version of The Package
  Future<Map<String, dynamic>?> _createTestPaymentSheet(
      {required String amount, required String currency}) async {
    try {
      Map<String, dynamic> body = {'amount': amount, 'currency': currency};
      Map<String, String> head = {'Content-Type': 'application/json'};
      final response = await http.post(
        paymentApiUri,
        headers: head,
        body: body,
      );
      // ignore: unnecessary_null_comparison
      if (response.body != null) {
        return json.decode(response.body);
      } else {
        print("NULL VALUE");
      }
      return json.decode(response.body);
    } catch (e) {
      log.i(e.toString());
    }
    return null;
  }

  Future<void> initPaymentSheet(
      {required String amount, required String currency}) async {
    try {
      // 1. create payment intent on the server
      _paymentSheetData =
          await _createTestPaymentSheet(amount: amount, currency: currency);

      if (_paymentSheetData!['error'] != null) {
        log.i('message');
        return;
      }

      // 2. initialize the payment sheet
/*       await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          applePay: true,
          googlePay: true,
          style: ThemeMode.dark,
          testEnv: true,
          merchantCountryCode: 'DE',
          merchantDisplayName: 'Flutter Stripe Store Demo',
          customerId: _paymentSheetData!['customer'],
          paymentIntentClientSecret: _paymentSheetData!['paymentIntent'],
          customerEphemeralKeySecret: _paymentSheetData!['ephemeralKey'],
        ),
      ); */
      // setState(() {});
    } catch (e) {
      log.i(e.toString());
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      // 3. display the payment sheet.
/*       await Stripe.instance.presentPaymentSheet(
          parameters: PresentPaymentSheetParameters(
        clientSecret: _paymentSheetData!['paymentIntent'],
        confirmPayment: true,
      )); */

      //setState(() {
      _paymentSheetData = null;
      log.i('Payment succesfully completed');
    } catch (e) {
      log.e(e.toString());
    }
  }

//Finished Here
  ///Cloud Function are Below.
  // Push transfer document to firestore

  Future createStripeUser({required String email}) async {
    try {
      HttpsCallable httpCallable =
          FirebaseFunctions.instance.httpsCallable('onStripeUserCreated');
      httpCallable.call(<String, dynamic>{'email': email});
    } catch (e) {
      throw FirestoreApiException(
          message:
              "An error occured in the cloud function 'onStripeUserCreated'",
          devDetails: "Error message from cloud function: ",
          prettyDetails:
              "An internal error occured on our side, please apologize and try again later.");
    }
  }

  // Push transfer document to firestore
  Future createMoneyTransfer({required MoneyTransfer moneyTransfer}) async {
    try {
      log.i("Calling restful server function bookkeepMoneyTransfer");

      Uri url = Uri.https(
          _flavorConfigProvider.authority,
          p.join(_flavorConfigProvider.uripathprepend,
              "transfers-api/bookkeepmoneytransfer"));
      http.Response? response = await http.post(url,
          body: json.encode(moneyTransfer.toJson()),
          headers: {"Accept": "application/json"});
      log.i("posted http request");
      dynamic result = json.decode(response.body);
      log.i("decoded json response");

      if (result["error"] == null) {
        log.i(
            "Added the following transfer document to ${result["data"]["transferId"]}: ${moneyTransfer.toJson()}");
      } else {
        log.e(
            "Error when creating money transfer: ${result["error"]["message"]}");
        throw FirestoreApiException(
            message:
                "An error occured in the cloud function 'bookkeepMoneyTransfer'",
            devDetails:
                "Error message from cloud function: ${result["error"]["message"]}",
            prettyDetails:
                "An internal error occured on our side, please apologize and try again later.");
      }
    } catch (e) {
      log.e("Couldn't process transfer: ${e.toString()}");
      throw FirestoreApiException(
          message:
              "Something failed when calling the https function bookkeepMoneyTransfer",
          devDetails:
              "This should not happen and is due to an error on the Firestore side or the datamodels that were being pushed!",
          prettyDetails:
              "An internal error occured on our side, please apologize and try again later.");
    }
  }

  Future createStripePaymentIntent(
      {required String amount, String? currency, var paymentMethod}) async {
    try {
      HttpsCallable httpCallable = FirebaseFunctions.instance
          .httpsCallable('onStripeCreatePaymentIntent');
      httpCallable.call({
        'amount': amount,
        'currency': currency,
        'payment_method_types': paymentMethod
      });
    } catch (e) {
      throw FirestoreApiException(
          message:
              "An error occured in the cloud function 'onStripeUserCreated'",
          devDetails: "Error message from cloud function: ",
          prettyDetails:
              "An internal error occured on our side, please apologize and try again later.");
    }
  }

  Future createStripeMoneyTransfer(
      {required MoneyTransfer moneyTransfer}) async {
    try {
      HttpsCallable callable = FirebaseFunctions.instance
          .httpsCallable('onStripeCreatePaymentIntent');

      final HttpsCallableResult<dynamic> result =
          await callable(moneyTransfer.toJson());

      if (result.data["error"] == null) {
        log.i(
            "Added the following transfer document to ${result.data["data"]["transferId"]}: ${moneyTransfer.toJson()}");
      } else {
        log.e(
            "Error when creating money transfer: ${result.data["error"]["message"]}");
        throw FirestoreApiException(
            message:
                "An error occured in the cloud function 'onProcessMoneyTransferCallable'",
            devDetails:
                "Error message from cloud function: ${result.data["error"]["message"]}",
            prettyDetails:
                "An internal error occured on our side, please apologize and try again later.");
      }
    } catch (e) {
      log.e("Couldn't process transfer: ${e.toString()}");
      throw FirestoreApiException(
          message:
              "Something failed when calling the https function processMoneyTransferCallable",
          devDetails:
              "This should not happen and is due to an error on the Firestore side or the datamodels that were being pushed!",
          prettyDetails:
              "An internal error occured on our side, please apologize and try again later.");
    }
  }
}

class StripeTransactionResponse {
  String? message;
  bool? success;
  StripeTransactionResponse({this.message, this.success});
}
