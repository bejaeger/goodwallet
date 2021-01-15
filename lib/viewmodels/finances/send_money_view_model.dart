import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:good_wallet/app/locator.dart';
import 'package:good_wallet/datamodels/transaction_model.dart';
import 'package:good_wallet/services/userdata/wallet_client_service.dart';
import 'package:good_wallet/viewmodels/base_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:good_wallet/viewmodels/finances/stripe_checkout/stripe_checkout_stub.dart'
    if (dart.library.js) 'package:good_wallet/viewmodels/finances/stripe_checkout/stripe_checkout_web_view.dart';

class SendMoneyViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();
  final UserWalletService _userWalletService = locator<UserWalletService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final transferValueController = TextEditingController();
  final optionalMessageController = TextEditingController();
  final CollectionReference _paymentsCollectionReference =
      FirebaseFirestore.instance.collection("payments");

  // take from https://stripe.com/docs/testing#international-cards
  final CreditCard testCard = CreditCard(
    number: '4000002760003184		',
    expMonth: 12,
    expYear: 22,
  );

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_userWalletService];
  List<Map<String, String>> _userInfoMaps = [];
  List<Map<String, String>> get userInfoMaps => _userInfoMaps;

  Map<String, String> _selectedUserInfoMap;
  Map<String, String> get selectedUserInfoMap => _selectedUserInfoMap;

  List<String> _nameList = [];
  List<String> get nameList => _nameList;
  TransactionModel _transaction;

  Future makeStripeCheckoutPayment() async {
    setBusy(true);
  }

  Future makeDummyPayment(BuildContext context) async {
    setBusy(true);

    var transaction = TransactionModel(
      recipientUID: "3QrVvwOmrraFMl3EaSzn6byLpFu2",
      recipientName: "Hans",
      senderUID: currentUser.id,
      senderName: currentUser.fullName,
      amount: 700,
      currency: "cad",
      message: "Test Transfer",
    );
    // firebase functions service!
    try {
      HttpsCallable callable = FirebaseFunctions.instance
          .httpsCallable('createStripeCheckoutSession');
      final result = await callable(transaction.toJson());
      var sessionId = result.data["sessionId"];
      var transactionID = result.data["transactionID"];
      print("INFO: TRANSACTIONID = $transactionID");
      print("INFO: Redirecting to stripe checkout");
      if (kIsWeb) {
        // Maybe create a fake route for this??
        await navigateToCheckoutWebView(sessionId);
      } else {
        await navigateToCheckoutMobileView(sessionId);
      }

      print("waiting...");
      await _paymentsCollectionReference
          .doc(transactionID)
          .update({"status": "success"});
      //await Future.delayed(Duration(seconds: 3));wall

      print("continuing!");
    } catch (error) {
      print("ERROR: ${error.toString()}");
    }

    await _userWalletService.updateBalancesLocal(currentUser.id);
    super.notifyListeners();
    setBusy(false);
    return true;
  }

// TODO: Put in service!
  void searchFor(String query) async {
    QuerySnapshot foundUsers = await FirebaseFirestore.instance
        .collection("users")
        .where("searchKeywords", arrayContains: query.toLowerCase())
        .get();
    _userInfoMaps = foundUsers.docs.map((DocumentSnapshot doc) {
      return {"name": doc["fullName"] as String, "id": doc["id"] as String};
    }).toList();
    notifyListeners();
  }

  void selectUser(Map<String, String> userMap) {
    _selectedUserInfoMap = userMap;
    notifyListeners();
  }

  Future navigateToCheckoutMobileView(String sessionId) async {
    throw ("Mobile version of checkout Not implemented!");
    // await _navigationService.navigateTo(Routes.checkoutMobileView,
    //     arguments: CheckoutMobileViewArguments(sessionId: sessionId));
  }

  Future navigateToCheckoutWebView(String sessionId) async {
    redirectToCheckout(sessionId);
  }
}
