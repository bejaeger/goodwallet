import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/user/user.dart';
import 'package:good_wallet/services/payments/dummy_payment_service.dart';
import 'package:good_wallet/services/user/user_service.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'payments_view.form.dart';

class PaymentViewModel extends FormViewModel {
  final _snackbarService = locator<SnackbarService>();
  final _userService = locator<UserService>();
  final _dummyPaymentService = locator<DummyPaymentService>();
  SetupIntent? _setupIntentResult;
  PaymentIntent? _retrievedPaymentIntent;
  CardFieldInputDetails? _card;
  String? _email;

  ///Took The Code Below From Service;

  User get currentUser => _userService.currentUser;
  String? customValidationMessage;
  void setCustomValidationMessage(String msg) {
    customValidationMessage = msg;
  }

  int? amount;
  PaymentViewModel({required this.amount});

  Map<String, dynamic>? get getPaymentSheetData =>
      _dummyPaymentService.getPaymentSheetData;

  initPayment() {
    setBusy(true);
    try {
      _dummyPaymentService.initStripePayment();
    } catch (e) {
      print(e.toString());
    }
    setBusy(false);
    notifyListeners();
  }

  void payNewCard({required String amount, required String currency}) {
    var response = _dummyPaymentService.payNewCard(
        amount: amount, currency: currency, customer: currentUser.email);
    _snackbarService.showSnackbar(
        title: "Error Message.",
        message: "Error: ${response.message}",
        duration: Duration(seconds: 2));
  }

  // Validate user input, very important function, TODO: should be unit tested!
  bool isValidData() {
    // amount = num.parse(amountValue!);
    // check if amount is valid!
    if (amountValue == null) {
      log.i("No valid amount");
      setCustomValidationMessage("Please enter valid amount.");
    } else if (amountValue == "") {
      log.i("No valid amount");
      setCustomValidationMessage("Please enter valid amount.");
    } else if (double.parse(amountValue!) < 0) {
      log.i("Amount < 0");
      setCustomValidationMessage("Please enter valid amount.");
    } else if (double.parse(amountValue!) > 1000) {
      log.i("Amount = ${double.parse(amountValue!)}  > 1000");
      setCustomValidationMessage(
          "Are you sure you want to top up as much as ${formatAmount(double.parse(amountValue!), userInput: true)}");
    }

    return customValidationMessage == null;
  }

  sendAmount({required String amount}) {
    setBusy(true);
    int recvdAmount = int.parse(amount);
    //= int.parse(amount);
    try {
      if (recvdAmount != null) {
        _dummyPaymentService.createsStripeUser(
            email: _userService.currentUser.email);

        _dummyPaymentService.createStripePaymentIntent(
            amount: recvdAmount.toString(),
            currency: 'CAD',
            paymentMethod: PaymentMethodParams.card());
      } else {
        log.i('Amount is Null $recvdAmount!');
      }
    } catch (e) {
      _snackbarService.showSnackbar(
          title: "Error Message.",
          message: "Error: $e",
          duration: Duration(seconds: 2));
    }
    setBusy(false);
    notifyListeners();
  }

  Future<void> initStripePayment() async {
    setBusy(true);
    _dummyPaymentService.initPaymentSheet(currency: 'USD', amount: '500');
    setBusy(false);
    notifyListeners();
  }

//Setters.
  setCardFiel({required CardFieldInputDetails? card}) {
    setBusy(true);
    _card = card;
    setBusy(false);
    notifyListeners();
  }

  setRetrievedPaymentIntent({required PaymentIntent retrievedPaymentIntent}) {
    setBusy(true);
    _retrievedPaymentIntent = retrievedPaymentIntent;
    setBusy(false);
    notifyListeners();
  }

  setSetupIntentResult({required SetupIntent? setupIntentResult}) {
    setBusy(true);
    _setupIntentResult = setupIntentResult;
    setBusy(false);
    notifyListeners();
  }

