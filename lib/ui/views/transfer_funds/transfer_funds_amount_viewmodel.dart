import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/money_pools/money_pool_contribution.dart';
import 'package:good_wallet/datamodels/payments/transaction_model.dart';
import 'package:good_wallet/datamodels/payments/wallet_balances_model.dart';
import 'package:good_wallet/datamodels/user/user_model.dart';
import 'package:good_wallet/enums/bottom_navigator_index.dart';
import 'package:good_wallet/enums/fund_transfer_type.dart';
import 'package:good_wallet/services/payments/dummy_payment_service.dart';
import 'package:good_wallet/services/userdata/user_data_service.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:good_wallet/ui/views/transfer_funds/transfer_funds_amount_view.form.dart';

/////////////////////////////////////////////////////////////////
///
/// Viewmodel handling the logic for different types of payments
///
/// This has lot of if () {} else if () {} logic!
/// This can be improved by thinking about a cleaner configuration
///

class TransferFundsAmountViewModel extends FormViewModel {
  final NavigationService? _navigationService = locator<NavigationService>();
  final BottomSheetService? _bottomSheetService = locator<BottomSheetService>();
  final SnackbarService? _snackbarService = locator<SnackbarService>();
  final UserDataService? _userDataService = locator<UserDataService>();
  final DialogService? _dialogService = locator<DialogService>();
  MyUser get currentUser => _userDataService!.currentUser;
  final DummyPaymentService _dummyPaymentService =
      locator<DummyPaymentService>();
  final log = getLogger("transfer_funds_amount_viewmodel.dart");
  WalletBalancesModel userWallet = WalletBalancesModel.empty();
  StreamSubscription<WalletBalancesModel>? _walletSubscription;

  TransferFundsAmountViewModel() {
    // Listen to wallet similar to what is done in base viemodel
    _walletSubscription = _userDataService!.userWalletSubject.listen(
      (wallet) {
        userWallet = wallet;
        notifyListeners();
      },
    );
  }

  FundTransferType? _type;
  dynamic? _receiverInfo;
  setTransferFundTypeAndReceiverInfo(
      FundTransferType type, dynamic receiverInfo) {
    _type = type;
    _receiverInfo = receiverInfo;
    log.i("Active transfer type: ${_type.toString()}");
  }

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

  Future showBottomSheetAndProcessPayment() async {
    if (!isValidData()) {
      log.e("Entered amount not valid");
      notifyListeners();
    } else {
      if (_type == FundTransferType.prepaidFundTopUp)
        await handleTopUpPayment();
      else if (_type == FundTransferType.transferToPeer) {
        await handleSendMoneyPayment();
      } else if (_type == FundTransferType.donation) {
        await handleDonationPayment();
      } else if (_type == FundTransferType.moneyPoolContributionFromBank) {
        await handleMoneyPoolPayment();
      } else {
        _snackbarService!.showSnackbar(
            title: "Not yet implemented.", message: "I know... it's sad");
      }
    }
  }

