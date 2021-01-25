import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:good_wallet/app/locator.dart';
import 'package:good_wallet/datamodels/transaction_model.dart';
import 'package:good_wallet/services/authentification/authentification_service.dart';
import 'package:rxdart/rxdart.dart';

class FirestorePaymentDataService {
  final CollectionReference _paymentsCollectionReference =
      FirebaseFirestore.instance.collection("payments");
  final StreamController<List<dynamic>> _transactionsController =
      StreamController<List<dynamic>>.broadcast();

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

  Future createPaymentIntent(TransactionModel data, var uid) async {
    // Create document in firestore that stands for a transaction.
    // If a document exist in the paymentIntent collection, it is
    // first double-checked whether it's processed by the good wallet
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
      data.transactionId = docRef.id;
      var jsonData = data.toJson();
      jsonData["createdAt"] = FieldValue.serverTimestamp();
      await docRef.set(jsonData);
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
      var data = TransactionModel.fromMap(documentsSnapshot.docs[0].data());
      data.status = "success"; // change status success!
      var docRef = _paymentsCollectionReference.doc(data.transactionId);
      await docRef.set(data.toJson());
      print("INFO: Deleting payment intent document.");
      await documentsSnapshot.docs[0].reference.delete();
      return data;
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

  Stream listenToTransactionsRealTime(var uid) {
    // TODO: Add limit to this query and only load more
    // when user asks for it!

    // no OR query for different fields in firebase
    // Get single streams and combine later
    Stream<QuerySnapshot> outgoing = _paymentsCollectionReference
        .where("senderUid", isEqualTo: uid)
        .orderBy("createdAt",
            descending: true) // already added because needed with limit!
        .snapshots();
    Stream<QuerySnapshot> incoming = _paymentsCollectionReference
        .where("recipientUid", isEqualTo: uid)
        .orderBy("createdAt", descending: true)
        .snapshots();

    // combine streams with rxdart
    Stream<List<dynamic>> transactionStream =
        Rx.combineLatest2(outgoing, incoming, (outSnapshot, inSnapshot) {
      List<dynamic> transactions = <dynamic>[];
      if (outSnapshot.docs.isNotEmpty) {
        transactions.addAll(outSnapshot.docs
            .map((snapshot) => TransactionModel.fromMap(snapshot.data()))
            .toList());
      }
      if (inSnapshot.docs.isNotEmpty) {
        // Add logic to find top ups (transactions to own account!)
        // Can be deprecated once data is already stored accordingly with topUp = true!
        List<dynamic> inTransactions = inSnapshot.docs
            .map((snapshot) => TransactionModel.fromMap(snapshot.data()))
            .toList();
        List<dynamic> transactionIds =
            transactions.map((element) => element.transactionId).toList();
        inTransactions.forEach((element) {
          if (!transactionIds.contains(element.transactionId)) {
            transactions.add(element);
          } else {
            element.topUp = true;
            transactions.removeWhere(
                (el2) => el2.transactionId == element.transactionId);
            transactions.add(element);
          }
        });
      }

      return transactions;
    });
    // listen to combined stream and add transactions to controller
    transactionStream.listen((transactions) {
      _transactionsController.add(transactions);
    });
    // return stream from controller
    return _transactionsController.stream;
  }
}
