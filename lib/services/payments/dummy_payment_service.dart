// PMs job
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
import 'package:good_wallet/datamodels/transfers/transfer_details.dart';
import 'package:good_wallet/utils/logger.dart';

class DummyPaymentService {
  final log = getLogger("dummy_payment_service.dart");
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference _paymentsCollectionReference =
      FirebaseFirestore.instance.collection("payments");
  final CollectionReference _moneyPoolsCollectionReference =
      FirebaseFirestore.instance.collection("moneypools");

  // get reference to collection we want to add a document to
  // that holds the relevant information for the donation.
  Future processDonation(MoneyTransfer transfer, String uid) async {
    try {
      var docRef = _usersCollectionReference.doc(uid).collection("donations");
      var newtransfer = transfer.copyWith(transferId: docRef.id);
      docRef.add(newtransfer.toJson());
      log.i("Added donation document to ${docRef.path}");
    } catch (e) {
      log.e("Couldn't process donation: ${e.toString()}");
      rethrow;
    }
  }

  // Pushed the data to firestore which will trigger a firebase cloud function
  // that updates the good wallets!
  Future processTransfer(MoneyTransfer transfer) async {
    try {
      var docRef = _paymentsCollectionReference.doc();
      var newtransfer = transfer.copyWith(transferId: docRef.id);
      docRef.set(newtransfer.toJson());
      log.i("Added transfer document to ${docRef.path}");
    } catch (e) {
      log.e("Couldn't process dummy transfer: ${e.toString()}");
      rethrow;
    }
  }

  // Pushes the data to firestore which will trigger a firebase cloud function
  // that updates the good wallets!
  Future processMoneyPoolContribution(
      MoneyPoolContribution contribution) async {
    try {
      // TODO: Put this in a firebase API
      var docRef = _moneyPoolsCollectionReference
          .doc(contribution.transferDetails.recipientId)
          .collection("moneyPoolContributions")
          .doc();
      var newContribution = contribution.copyWith(transferId: docRef.id);
      docRef.set(newContribution.toJson());
      log.i("Added money pool contribution document to ${docRef.path}");
    } catch (e) {
      log.e("Couldn't process dummy transfer: ${e.toString()}");
      rethrow;
    }
  }
}
