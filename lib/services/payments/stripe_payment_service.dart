import 'package:cloud_functions/cloud_functions.dart';
import 'package:good_wallet/datamodels/transaction_model.dart';
import 'dart:html';

class StripePaymentService {
  Future createStripeSessionId(TransactionModel data) async {
    // calls cloud function to retrieve sessionId for
    // stripe checkout
    try {
      HttpsCallable callable = FirebaseFunctions.instance
          .httpsCallable('createStripeCheckoutSession');
      var dataToServer = data.toJson();
      dataToServer["domain"] = "http://localhost:7000/#/";
      // window.location.href;
      final result = await callable(dataToServer);
      var sessionId = result.data["sessionId"];
      return sessionId;
    } catch (error) {
      print("ERROR! stripe session Id could not be created!");
      return false;
    }
  }
}
