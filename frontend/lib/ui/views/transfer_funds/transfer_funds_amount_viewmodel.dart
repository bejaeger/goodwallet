import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
//import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/helpers/money_transfer_status_model.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/recipient_info.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/sender_info.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
import 'package:good_wallet/datamodels/transfers/transfer_details.dart';
import 'package:good_wallet/datamodels/user/statistics/user_statistics.dart';
import 'package:good_wallet/datamodels/user/user.dart';
import 'package:good_wallet/enums/bottom_navigator_index.dart';
import 'package:good_wallet/enums/dialog_type.dart';
import 'package:good_wallet/enums/donation_dialog_status.dart';
import 'package:good_wallet/enums/money_source.dart';
import 'package:good_wallet/enums/transfer_type.dart';
import 'package:good_wallet/exceptions/firestore_api_exception.dart';
import 'package:good_wallet/exceptions/money_transfer_exception.dart';
import 'package:good_wallet/exceptions/user_service_exception.dart';
import 'package:good_wallet/services/payments/dummy_payment_service.dart';
import 'package:good_wallet/services/user/user_service.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:good_wallet/ui/views/transfer_funds/transfer_funds_amount_view.form.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stripe_platform_interface/stripe_platform_interface.dart';

/////////////////////////////////////////////////////////////////
///
/// Viewmodel handling the logic for different types of payments
///
/// This has lot of if () {} else if () {} logic!
/// This can be improved by thinking about a cleaner configuration
///
/// Make unions for senderInfo and recipientInfo to distinguish money transfer types
///

class TransferFundsAmountViewModel extends FormViewModel {
  final NavigationService? _navigationService = locator<NavigationService>();
  final BottomSheetService? _bottomSheetService = locator<BottomSheetService>();
  final SnackbarService? _snackbarService = locator<SnackbarService>();
  final UserService? _userService = locator<UserService>();
  final DialogService? _dialogService = locator<DialogService>();
  User get currentUser => _userService!.currentUser;
  final DummyPaymentService _dummyPaymentService =
      locator<DummyPaymentService>();
  SetupIntent? _setupIntentResult;
  PaymentIntent? _retrievedPaymentIntent;

  final log = getLogger("transfer_funds_amount_viewmodel.dart");

  StreamSubscription<UserStatistics>? _walletSubscription;

  UserStatistics get userStats => _userService!.userStats!;

  final TransferType type;

  final RecipientInfo? recipientInfo;

  final SenderInfo senderInfo;
  //final _snackbarService = locator<SnackbarService>();

  num? amount;

  // TODO: Validate inputs here... if Donation, recipientInfo must not be null!
  TransferFundsAmountViewModel(
      {required this.type, this.recipientInfo, required this.senderInfo});

  // The functionality from stacked's form view is
  // not working properly (not sure exactly why).
  // This has to do with how we wrap the entire
  // App with the Unfocuser, see main.dart.
  // For the time being we just use our own validation
  // message string
  String? customValidationMessage;
  void setCustomValidationMessage(String msg) {
    customValidationMessage = msg;
  }

  //User get currentUser => _userService.currentUser;

  Map<String, dynamic>? _paymentIntentData;
  //For Transfer Money Via Stripe Harguilar
  String text = 'Click the button to start the payment';
  double totalCost = 10.0;
  double tip = 1.0;
  double tax = 0.0;
  double taxPercent = 0.2;
  //int amount = 0;
  bool showSpinner = false;
  String url =
      'https://us-central1-gooddollarsmarketplace.cloudfunctions.net/user-onStripeCreatePI';
  static Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded'
  };
