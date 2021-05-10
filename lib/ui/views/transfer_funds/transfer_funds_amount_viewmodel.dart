import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/causes/concise_info/concise_project_info.dart';
import 'package:good_wallet/datamodels/money_pools/base/concise_money_pool_info.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
import 'package:good_wallet/datamodels/transfers/transfer_details.dart';
import 'package:good_wallet/datamodels/user/statistics/user_statistics.dart';
import 'package:good_wallet/datamodels/user/user_model.dart';
import 'package:good_wallet/enums/bottom_navigator_index.dart';
import 'package:good_wallet/enums/fund_transfer_type.dart';
import 'package:good_wallet/enums/money_source.dart';
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
  GWUser get currentUser => _userDataService!.currentUser;
  final DummyPaymentService _dummyPaymentService =
      locator<DummyPaymentService>();
  final log = getLogger("transfer_funds_amount_viewmodel.dart");
  late UserStatistics userWallet;
  StreamSubscription<UserStatistics>? _walletSubscription;

  FundTransferType type;
  dynamic receiverInfo;
  late MoneySource moneySource;
  num? amount;
  TransferFundsAmountViewModel(
      {required this.type, required this.receiverInfo}) {
    if (type == FundTransferType.donationFromBank ||
        type == FundTransferType.moneyPoolContributionFromBank ||
        type == FundTransferType.transferToPeer) {
      moneySource = MoneySource.Bank;
    } else {
      moneySource = MoneySource.GoodWallet;
    }

    // Listen to wallet similar to what is done in base viemodel
    _walletSubscription = _userDataService!.userStatsSubject.listen(
      (wallet) {
        userWallet = wallet;
        notifyListeners();
      },
    );
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
      amount = num.parse(amountValue!);
      if (type == FundTransferType.prepaidFundTopUp)
        await handleTopUpPayment();
      else if (type == FundTransferType.transferToPeer) {
        await handleSendMoneyPayment();
      } else if (type == FundTransferType.donation) {
        await handleDonationPayment();
      } else if (type == FundTransferType.moneyPoolContributionFromBank) {
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
    } else if (type == FundTransferType.donation &&
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
    if (type == FundTransferType.moneyPoolContribution ||
        type == FundTransferType.moneyPoolContributionFromBank) {
      SheetResponse? sheetResponse = await _bottomSheetService!.showBottomSheet(
          title: "Select Payment Method",
          description: "OR add new payment method +",
          confirmButtonTitle: "Bank Account",
          cancelButtonTitle: "Prepaid Fund");
      if (sheetResponse?.confirmed == true &&
          type != FundTransferType.moneyPoolContributionFromBank) {
        moneySource = MoneySource.Bank;
        await _navigationService!.replaceWith(Routes.transferFundsAmountView,
            arguments: TransferFundsAmountViewArguments(
                type: FundTransferType.moneyPoolContributionFromBank,
                receiverInfo: receiverInfo));
      }
      if (sheetResponse?.confirmed == false &&
          type != FundTransferType.moneyPoolContribution) {
        await _navigationService!.replaceWith(Routes.transferFundsAmountView,
            arguments: TransferFundsAmountViewArguments(
                type: FundTransferType.moneyPoolContribution,
                receiverInfo: receiverInfo));
      }
    }

    if (type == FundTransferType.donation ||
        type == FundTransferType.donationFromBank) {
      SheetResponse? sheetResponse = await _bottomSheetService!.showBottomSheet(
          title: "Select Payment Method",
          description: "OR add new payment method +",
          confirmButtonTitle: "Bank Account",
          cancelButtonTitle: "Good Wallet");
      if (sheetResponse?.confirmed == true &&
          type != FundTransferType.donationFromBank) {
        await _navigationService!.replaceWith(Routes.transferFundsAmountView,
            arguments: TransferFundsAmountViewArguments(
                type: FundTransferType.donationFromBank,
                receiverInfo: receiverInfo));
      }
      if (sheetResponse?.confirmed == false &&
          type != FundTransferType.donation) {
        await _navigationService!.replaceWith(Routes.transferFundsAmountView,
            arguments: TransferFundsAmountViewArguments(
                type: FundTransferType.donation, receiverInfo: receiverInfo));
      }
    }
  }

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

  Future handleSendMoneyPayment() async {
    SheetResponse? sheetResponse = await _showPaymentMethodBottomSheet();
    log.i("Response data from bottom sheet: ${sheetResponse?.confirmed}");
    if (sheetResponse?.confirmed == false) {
      // FOR now, implemented dummy payment processing here
      try {
        var data = prepareTransactionData();
        SheetResponse? sheetResponse =
            await _showConfirmationBottomSheet(amount!, receiverInfo.name);
        if (sheetResponse?.confirmed == true) {
          setBusy(true);
          await _dummyPaymentService.processTransfer(data);
          setBusy(false);
          _snackbarService!.showSnackbar(
              duration: Duration(seconds: 2),
              title:
                  "Transferred ${formatAmount(amount, true)} to ${receiverInfo!.name}!",
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
    SheetResponse? sheetResponse =
        await _showConfirmationBottomSheet(amount!, receiverInfo.title);
    setBusy(true);
    if (sheetResponse?.confirmed == true) {
      var data = prepareDonationData();
      _dummyPaymentService.processTransfer(data);
      await _showAndAwaitSnackbar("You just made an impact!");
      clearTillFirstAndShowHomeScreen();
    } else if (sheetResponse?.confirmed == false) {
      await _showAndAwaitSnackbar("Cancelled donation process");
    }
    setBusy(false);
  }

  Future handleMoneyPoolPayment() async {
    SheetResponse? sheetResponse = await _showPaymentMethodBottomSheet();
    setBusy(true);
    if (sheetResponse?.confirmed == false) {
      // FOR now, implemented dummy payment processing here
      MoneyTransfer contribution = MoneyTransfer.moneyPoolContribution(
          transferDetails: TransferDetails(
            recipientId: receiverInfo.moneyPoolId,
            recipientName: receiverInfo.name,
            senderId: currentUser.id,
            senderName: currentUser.fullName,
            currency: 'cad',
            amount: scaleAmountForStripe(amount!),
            sourceType: moneySource,
          ),
          moneyPoolInfo: ConciseMoneyPoolInfo.fromJson(receiverInfo.toJson()),
          createdAt: FieldValue.serverTimestamp());
      _dummyPaymentService.processTransfer(contribution);
      log.i("Processed donation");
      await _showAndAwaitSnackbar("Succesfully contributed to money pool!");
      navigateBack();
    } else if (sheetResponse?.confirmed == true) {
      await _showAndAwaitSnackbar("Cancelled contributed to money pool!");
    }
    setBusy(false);
  }

  MoneyTransfer prepareTransactionData() {
    try {
      MoneyTransfer data = MoneyTransfer.peer2peer(
        transferDetails: TransferDetails(
          recipientId: receiverInfo.uid,
          recipientName: receiverInfo.name,
          senderId: currentUser.id,
          senderName: currentUser.fullName,
          amount: scaleAmountForStripe(amount!),
          currency: 'cad',
          sourceType: moneySource,
        ),
        createdAt: FieldValue.serverTimestamp(),
      );
      return data;
    } catch (e) {
      log.e(
          "Could not fill transaction model, Failed with error ${e.toString()}");
      rethrow;
    }
  }

  MoneyTransfer prepareDonationData() {
    try {
      MoneyTransfer data = MoneyTransfer.donation(
        projectInfo: ConciseProjectInfo.fromJson(receiverInfo.toJson()),
        transferDetails: TransferDetails(
          recipientId: "DummyId",
          recipientName: receiverInfo.title,
          senderId: currentUser.id,
          senderName: currentUser.fullName,
          amount: scaleAmountForStripe(amount!),
          currency: 'cad',
          sourceType: moneySource,
        ),
        createdAt: FieldValue.serverTimestamp(),
      );
      return data;
    } catch (e) {
      log.e("Could not fill donation model, Failed with error ${e.toString()}");
      rethrow;
    }
  }

  void navigateBack() {
    _navigationService!.back(result: "contributed");
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