  // Validate user input, very important function, should be unit tested!
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
    } else if (_type == FundTransferType.donation &&
        scaleAmountForStripe(double.parse(amountValue!)) >
            userWallet.currentBalance) {
      setCustomValidationMessage(
          "Your requested donation is higher than your account balance. You can donate from your bank account directly, or choose a smaller amount.");
    }
    return customValidationMessage == null;
  }

  // Function for the user to change the money source for the payment
  // Will replace the current view with the one corresponding to the
  // selected payment method
  Future changePaymentMethod() async {
    if (_type == FundTransferType.moneyPoolContribution ||
        _type == FundTransferType.moneyPoolContributionFromBank) {
      SheetResponse? sheetResponse = await _bottomSheetService!.showBottomSheet(
          title: "Select Payment Method",
          description: "OR add new payment method +",
          confirmButtonTitle: "Bank Account",
          cancelButtonTitle: "Prepaid Fund");
      if (sheetResponse?.confirmed == true &&
          _type != FundTransferType.moneyPoolContributionFromBank) {
        await _navigationService!.replaceWith(Routes.transferFundsAmountView,
            arguments: TransferFundsAmountViewArguments(
                type: FundTransferType.moneyPoolContributionFromBank,
                receiverInfo: _receiverInfo));
      }
      if (sheetResponse?.confirmed == false &&
          _type != FundTransferType.moneyPoolContribution) {
        await _navigationService!.replaceWith(Routes.transferFundsAmountView,
            arguments: TransferFundsAmountViewArguments(
                type: FundTransferType.moneyPoolContribution,
                receiverInfo: _receiverInfo));
      }
    }

    if (_type == FundTransferType.donation ||
        _type == FundTransferType.donationFromBank) {
      SheetResponse? sheetResponse = await _bottomSheetService!.showBottomSheet(
          title: "Select Payment Method",
          description: "OR add new payment method +",
          confirmButtonTitle: "Bank Account",
          cancelButtonTitle: "Good Wallet");
      if (sheetResponse?.confirmed == true &&
          _type != FundTransferType.donationFromBank) {
        await _navigationService!.replaceWith(Routes.transferFundsAmountView,
            arguments: TransferFundsAmountViewArguments(
                type: FundTransferType.donationFromBank,
                receiverInfo: _receiverInfo));
      }
      if (sheetResponse?.confirmed == false &&
          _type != FundTransferType.donation) {
        await _navigationService!.replaceWith(Routes.transferFundsAmountView,
            arguments: TransferFundsAmountViewArguments(
                type: FundTransferType.donation, receiverInfo: _receiverInfo));
      }
    }
  }

  Future handleTopUpPayment() async {
    SheetResponse? sheetResponse = await _showPaymentMethodBottomSheet();
    log.i("Response data from bottom sheet: ${sheetResponse?.confirmed}");
    if (sheetResponse?.confirmed == false) {
      // FOR now, implemented dummy payment processing here
      var amount = double.parse(amountValue!);
      showNotYetImplementedSnackbar();
    } else {
      // Properly add Gpay / Credit card pay / ...
      showNotYetImplementedSnackbar();
    }
  }

  Future handleSendMoneyPayment() async {
    SheetResponse? sheetResponse = await _showPaymentMethodBottomSheet();
    log.i("Response data from bottom sheet: ${sheetResponse?.confirmed}");
    if (sheetResponse?.confirmed == false) {
      // FOR now, implemented dummy payment processing here
      var amount = double.parse(amountValue!);
      try {
        var data = await prepareTransactionModel();
        SheetResponse? sheetResponse =
            await _showConfirmationBottomSheet(amount, _receiverInfo.name);
        if (sheetResponse?.confirmed == true) {
          setBusy(true);
          await _dummyPaymentService.processTransaction(data);
          setBusy(false);
          _snackbarService!.showSnackbar(
              duration: Duration(seconds: 2),
              title:
                  "Transferred ${formatAmount(amount, true)} to ${_receiverInfo!.name}!",
              message: "I know... it's great!");
          await Future.delayed(Duration(seconds: 2));
          await anotherPaymentConfirmationDialog();
        }
      } catch (e) {
        log.e(
            "Something went wrong processing the dummy payment, error: ${e.toString()}");
        await _showAndAwaitSnackbar("Could not process payment!");
      }
    } else if (sheetResponse?.confirmed == false) {
      // Properly add Gpay / Credit card pay / ...
    }
  }

  Future handleDonationPayment() async {
    var amount = double.parse(amountValue!);
    SheetResponse? sheetResponse =
        await _showConfirmationBottomSheet(amount, _receiverInfo.title);
    setBusy(true);
    if (sheetResponse?.confirmed == true) {
      // FOR now, implemented dummy payment processing here
      _dummyPaymentService.processDonation(currentUser.id, _receiverInfo.title,
          scaleAmountForStripe(amount) as int);
      log.i("Processed donation");
      await _showAndAwaitSnackbar("You just made an impact!");
      clearTillFirstAndShowHomeScreen();
    } else if (sheetResponse?.confirmed == false) {
      await _showAndAwaitSnackbar("Cancelled donation process");
    }
    setBusy(false);
  }

  Future handleMoneyPoolPayment() async {
    var amount = double.parse(amountValue!);
    SheetResponse? sheetResponse = await _showPaymentMethodBottomSheet();
    setBusy(true);
    if (sheetResponse?.confirmed == false) {
      // FOR now, implemented dummy payment processing here
      MoneyPoolContributionModel contribution = MoneyPoolContributionModel(
          moneyPoolId: _receiverInfo.moneyPoolId,
          moneyPoolName: _receiverInfo.name,
          uid: currentUser.id,
          userName: currentUser.fullName,
          amount: scaleAmountForStripe(amount),
          currency: 'cad',
          createdAt: FieldValue.serverTimestamp(),
          status: "initialized");
      _dummyPaymentService.processMoneyPoolContribution(contribution);
      log.i("Processed donation");
      await _showAndAwaitSnackbar("Succesfully contributed to money pool!");
      navigateBack();
    } else if (sheetResponse?.confirmed == true) {
      await _showAndAwaitSnackbar("Cancelled contributed to money pool!");
    }
    setBusy(false);
  }

  Future prepareTransactionModel() async {
    var recipientUid, recipientName, amount;
    TransactionModel data;
    try {
      recipientUid = _receiverInfo!.uid;
      recipientName = _receiverInfo!.name;
      amount = double.parse(amountValue!);
      //msg = optionalMessageController.text;
      data = TransactionModel(
        recipientUid: recipientUid,
        recipientName: recipientName,
        senderUid: currentUser.id,
        senderName: currentUser.fullName,
        createdAt: FieldValue.serverTimestamp(),
        amount: scaleAmountForStripe(amount),
        currency: "cad",
        message: "Test payment",
        status: 'initialized',
      );
    } catch (e) {
      log.e(
          "Could not fill transaction model, Failed with error ${e.toString()}");
      rethrow;
    }
    return data;
  }

  void navigateBack() {
    _navigationService!.back();
  }

  /////////////////////////////////////////////////////////////////////
  // Pop-ups!

  Future anotherPaymentConfirmationDialog() async {
    try {
      DialogResponse? response = await _dialogService!.showConfirmationDialog(
        title: 'Confirmation',
        description: "Would you like to make another payment?",
        confirmationTitle: 'Yes',
        dialogPlatform: DialogPlatform.Material,
        cancelTitle: 'No',
      );
      if (response?.confirmed == false) {
        clearTillFirstAndShowHomeScreen();
      }
      print('DialogResponse: ${response?.confirmed}');
    } catch (e) {
      log.e("Couldn't process payment: ${e.toString()}");
      rethrow;
    }
  }

  Future _showAndAwaitSnackbar(String message) async {
    _snackbarService!.showSnackbar(
        duration: Duration(seconds: 2), title: message, message: "");
    await Future.delayed(Duration(seconds: 2));
  }

  Future _showPaymentMethodBottomSheet() async {
    return await _bottomSheetService!.showBottomSheet(
        title: "Select Payment Method",
        description: "OR add new payment method +",
        confirmButtonTitle: "Credit Card / Google Pay",
        cancelButtonTitle: "Test Payment");
  }

  Future _showConfirmationBottomSheet(num amount, dynamic receiverName) async {
    return await _bottomSheetService!.showBottomSheet(
      title: 'Confirmation',
      description:
          "Are you sure you want to donate ${formatAmount(amount, true)} from your Good Wallet to the project '$receiverName'",
      confirmButtonTitle: 'Yes',
      cancelButtonTitle: 'No',
    );
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