// Harguilar Ended

  Map<String, dynamic>? paymentIntentData;

  //Harguilar Added New Payment
  Future<void> createStripePayment() async {
    setBusy(true);
    try {
      final urlUri = Uri.parse(url);
      // Map<String, dynamic> body = {'amount': amount, 'currency': 'usd'};
      // final http.Response resp = await http.post('$urlUri?');
      final response = await http.get(
        urlUri,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      paymentIntentData = json.decode(response.body);

      print('Harguilar Payment Intent: ' + paymentIntentData!.toString());

      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntentData!['paymentIntent'],
              applePay: true,
              merchantCountryCode: 'CAD',
              //customerId: ,
              googlePay: true,
              style: ThemeMode.dark,
              merchantDisplayName:
                  _userService!.currentUser.fullName.toString()));
    } catch (e) {
      print(e.toString());
    }
    setBusy(false);

    notifyListeners();
    displayPaymentSheet();
  }

  Future<void> displayPaymentSheet() async {
    setBusy(true);
    try {
      await Stripe.instance.presentPaymentSheet(
          parameters: PresentPaymentSheetParameters(
              clientSecret: paymentIntentData!['paymentIntent'],
              confirmPayment: true));

      _handleRetrievePaymentIntent(
          clientSecret: paymentIntentData!['paymentIntent']);

      ///
      // 2. Gather customer billing information (ex. email)
      final billingDetails = BillingDetails(
        email: _userService!.currentUser.email.toString(),
        phone: '+48888000888',
        address: Address(
          city: 'Angola',
          country: 'US',
          line1: '1459  Circle Drive',
          line2: '',
          state: 'Texas',
          postalCode: '77063',
        ),
      ); // mo mocked data for tests

      // 3. Confirm payment with card details
      // The rest will be done automatically using webhooks
      // ignore: unused_local_variable
      final paymentIntent = await Stripe.instance.confirmSetupIntent(
        paymentIntentData!['paymentIntent'],
        PaymentMethodParams.card(
          billingDetails: billingDetails,
/*         setupFutureUsage:
            _saveCard == true ? PaymentIntentsFutureUsage.OffSession : null, */
        ),
      );

      paymentIntentData = null;
      _snackbarService!.showSnackbar(
          title: 'Payment Made Succesfully !',
          message: 'Sucessfull Payment',
          duration: Duration(seconds: 2));
    } catch (e) {
      print(e.toString());
    }
    setBusy(false);
    notifyListeners();
  }

  Future<void> _handleRetrievePaymentIntent({String? clientSecret}) async {
    setBusy(true);
    final paymentIntent =
        await Stripe.instance.retrievePaymentIntent(clientSecret!);
    /*final errorCode = paymentIntent.lastPaymentError?.code;

    var failureReason = 'Payment failed, try again.'; // Default to a generic error message
    if (paymentIntent?.lastPaymentError?.type == 'Card') {
      failureReason = paymentIntent.lastPaymentError.message;
    }*/
    final errorCode = false;

    if (errorCode) {
      _snackbarService!.showSnackbar(
          title: 'Payment Made Succesfully !',
          message: 'Sucessfull Payment',
          duration: Duration(seconds: 2));
      //setPaymentError(errorCode);
    }

    final paymentMethodId = paymentIntent.paymentMethodId == null
        ? _setupIntentResult?.paymentMethodId
        : paymentIntent.paymentMethodId;

    _retrievedPaymentIntent =
        paymentIntent.copyWith(paymentMethodId: paymentMethodId);

    setBusy(false);
    notifyListeners();
  }

  //Harguilar Ended New Payment

  Future showBottomSheetAndProcessPayment() async {
    if (!isValidData()) {
      log.e("Entered amount not valid");
      notifyListeners();
    } else {
      amount = num.parse(amountValue!);
      if (type == TransferType.User2OwnPrepaidFund)
        await handleTopUpPayment();
      //await createStripePayment();
      else if (type == TransferType.User2UserSent) {
        //await createStripePayment();
        await handleTransfer(type: type);
      } else if (type == TransferType.User2Project) {
        //await createStripePayment();
        await handleTransfer(type: type);
      } else if (type == TransferType.User2MoneyPool) {
        //await createStripePayment();
        await handleTransfer(type: type);
      } else {
        //await createStripePayment();
        _snackbarService!.showSnackbar(
            title: "Not yet implemented.", message: "I know... it's sad");
      }
    }
  }

  // Validate user input, very important function, TODO: should be unit tested!
  bool isValidData() {
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
          "Are you sure you want to top up as much as ${formatAmount(double.parse(amountValue!), true)}");
    } else if (type == TransferType.User2Project &&
        scaleAmountForStripe(double.parse(amountValue!)) >
            userStats.currentBalance) {
      setCustomValidationMessage(
          "Your requested donation is higher than your account balance. You can donate from your bank account directly, or choose a smaller amount.");
    }
    return customValidationMessage == null;
  }

  // Function for the user to change the money source for the payment
  // Will replace the current view with the one corresponding to the
  // selected payment method
  Future changePaymentMethod() async {
    if (type == TransferType.User2MoneyPool) {
      SheetResponse? sheetResponse = await _bottomSheetService!.showBottomSheet(
          title: "Select Payment Method",
          description: "OR add new payment method +",
          confirmButtonTitle: "Bank Account",
          cancelButtonTitle: "Prepaid Fund");
      if (sheetResponse?.confirmed == true &&
          senderInfo.moneySource == MoneySource.GoodWallet) {
        await _navigationService!.replaceWith(Routes.transferFundsAmountView,
            arguments: TransferFundsAmountViewArguments(
                type: type,
                senderInfo: senderInfo.copyWith(moneySource: MoneySource.Bank),
                recipientInfo: recipientInfo));
      }
      if (sheetResponse?.confirmed == false &&
          senderInfo.moneySource == MoneySource.Bank) {
        await _navigationService!.replaceWith(Routes.transferFundsAmountView,
            arguments: TransferFundsAmountViewArguments(
                type: type,
                senderInfo:
                    senderInfo.copyWith(moneySource: MoneySource.PrepaidFund),
                recipientInfo: recipientInfo));
      }
    }

    if (type == TransferType.User2Project) {
      SheetResponse? sheetResponse = await _bottomSheetService!.showBottomSheet(
          title: "Select Payment Method",
          description: "OR add new payment method +",
          confirmButtonTitle: "Bank Account",
          cancelButtonTitle: "Good Wallet");
      if (sheetResponse?.confirmed == true &&
          senderInfo.moneySource == MoneySource.GoodWallet) {
        await _navigationService!.replaceWith(Routes.transferFundsAmountView,
            arguments: TransferFundsAmountViewArguments(
                senderInfo: senderInfo.copyWith(moneySource: MoneySource.Bank),
                type: type,
                recipientInfo: recipientInfo));
      }
      if (sheetResponse?.confirmed == false &&
          senderInfo.moneySource == MoneySource.Bank) {
        await _navigationService!.replaceWith(Routes.transferFundsAmountView,
            arguments: TransferFundsAmountViewArguments(
                senderInfo:
                    senderInfo.copyWith(moneySource: MoneySource.GoodWallet),
                type: type,
                recipientInfo: recipientInfo));
      }
    }
  }

  //Finished Added
  // TODO: TO BE Deprecated
  // include in handleTransfer
  Future handleTopUpPayment() async {
    SheetResponse? sheetResponse = await _showPaymentMethodBottomSheet();
    log.i("Response data from bottom sheet: ${sheetResponse?.confirmed}");
    if (sheetResponse?.confirmed == false) {
      // FOR now, implemented dummy payment processing here
      showNotYetImplementedSnackbar();
    } else {
      // Properly add Gpay / Credit card pay / ...
      showNotYetImplementedSnackbar();
    }
  }

  Future handleTransfer({required TransferType type}) async {
    // -----------------------------------------------------
    // First we need to ask for the payment method and
    // will also ask for a final confirmation
    // For now, it's only test payments allowed
    SheetResponse? sheetResponse =
        await _showPaymentMethodBottomSheet(type: type);
    if (sheetResponse?.confirmed == true) {
      await _showAndAwaitSnackbar("Not supported at the moment, sorry!");
    } else {
      // Ask for another final confirmation
      SheetResponse? finalConfirmation =
          await _showFinalConfirmationBottomSheet();
      if (finalConfirmation?.confirmed == false) {
        await _showAndAwaitSnackbar("You can come back any time :)");
        setBusy(false);
        navigateBack();
        return;
      }

      // -----------------------------------------------------
      // We create a completer and parse it to the pop-up window.
      // The pop-up window shows a progress indicator and
      // displays a success or error dialog when the completer is completed
      // in _processsPayment.
      var moneyTransferCompleter = Completer<TransferDialogStatus>();

      try {
        _processPayment(moneyTransferCompleter);
      } catch (e) {
        log.wtf("Something very mysterious went wrong, error thrown: $e");
        moneyTransferCompleter.complete(TransferDialogStatus.error);
      }
      dynamic dialogResult = await _showDonationDialog(
          moneyTransferCompleter: moneyTransferCompleter, type: type);

      // -----------------------------------------------------
      // Handle user input after success or error of transfer!
      // Navigation depends on user input and transfer type;
      if (dialogResult!.confirmed) {
        if (type == TransferType.User2MoneyPool) {
          // navigate back to money pool
          navigateBack();
        } else {
          // clear view
          clearTillFirstAndShowHomeScreen();
        }
        return;
      } else {
        if (type == TransferType.User2Project) {
          // navigate back to money pool
          clearTillFirstAndShowProjectsView();
        } else {
          // clear view
          clearTillFirstAndShowHomeScreen();
        }
      }

      return;
    }
  }

  Future _processPayment(
      Completer<TransferDialogStatus> moneyTransferCompleter) async {
    // FOR now, implemented dummy payment processing here
    try {
      final data = prepareTransferData();

      await _dummyPaymentService.processTransfer(moneyTransfer: data);

      log.i("Processed transfer: $data");

      // the completion event will be listened to in the pop-up dialog
      moneyTransferCompleter.complete(TransferDialogStatus.success);
    } catch (e) {
      log.e("Error when processing payment, error thrown $e");
      if (e is MoneyTransferException) {
        moneyTransferCompleter.complete(TransferDialogStatus.error);
      } else if (e is UserServiceException) {
        moneyTransferCompleter.complete(TransferDialogStatus.error);
      } else if (e is FirestoreApiException) {
        moneyTransferCompleter.complete(TransferDialogStatus.error);
      } else {
        rethrow;
      }
      return;
    }
  }

  // returning the money transfer object that will be pushed to firestore
  MoneyTransfer prepareTransferData() {
    try {
      RecipientInfo actualRecipientId = recipientInfo ??
          RecipientInfo.user(
              name: senderInfo.name ?? currentUser.fullName,
              id: senderInfo.id ?? currentUser.uid);
      final transferDetails = TransferDetails(
        recipientId: actualRecipientId.id,
        recipientName: actualRecipientId.name,
        senderId: senderInfo.id ?? currentUser.uid,
        senderName: senderInfo.name ?? currentUser.fullName,
        sourceType: senderInfo.moneySource,
        amount: scaleAmountForStripe(amount!),
        currency: 'cad',
      );

      MoneyTransfer data = actualRecipientId.maybeMap(
        donation: (value) => MoneyTransfer.donation(
          transferDetails: transferDetails,
          projectInfo: value.projectInfo,
        ),
        moneyPool: (value) => MoneyTransfer.moneyPoolContribution(
          transferDetails: transferDetails,
          moneyPoolInfo: value.moneyPoolInfo,
        ),
        orElse: () => MoneyTransfer.peer2peer(
          transferDetails: transferDetails,
        ),
      );
      return data;
    } catch (e) {
      log.e(
          "Could not fill transaction model, Failed with error ${e.toString()}");
      throw MoneyTransferException(
          message:
              "Something went wrong when preparing the transfer. We apologize, please contact support or try again later.",
          prettyDetails:
              "Something went wrong when preparing the transfer. We apologize, please contact support or try again later.",
          devDetails: '$e');
    }
  }

  void navigateBack() {
    _navigationService!.back(result: "contributed");
  }

  /////////////////////////////////////////////////////////////////////
  // Pop-ups!

  Future _showAndAwaitSnackbar(String message) async {
    _snackbarService!.showSnackbar(
        duration: Duration(seconds: 2), title: message, message: "");
    await Future.delayed(Duration(seconds: 2));
  }

  Future _showPaymentMethodBottomSheet({TransferType? type}) async {
    String description = "OR add new payment method +";
    if (type != null && type == TransferType.User2Project) {
      description =
          "We take 5\% of your donation. Please choose a any other amount. Thank you for your support!";
    }
    return await _bottomSheetService!.showBottomSheet(
        title: "Select Payment Method",
        description: description,
        confirmButtonTitle: "Credit Card / Google Pay",
        cancelButtonTitle: "Test Payment");
  }

  Future _showFailureDialog(String? message) async {
    return await _dialogService!.showDialog(
      title: 'Error',
      description: message,
      dialogPlatform: DialogPlatform.Material,
    );
  }

  Future _showFinalConfirmationBottomSheet() async {
    return await _bottomSheetService!.showBottomSheet(
      title: 'Confirmation',
      description:
          "Are you sure you would like to send ${formatAmount(amount, true)}${getSenderInfoString(senderInfo)}${getRecipientInfoString(recipientInfo)}?",
      confirmButtonTitle: 'Yes',
      cancelButtonTitle: 'No',
    );
  }

  Future _showDonationDialog(
      {required Completer<TransferDialogStatus> moneyTransferCompleter,
      required TransferType type}) async {
    log.i("We are starting the dialog");
    final dialogResult = await _dialogService!.showCustomDialog(
      variant: DialogType.Donation,
      data: {
        "moneyTransferStatus": MoneyTransferStatusModel(
          futureStatus: moneyTransferCompleter.future,
          type: type,
        )
      },
    );
    return dialogResult;
  }

  String getSenderInfoString(senderInfo) {
    String returnString = "";
    if (senderInfo.moneySource == MoneySource.Bank) {
      returnString = " from your Bank";
    } else if (senderInfo.moneySource == MoneySource.GoodWallet) {
      returnString = " from your Good Wallet";
    } else if (senderInfo.moneySource == MoneySource.PrepaidFund) {
      returnString = " from your Prepaid Fund";
    }
    return returnString;
  }

  String getRecipientInfoString(senderInfo) {
    String returnString = "";
    if (recipientInfo != null) {
      returnString = recipientInfo!.map(
          user: (value) => " to ${value.name}",
          moneyPool: (value) => " to money pool with name ${value.name}",
          donation: (value) => " to project with name ${value.name}");
    }
    return returnString;
  }

  Future showNotYetImplementedSnackbar() async {
    _snackbarService!.showSnackbar(
        title: "Not yet implemented.", message: "I know... it's sad");
  }

  ////////////////////////////////////////////////////////////////
  // Navigations
  //
  void clearTillFirstAndShowHomeScreen() {
    _navigationService!.clearTillFirstAndShow(Routes.layoutTemplateViewMobile,
        arguments: LayoutTemplateViewMobileArguments(
            initialBottomNavBarIndex: BottomNavigatorIndex.Home.index));
  }

  void clearTillFirstAndShowProjectsView() {
    _navigationService!.clearTillFirstAndShow(Routes.layoutTemplateViewMobile,
        arguments: LayoutTemplateViewMobileArguments(
            initialBottomNavBarIndex: BottomNavigatorIndex.Give.index));
  }

  Future navigateToSingleProjectScreen({required String projectId}) async {
    await _navigationService!.navigateTo(Routes.singleProjectViewMobile,
        arguments: SingleProjectViewMobileArguments(projectId: projectId));
  }

  Future navigateToPublicProfileView(String uid) async {
    bool result = await _navigationService!.navigateTo(
        Routes.publicProfileViewMobile,
        arguments: PublicProfileViewMobileArguments(uid: uid));
    if (result == false) {
      _snackbarService!.showSnackbar(message: "User could not be found");
    }
  }

  ////////////////////////////////////////////////////////////////
  /// Technicalities
  //
  @override
  void dispose() {
    _walletSubscription?.cancel();
    super.dispose();
  }

  @override
  void setFormStatus() async {
    // THIS IS A HACK!
    // Otherwise the customvalidation message is overwritten before showing!
    // Need to fix this properly at some point!
    await Future.delayed(Duration(seconds: 4));
    log.i("Set custom Form status");
    customValidationMessage = null;
  }
}
