import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:good_wallet/app/locator.dart';
import 'package:good_wallet/app/router.gr.dart';
import 'package:good_wallet/datamodels/transaction_model.dart';
import 'package:good_wallet/enums/user_status.dart';
import 'package:good_wallet/services/authentification/authentification_service.dart';
import 'package:good_wallet/services/payments/firestore_payment_data_service.dart';
import 'package:good_wallet/services/payments/stripe_payment_service.dart';
import 'package:good_wallet/services/userdata/wallet_client_service.dart';
import 'package:good_wallet/viewmodels/base_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:good_wallet/viewmodels/payments/stripe_checkout/stripe_checkout_stub.dart'
    if (dart.library.js) 'package:good_wallet/viewmodels/payments/stripe_checkout/stripe_checkout_web_view.dart';

class SendMoneyViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();
  final UserWalletService _userWalletService = locator<UserWalletService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final transferValueController = TextEditingController();
  final optionalMessageController = TextEditingController();
  final FirestorePaymentDataService _firestorePaymentDataService =
      locator<FirestorePaymentDataService>();
  final _stripePaymentService = locator<StripePaymentService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

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

  bool _paymentReady = false;
  bool get isPaymentReady => _paymentReady;
  void setPaymentReady(bool ready) {
    _paymentReady = ready;
  }

  String _paymentStatus = "unknown";
  String get paymentStatus => _paymentStatus;

  String _errorMessage;
  String get errorMessage => _errorMessage;

  void addListenersToControllers() {
    transferValueController.addListener(() {
      _errorMessage = "";
      notifyListeners();
    });
  }

  num _getAmount() {
    try {
      var amount = double.parse(transferValueController.text);
      return amount;
    } catch (error) {
      print("ERROR: Amount not valid!");
      _errorMessage = "Please enter valid amount.";
      setPaymentReady(false);
      notifyListeners();
      return -1;
    }
  }

  Future fillTransactionModel() async {
    var recipientUid, recipientName, amount, msg, currency;
    TransactionModel data;
    try {
      recipientUid = selectedUserInfoMap["id"];
      recipientName = selectedUserInfoMap["name"];
      amount = _getAmount();
      msg = optionalMessageController.text;
      data = TransactionModel(
        recipientUid: recipientUid,
        recipientName: recipientName,
        senderUid: currentUser.id,
        senderName: currentUser.fullName,
        amount: amount * 100,
        currency: "cad",
        message: msg,
        status: 'initialized',
      );
    } catch (e) {
      print("ERROR: Could not fill transaction model!");
      print(e.toString());
      return false;
    }
    return data;
  }

  Future getTestPaymentData() async {
    var data = TransactionModel(
      recipientUid: "3QrVvwOmrraFMl3EaSzn6byLpFu2",
      recipientName: "Hans",
      senderUid: currentUser.id,
      senderName: currentUser.fullName,
      amount: 700,
      currency: "cad",
      message: "Test Transfer",
      status: 'initialized',
    );
    return data;
  }

  Future makeTestPayment() async {
    await processPayment(await getTestPaymentData());
  }

  Future makePayment() async {
    var data = await fillTransactionModel();
    if (data is TransactionModel) {
      if (isPaymentReady) {
        await processPayment(data);
      }
    }
    setPaymentReady(true);
  }

  Future processPayment(TransactionModel data) async {
    setBusy(true);
    var resultCreatePaymentIntent = await _firestorePaymentDataService
        .createPaymentIntent(data, currentUser.id);

    if (resultCreatePaymentIntent is String) {
      // string is document id which is payId, so
      // let's get started
      var sessionId = await _stripePaymentService.createStripeSessionId(data);
      if (sessionId is String) {
        print("INFO: Redirecting to stripe checkout");
        if (kIsWeb) {
          // Maybe create a fake route for this??
          await navigateToCheckoutWebView(sessionId);
        } else {
          await navigateToCheckoutMobileView(sessionId);
        }
      } else if (sessionId is bool) {
        if (!sessionId) {
          await _dialogService.showDialog(
            title: "Error! Stripe payment couldn't be processed",
            description: "",
          );
        }
      }
    } else if (resultCreatePaymentIntent is bool) {
      if (!resultCreatePaymentIntent) {
        await _dialogService.showDialog(
          title: "Error! Payment couldn't be processed",
          description: "",
        );
      }
    }

    setBusy(false);
    return true;
  }

  void handlePaymentSuccess() async {
    print("INFO: Stripe payment successfull. Handling it");
    _authenticationService.userStateSubject.listen((state) async {
      if (state.status == UserStatus.SignedIn) {
        bool result = await _firestorePaymentDataService
            .handlePaymentSuccess(currentUser.id);
        await _userWalletService.updateBalancesLocal(currentUser.id);
        if (result)
          _paymentStatus = "success";
        else
          _paymentStatus = "expired";
        notifyListeners();
      } else if (state.status == UserStatus.SignedOut) {
        // Something went terribly wrong! We should never end up here!
        _paymentStatus = "pending";
        notifyListeners();
      }
    });
  }

  void handlePaymentFailure() async {
    print("INFO: Stripe payment cancelled. Handling it");
    _authenticationService.userStateSubject.listen((state) async {
      if (state.status == UserStatus.SignedIn) {
        await _firestorePaymentDataService.handlePaymentFailure(currentUser.id);
        _paymentStatus = "failure";
        notifyListeners();
      }
    });
  }

  // TODO: Put in service!
  void searchFor(String query) async {
    QuerySnapshot foundUsers = await FirebaseFirestore.instance
        .collection("users")
        .where("searchKeywords", arrayContains: query.toLowerCase())
        .get();
    _userInfoMaps = foundUsers.docs.map((DocumentSnapshot doc) {
      return {
        "name": doc.get("fullName") as String,
        "id": doc.get("id") as String,
      };
    }).toList();
    notifyListeners();
  }

  Future<List<String>> getSearchedNames(String query) async {
    // TODO: Error catching!
    QuerySnapshot foundUsers = await FirebaseFirestore.instance
        .collection("users")
        .where("searchKeywords", arrayContains: query.toLowerCase())
        .get();
    List<String> returnValue = foundUsers.docs.map((DocumentSnapshot doc) {
      return doc.get("fullName") as String;
    }).toList();
    return returnValue;
  }

  void selectUser(Map<String, String> userMap) {
    _selectedUserInfoMap = userMap;
    setPaymentReady(true);
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

  Future navigateToHomeView([num pageIndex = 2]) async {
    await _navigationService.navigateTo(Routes.walletView);
  }
}
