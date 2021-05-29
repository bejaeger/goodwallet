// PMs job
import 'package:good_wallet/apis/firestore_api.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/money_pools/payouts/money_pool_payout.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
import 'package:good_wallet/utils/logger.dart';

// This is a class used during development

// For now this is just an intermediary!
// Eventually we want to setup a StripePaymentService
// Or GPay or Apple Pay for the transactions into the system

class DummyPaymentService {
  final log = getLogger("dummy_payment_service.dart");
  final FirestoreApi _firestoreApi = locator<FirestoreApi>();

  Future processTransfer({required MoneyTransfer moneyTransfer}) async {
    try {
      await _firestoreApi.createMoneyTransfer(moneyTransfer: moneyTransfer);
    } catch (e) {
      log.e("Couldn't process Dummy Transfer: ${e.toString()}");
      rethrow;
    }
  }

  // adds payout data to firestore which will trigger a cloud function
  // to update all the good wallets
  // Additionally add money transfer document to payment collection
  // mainly for "read" purposes!
  Future submitMoneyPoolPayout(MoneyPoolPayout data) async {
    try {
      await _firestoreApi.createMoneyPoolPayout(payout: data);
    } catch (e) {
      log.e("Couldn't process dummy money pool payout: ${e.toString()}");
      rethrow;
    }
  }
}
