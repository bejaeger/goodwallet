import 'package:cloud_functions/cloud_functions.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
//import 'dart:html';
import 'package:universal_html/html.dart';

class StripePaymentService {
  Future createStripeSessionId(MoneyTransfer data) async {
    // calls cloud function to retrieve sessionId for
    // stripe checkout
    try {
      HttpsCallable callable = FirebaseFunctions.instance
          .httpsCallable('createStripeCheckoutSession');
      var dataToServer = data.toJson();
      //dataToServer["domain"] = "http://localhost:7000/#/";
      var url = window.location.href;
      url = url.replaceAll("send-money-view", "");
      dataToServer["domain"] = url;
      final HttpsCallableResult<dynamic> result = await callable(dataToServer);
      var sessionId = result.data["sessionId"];
      return sessionId;
    } catch (error) {
      print("ERROR! stripe session Id could not be created!");
      return false;
    }
  }
}
