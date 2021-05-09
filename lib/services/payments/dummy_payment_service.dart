// PMs job
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
import 'package:good_wallet/datamodels/transfers/transfer_details.dart';
import 'package:good_wallet/utils/logger.dart';

class DummyPaymentService {
  final log = getLogger("dummy_payment_service.dart");

  final CollectionReference _paymentsCollectionReference =
      FirebaseFirestore.instance.collection("payments");

  // Pushed the data to firestore which will trigger a firebase cloud function
  // that updates the good wallets!
  Future processTransfer(MoneyTransfer transfer) async {
    try {
      var docRef = _paymentsCollectionReference.doc();
      var newTransfer = transfer.copyWith(transferId: docRef.id);
      docRef.set(newTransfer.toJson());
      log.i(
          "Added the following transfer document to ${docRef.path}: ${newTransfer.toJson()}");
    } catch (e) {
      log.e("Couldn't process dummy transfer: ${e.toString()}");
      rethrow;
    }
  }
}
