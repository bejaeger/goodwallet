// PMs job
import 'dart:convert';

import 'package:good_wallet/apis/firestore_api.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/constants/constants.dart';
import 'package:good_wallet/datamodels/money_pools/payouts/money_pool_payout.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
import 'package:good_wallet/exceptions/firestore_api_exception.dart';
import 'package:good_wallet/exceptions/money_transfer_exception.dart';
import 'package:good_wallet/flavor_config.dart';
import 'package:good_wallet/services/payments/stripe_service.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

// This is a class used during development

// For now this is just an intermediary!
// Eventually we want to setup a StripePaymentService
// Or GPay or Apple Pay for the transactions into the system

class DummyPaymentService {
  final log = getLogger("dummy_payment_service.dart");
  final _stripeService = locator<StripeService>();
  final FlavorConfigProvider _flavorConfigProvider =
      locator<FlavorConfigProvider>();

  Future processTransfer({required MoneyTransfer moneyTransfer}) async {
    try {
      await _stripeService.createMoneyTransfer(moneyTransfer: moneyTransfer);
    } catch (e) {
      log.e("Couldn't process Dummy Transfer: ${e.toString()}");
      rethrow;
    }
  }

  Future createsStripeUser({required String email}) async {
    try {
      await _stripeService.createStripeUser(email: email);
    } catch (e) {
      log.e("Couldn't process Dummy Transfer: ${e.toString()}");
      rethrow;
    }
  }

  Future createStripePaymentIntent(
      {required String amount, String? currency, var paymentMethod}) async {
    try {
      await _stripeService.createStripePaymentIntent(
          amount: amount, currency: currency, paymentMethod: paymentMethod);
    } catch (e) {
      log.e("Couldn't process Dummy Transfer: ${e.toString()}");
      rethrow;
    }
  }

  Map<String, dynamic>? get getPaymentSheetData =>
      _stripeService.getPaymentSheetData;

  Future<void> initPaymentSheet(
      {required String currency, required String amount}) async {
    await _stripeService.initPaymentSheet(amount: amount, currency: currency);
  }

  initStripePayment() {
    try {
      StripeService.init();
    } catch (e) {
      log.e("Couldn't process money pool payout: ${e.toString()}");
      throw FirestoreApiException(
          message: "Something failed when pushing the data to Firestore",
          devDetails:
              "This should not happen and is due to an error on the Firestore side or the datamodels that were being pushed!",
          prettyDetails:
              "An internal error occured on our side, please apologize and try again later.");
    }
  }

  payNewCard(
      {required String amount,
      required String currency,
      required String customer}) {
    StripeService.payWithNewCard(
        amount: amount, currency: currency, customer: customer);
  }

  // adds payout data to firestore which will trigger a cloud function
  // to update all the good wallets
  // Additionally add money transfer document to payment collection
  // mainly for "read" purposes!
  Future submitMoneyPoolPayout(MoneyPoolPayout data) async {
    log.v("Calling bookkeepMoneyPoolPayout with payload: ${data.toJson()}");

    // remove Timestamp so that we're able to serialize object.
    // otherwise we run into the following error:
    // Converting object to an encodable object failed: Instance of 'Timestamp'
    data = data.copyWith(moneyPool: data.moneyPool.copyWith(createdAt: ""));

    try {
      Uri url = Uri.https(
          _flavorConfigProvider.authority,
          p.join(_flavorConfigProvider.uripathprepend,
              "transfers-api/bookkeepmoneypoolpayout"));
      http.Response? response = await http.post(url,
          body: json.encode(data.toJson()),
          headers: {"Accept": "application/json"});

      dynamic result = json.decode(response.body);

      if (result["error"] == null) {
        log.i("Successfully paid out money pool");
        return true;
      } else {
        log.e(
            "Error when creating money transfer: ${result["error"]["message"]}");
        throw MoneyTransferException(
            message:
                "An error occured in the cloud function 'bookkeepMoneyPoolPayout'",
            devDetails:
                "Error message from cloud function: ${result["error"]["message"]}",
            prettyDetails:
                "An internal error occured on our side, please apologize and try again later.");
      }
    } catch (e) {
      log.e(
          "Couldn't process dummy money pool payout, error thrown: ${e.toString()}");
      throw MoneyTransferException(
          message:
              "Something failed when calling the https function bookkeepMoneyPoolPayout",
          devDetails:
              "This should not happen and might be due to an error on the server side or due to wrong datamodels being pushed!",
          prettyDetails:
              "An internal error occured on our side, please apologize and try again later.");
    }
  }

  Future<String> createSetupIntentOnBackend({required String email}) async {
    final clientSecret = await _stripeService.createSetupIntentOnBackend(email);

    return clientSecret;
  }

  Future<Map<String, dynamic>> chargeCardOffSession(
      {required String email}) async {
    return await _stripeService.chargeCardOffSession(email: email);
  }
}
