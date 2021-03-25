// PMs job
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:good_wallet/datamodels/payments/donation_model.dart';
import 'package:good_wallet/utils/logger.dart';

class DummyPaymentService {
  // compare to firestore_payment_data_service.dart

  // useful to define collections as final from FirebaseFirestore.instance

  // We only need one function which I suggest we call

  // incremendGoodWalletBalance(double delta) {
  //  implement it!
  // }
  final log = getLogger("dummy_payment_service.dart");
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection("users");

  Future processDonation(String uid, String projectId) async {
    try {
      // get reference to collection we want to add a document to
      // that holds the relevant information for the donation.
      var docRef = _usersCollectionReference.doc(uid).collection("donations");

      // Create DonationModel. This is a dummy for now. Here we need
      // the actual information to be added
      DonationModel donationModelDummyofDummy = DonationModel.fromMap({
        "projectId": "DummyId",
        "projectName": "DummyProject",
        "amount": 700,
        "currency": "cad",
        "status": "dummy",
      });

      // Add new document to cloud firestore. This will trigger the server function
      // to update the good wallet!
      docRef.add(donationModelDummyofDummy.toJson());
    } catch (e) {
      log.e("Couldn't process donation: ${e.toString()}");
      rethrow;
    }
  }

  Future processTransaction() async {
    // to be implemented
    // similar to processDonation above but use add TransactionModel to firestore
    // collection 'payments' not 'users/<userId>/donations/{donationId}' as above

    return null;
  }
}