  setEmail({required String email}) {
    setBusy(true);
    _email = email;
    setBusy(false);
    notifyListeners();
  }

//Getters
  String get getEmail => _email!;
  SetupIntent? get getSetupIntentResult => _setupIntentResult;
  CardFieldInputDetails? get getCardField => _card;
  PaymentIntent? get getRetrievedPaymentIntent => _retrievedPaymentIntent;

  Future<void> handleOffSessionPayment() async {
    setBusy(true);
    final res = await _dummyPaymentService.chargeCardOffSession(email: _email!);
    if (res['error'] != null) {
      // If the PaymentIntent has any other status, the payment did not succeed and the request fails.
      // Notify your customer e.g., by email, text, push notification) to complete the payment.
      // We recommend creating a recovery flow in your app that shows why the payment failed initially and lets your customer retry.
      await _handleRetrievePaymentIntent(res['clientSecret']);
    } else {
      _snackbarService.showSnackbar(
          title: "Success Message.",
          message: 'Success!: The payment was confirmed successfully!',
          duration: Duration(seconds: 2));
    }

    log.i('charge off session result: $res');
    setBusy(false);
    notifyListeners();
  }

  Future<void> _handleRetrievePaymentIntent(String clientSecret) async {
    final paymentIntent =
        await Stripe.instance.retrievePaymentIntent(clientSecret);
    /*final errorCode = paymentIntent.lastPaymentError?.code;

    var failureReason = 'Payment failed, try again.'; // Default to a generic error message
    if (paymentIntent?.lastPaymentError?.type == 'Card') {
      failureReason = paymentIntent.lastPaymentError.message;
    }*/
    final errorCode = false;

    if (errorCode) {
      _snackbarService.showSnackbar(message: "'failureReason'");

      //setPaymentError(errorCode);
    }
    setRetrievedPaymentIntent(retrievedPaymentIntent: paymentIntent);
  }

  Future<void> handlePayPress() async {
    setBusy(true);
    if (_card == null) {
      return;
    }
    try {
      // 1. Create setup intent on backend
      final clientSecret =
          await _dummyPaymentService.createSetupIntentOnBackend(email: _email!);

      // 2. Gather customer billing information (ex. email)
      final billingDetails = BillingDetails(
        email: 'email@stripe.com',
        phone: '+48888000888',
        address: Address(
          city: 'Houston',
          country: 'US',
          line1: '1459  Circle Drive',
          line2: '',
          state: 'Texas',
          postalCode: '77063',
        ),
      ); // mo/ mocked data for tests

      // 3. Confirm setup intent

      final setupIntentResult = await Stripe.instance.confirmSetupIntent(
        clientSecret,
        PaymentMethodParams.card(
          billingDetails: billingDetails,
        ),
      );
      log.i('Setup Intent created $setupIntentResult');
      _snackbarService.showSnackbar(
          title: "Success Message.",
          message:
              "Success: Setup intent created. Intent status: $setupIntentResult",
          duration: Duration(seconds: 2));
      setSetupIntentResult(setupIntentResult: setupIntentResult);
    } catch (error, s) {
      log.i('Error while saving payment', error, s);
      _snackbarService.showSnackbar(
          title: "Error Message.",
          message: "Success: Setup intent created. Intent status: $error",
          duration: Duration(seconds: 4));
      //log.i('Error while saving payment', error: error, stackTrace: s);
    }
    setBusy(false);
    notifyListeners();
  }

  Future<void> handleRecoveryFlow() async {
    if (_retrievedPaymentIntent?.paymentMethodId != null && _card != null) {
      await Stripe.instance.confirmPayment(
        _retrievedPaymentIntent!.clientSecret,
        PaymentMethodParams.cardFromMethodId(
            paymentMethodId:
                _retrievedPaymentIntent!.paymentMethodId.toString()),
      );
    }
  }

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }
}
