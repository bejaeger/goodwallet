import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/money_pools/money_pool_contribution.dart';
import 'package:good_wallet/datamodels/payments/transaction_model.dart';
import 'package:good_wallet/datamodels/payments/wallet_balances_model.dart';
import 'package:good_wallet/datamodels/user/user_model.dart';
import 'package:good_wallet/enums/fund_transfer_type.dart';
import 'package:good_wallet/services/payments/dummy_payment_service.dart';
import 'package:good_wallet/services/userdata/user_data_service.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:good_wallet/ui/views/transfer_funds/transfer_funds_amount_view.form.dart';

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

  Future showConfirmationBottomSheetAndProcessPayment() async {
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

  Future handleTopUpPayment() async {
    SheetResponse? sheetResponse = await _bottomSheetService!.showBottomSheet(
        title: "Select Payment Method",
        description: "OR add new payment method +",
        confirmButtonTitle: "Credit Card / Google Pay",
        cancelButtonTitle: "Test Payment");

    log.i("Response data from bottom sheet: ${sheetResponse?.confirmed}");

    if (sheetResponse?.confirmed == false) {
      // FOR now, implemented dummy payment processing here
      var amount = double.parse(amountValue!);

      _snackbarService!.showSnackbar(
          title:
              "Transfer ${formatAmount(amount, true)}. This is not yet processed in the backend, however!",
          message: "I know... it's sad");
      ///////////////////////////////////////////////////////
      /// TODO
      ///////////////////////////////////////////////////////////
    } else {
      // Properly add Gpay / Credit card pay / ...
      _snackbarService!.showSnackbar(
          title: "Not yet implemented.", message: "I know... it's sad");
    }
  }

  Future handleSendMoneyPayment() async {
    SheetResponse? sheetResponse = await _bottomSheetService!.showBottomSheet(
        title: "Select Payment Method",
        description: "OR add new payment method +",
        confirmButtonTitle: "Credit Card / Google Pay",
        cancelButtonTitle: "Test Payment");
    log.i("Response data from bottom sheet: ${sheetResponse?.confirmed}");
    setBusy(true);
    if (sheetResponse?.confirmed == false) {
      // FOR now, implemented dummy payment processing here
      var amount = double.parse(amountValue!);
      try {
        var data = await prepareTransactionModel();
        await _dummyPaymentService.processTransaction(data);
      } catch (e) {
        log.e(
            "Something went wrong processing the dummy payment, error: ${e.toString()}");
        _snackbarService!.showCustomSnackBar(
            title: "Could not process payment", message: "");
      }
      await Future.delayed(Duration(seconds: 1));

      // _dialogService

      _snackbarService!.showSnackbar(
          title:
              "Transferred ${formatAmount(amount, true)} to ${_receiverInfo!.name}!",
          message: "I know... it's great!");
    } else {
      // Properly add Gpay / Credit card pay / ...
      _snackbarService!.showSnackbar(
          title: "Not yet implemented.", message: "I know... it's sad");
    }
    setBusy(false);
  }

  Future handleDonationPayment() async {
    var amount = double.parse(amountValue!);
    SheetResponse? sheetResponse = await _bottomSheetService!.showBottomSheet(
      title: 'Confirmation',
      description:
          "Are you sure you want to donate ${formatAmount(amount, true)} from your Good Wallet to the project '${_receiverInfo.title}'",
      confirmButtonTitle: 'Yes',
      cancelButtonTitle: 'No',
    );
    setBusy(true);
    if (sheetResponse?.confirmed == true) {
      // FOR now, implemented dummy payment processing here
      _dummyPaymentService.processDonation(currentUser.id, _receiverInfo.title,
          scaleAmountForStripe(amount) as int);
      await Future.delayed(Duration(seconds: 1));
      log.i("Processed donation");

      _snackbarService!.showSnackbar(
          title: "Succesfully donated!", message: "I know... it's great!");
    } else if (sheetResponse?.confirmed == false) {
      _snackbarService!.showSnackbar(
          title: "Cancelled payment", message: "I know... it's sad");
    }
    setBusy(false);
  }

  Future handleMoneyPoolPayment() async {
    var amount = double.parse(amountValue!);
    SheetResponse? sheetResponse = await _bottomSheetService!.showBottomSheet(
        title: "Select Payment Method",
        description: "OR add new payment method +",
        confirmButtonTitle: "Credit Card / Google Pay",
        cancelButtonTitle: "Test Payment");
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
      await Future.delayed(Duration(seconds: 1));
      log.i("Processed donation");
      _snackbarService!.showSnackbar(
          title: "Succesfully contributed to money pool!",
          message: "I know... it's great!");
    } else if (sheetResponse?.confirmed == true) {
      _snackbarService!.showSnackbar(
          title: "Cancelled payment", message: "I know... it's sad");
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

  @override
  void setFormStatus() async {
    // THIS IS A HACK!
    // Otherwise the customvalidation message is overwritten before showing!
    // Need to fix this properly at some point!
    await Future.delayed(Duration(seconds: 4));
    log.i("Set custom Form status");
    customValidationMessage = null;
  }

  @override
  void dispose() {
    _walletSubscription?.cancel();
    super.dispose();
  }
}
