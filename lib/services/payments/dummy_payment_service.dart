// PMs job
import 'package:good_wallet/apis/firestore_api.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
import 'package:good_wallet/utils/logger.dart';

// This is a class used during development

// For now this is just an intermediary!
// Eventually we want to setup a StripePaymentService
// Or GPay or Apple Pay

// TODO: Also we should add submitMoneyPoolPayout from money_pools_service to here

class DummyPaymentService {
  final log = getLogger("dummy_payment_service.dart");
  final FirestoreApi? _firestoreApi = locator<FirestoreApi>();

  Future processTransfer({required MoneyTransfer moneyTransfer}) async {
    try {
      _firestoreApi!.createMoneyTransfer(moneyTransfer: moneyTransfer);
    } catch (e) {
      log.e("Couldn't process Dummy Transfer: ${e.toString()}");
      rethrow;
    }
  }
}
