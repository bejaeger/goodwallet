import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
import 'package:good_wallet/enums/transfer_status.dart';

// Probably lots of this will be moved to cloud functions?

class FirestorePaymentDataService {
  final CollectionReference _paymentsCollectionReference =
      FirebaseFirestore.instance.collection("payments");

  CollectionReference getPaymentIntentCollectionRef(var uid) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("paymentIntent");
  }

  CollectionReference getPendingPaymentIntentCollectionRef(var uid) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("paymentIntentPending");
  }

  Future getLatestPaymentIntentDocSnapshot(var uid) async {
    var paymentIntentCollectionRef = getPaymentIntentCollectionRef(uid);
    QuerySnapshot documentSnapshot = await paymentIntentCollectionRef.get();
    return documentSnapshot;
  }

  Future createPaymentIntent(MoneyTransfer data, var uid) async {
    // Create document in firestore that stands for a transaction.
    // If a document exist in the paymentIntent collection, it is
    // first double-checked whether it's processed already by the good wallet
    // and then deleted. Afterwards, a new paymentIntent document is written.
    try {
      CollectionReference paymentIntentCollectionRef =
          getPaymentIntentCollectionRef(uid);
      QuerySnapshot documentsSnapshot =
          await getLatestPaymentIntentDocSnapshot(uid);
      if (documentsSnapshot.size > 0) {
        await handleAlreadyExistingPaymentIntent(documentsSnapshot, uid);
      }
      var docRef = paymentIntentCollectionRef.doc();
      await docRef.set(data.toJson());
      return docRef.id;
    } catch (error) {
      print("ERROR: payment intent couldn't be created in firestore!");
      print("DETAILS: ${error.toString()}");
      return false;
    }
  }

  Future handleAlreadyExistingPaymentIntent(
      // Delete or move existing payment intents
      QuerySnapshot documentsSnapshot,
      var uid) async {
    documentsSnapshot.docs.forEach((element) async {
      if (await isProcessedInGoodWallet(element.id)) {
        print(
            "WARNING: Found residual paymentIntent that is already processed, deleting it!");
        element.reference.delete();
      } else {
        // Move paymentIntent to pending firestore collection!
        print(
            "WARNING: Found residual paymentIntent that is already processed, moving it to pending payment intents!");
        getPendingPaymentIntentCollectionRef(uid).add(element.data());
        element.reference.delete();
      }
    });
  }

  Future isProcessedInGoodWallet(String paymentId) async {
    var document = await _paymentsCollectionReference.doc(paymentId).get();
    return document.exists;
  }

  Future handlePaymentSuccess(var uid) async {
    // reads payment intent and deletes it after writing
    // new document to payments collection
    QuerySnapshot documentsSnapshot =
        await getLatestPaymentIntentDocSnapshot(uid);
    if (documentsSnapshot.size == 1) {
      // transfer good dollars
      var data = MoneyTransfer.fromJson(documentsSnapshot.docs[0].data());
      var newData = data.copyWith(status: TransferStatus.Success);
      var docRef = _paymentsCollectionReference.doc(newData.transferId);
      await docRef.set(newData.toJson());
      print("INFO: Deleting payment intent document.");
      await documentsSnapshot.docs[0].reference.delete();
      return true;
    } else {
      print(
          "WARNING: There is none or more than one payment Intent present! Cannot handle payment success.");
      return false;
    }
  }

  Future handlePaymentFailure(var uid) async {
    // reads payment intent and deltes it after writing new document
    QuerySnapshot documentsSnapshot =
        await getLatestPaymentIntentDocSnapshot(uid);
    if (documentsSnapshot.size == 1) {
      print("INFO: Deleting payment intent document.");
      await documentsSnapshot.docs[0].reference.delete();
    } else {
      print(
          "WARNING: There is none or more than one payment Intent present! Cannot handle payment success.");
      return false;
    }
  }
}
