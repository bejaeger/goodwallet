import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/enums/user_status.dart';
import 'package:good_wallet/services/payments/dummy_payment_service.dart';
import 'package:good_wallet/services/payments/firestore_payment_data_service.dart';
import 'package:good_wallet/services/userdata/user_data_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:good_wallet/utils/logger.dart';

import 'package:good_wallet/ui/views/payments/stripe_checkout/stripe_checkout_stub.dart'
    if (dart.library.js) 'package:good_wallet/ui/views/payments/stripe_checkout/stripe_checkout_web_view.dart';
import 'package:universal_html/js.dart';

class SendMoneyViewModel extends BaseModel {
  final DialogService? _dialogService = locator<DialogService>();
  final NavigationService? _navigationService = locator<NavigationService>();
  final transferValueController = TextEditingController();
  final optionalMessageController = TextEditingController();
  final FirestorePaymentDataService? _firestorePaymentDataService =
      locator<FirestorePaymentDataService>();
  final UserDataService? _userDataService = locator<UserDataService>();

  final TextEditingController _userSelectionController =
      TextEditingController();
  TextEditingController get userSelectionController => _userSelectionController;
  final DummyPaymentService _dummyPaymentService =
      locator<DummyPaymentService>();
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection("users");

  final log = getLogger("send_money_viewmodel.dart");

  void setUser(String selection) {
    _userSelectionController.text = selection;
    selectedUserInfo =
        userInfoMaps.where((element) => element.name == selection).first;
    setPaymentReady(true);
    notifyListeners();
  }

  void selectUser(dynamic userInfo) {
    selectedUserInfo = userInfo;
    userSelectionController.text = userInfo.name;
    setPaymentReady(true);
    notifyListeners();
  }

  @override
  List<dynamic> userInfoMaps = [];
  dynamic? selectedUserInfo;

  List<String> _nameList = [];
  List<String> get nameList => _nameList;

  bool _paymentReady = false;
  bool get isPaymentReady => _paymentReady;
  void setPaymentReady(bool ready) {
    _paymentReady = ready;
  }

  String _paymentStatus = "unknown";
  String get paymentStatus => _paymentStatus;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void handlePaymentSuccess() async {
    print("INFO: Stripe payment successfull. Handling it");
    _userDataService!.userStateSubject.listen((state) async {
      if (state == UserStatus.SignedIn) {
        bool result = await _firestorePaymentDataService!
            .handlePaymentSuccess(currentUser.id);
        if (result)
          _paymentStatus = "success";
        else
          _paymentStatus = "expired";
        notifyListeners();
      } else if (state == UserStatus.SignedOut) {
        // Something went terribly wrong! We should never end up here!
        print("INFO: User signed out!?");
        //_paymentStatus = "pending";
        notifyListeners();
      }
    });
  }

  void handlePaymentFailure() async {
    print("INFO: Stripe payment cancelled. Handling it");
    _userDataService!.userStateSubject.listen((state) async {
      if (state == UserStatus.SignedIn) {
        await _firestorePaymentDataService!
            .handlePaymentFailure(currentUser.id);
        _paymentStatus = "failure";
        notifyListeners();
      }
    });
  }

  Future navigateToCheckoutMobileView(String sessionId) async {
    throw ("Mobile version of checkout Not implemented!");
    // await _navigationService.navigateTo(Routes.checkoutMobileView,
    //     arguments: CheckoutMobileViewArguments(sessionId: sessionId));
  }

  Future navigateToCheckoutWebView(String sessionId) async {
    redirectToCheckout(sessionId);
  }

  Future navigateToWalletView() async {
    await _navigationService!.navigateTo(Routes.walletView);
  }

  Future navigateToHomeView() async {
    await _navigationService!.navigateTo(Routes.welcomeView);
  }

  void navigateBack() {
    _navigationService!.back();
  }
}
