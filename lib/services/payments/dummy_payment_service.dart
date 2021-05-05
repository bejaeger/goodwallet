// PMs job
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:good_wallet/datamodels/transactions/transaction.dart'
    as gwmodel;
import 'package:good_wallet/datamodels/transactions/transaction_details.dart';
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
  Future processDonation(gwmodel.Transaction transaction, String uid) async {
    try {
      var docRef = _usersCollectionReference.doc(uid).collection("donations");
      var newTransaction = transaction.copyWith(transactionId: docRef.id);
      docRef.add(newTransaction.toJson());
      log.i("Added donation document to ${docRef.path}");
    } catch (e) {
      log.e("Couldn't process donation: ${e.toString()}");
      rethrow;
    }
  }

  // Pushed the data to firestore which will trigger a firebase cloud function
  // that updates the good wallets!
  Future processTransaction(gwmodel.Transaction transaction) async {
    try {
      var docRef = _paymentsCollectionReference.doc();
      var newTransaction = transaction.copyWith(transactionId: docRef.id);
      docRef.set(newTransaction.toJson());
      log.i("Added transaction document to ${docRef.path}");
    } catch (e) {
      log.e("Couldn't process dummy transaction: ${e.toString()}");
      rethrow;
    }
  }

  // Pushes the data to firestore which will trigger a firebase cloud function
  // that updates the good wallets!
  Future processMoneyPoolContribution(
      gwmodel.MoneyPoolContribution contribution) async {
    try {
      // TODO: Put this in a firebase API
      var docRef = _moneyPoolsCollectionReference
          .doc(contribution.moneyPool.recipientId)
          .collection("moneyPoolContributions")
          .doc();
      var newContribution = contribution.copyWith(transactionId: docRef.id);
      docRef.set(newContribution.toJson());
      log.i("Added money pool contribution document to ${docRef.path}");
    } catch (e) {
      log.e("Couldn't process dummy transaction: ${e.toString()}");
      rethrow;
    }
  }
}
