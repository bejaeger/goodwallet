// PMs job
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:good_wallet/datamodels/payments/donation_model.dart';
import 'package:good_wallet/datamodels/payments/transaction_model.dart';
import 'package:good_wallet/utils/logger.dart';

class DummyPaymentService {
  final log = getLogger("dummy_payment_service.dart");
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference _paymentsCollectionReference =
      FirebaseFirestore.instance.collection("payments");

  Future processDonation(String uid, String projectTitle, int amount) async {
    try {
      // get reference to collection we want to add a document to
      // that holds the relevant information for the donation.
      var docRef = _usersCollectionReference.doc(uid).collection("donations");

      // Create DonationModel. This is a dummy for now. Here we need
      // the actual information to be added
      DonationModel donationModelDummy = DonationModel.fromMap({
        "projectId": "DummyId",
        "projectName": projectTitle,
        "amount": amount,
        "currency": "cad",
        "status": "dummy",
      });

      // Add new document to cloud firestore. This will trigger the server function
      // to update the good wallet!
      docRef.add(donationModelDummy.toJson());
    } catch (e) {
      log.e("Couldn't process donation: ${e.toString()}");
      rethrow;
    }
  }

  Future processTransaction(_transactionModelDummy) async {
    // to be implemented
    // similar to processDonation above but use add TransactionModel to firestore
    // collection 'payments' not 'users/<userId>/donations/{donationId}' as above
    try {
      // TransactionModel _transactionModelDummyofDummy =
      //     TransactionModel.fromMap({
      //   "recipientUid": "PNgziB8BJtTOcniZCO6Yp2JagYx1",
      //   "recipientName": "Patrick Mayerhofer",
      //   // TO BE ADDED from function arguments I guess??
      //   "senderUid": "",
      //   "senderName": "",
      //   "amount": 777,
      //   "currency": "cad",
      //   "status": "dummy",
      // });
      // _transactionModelDummy.createdAt = DateTime.now();
      _paymentsCollectionReference.add(_transactionModelDummy.toJson());
    } catch (e) {
      log.e("Couldn't process dummy transaction: ${e.toString()}");
      rethrow;
    }
  }
}
