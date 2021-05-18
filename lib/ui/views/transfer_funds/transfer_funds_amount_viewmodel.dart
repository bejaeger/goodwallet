import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/causes/concise_info/concise_project_info.dart';
import 'package:good_wallet/datamodels/money_pools/base/concise_money_pool_info.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/recipient_info.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/sender_info.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
import 'package:good_wallet/datamodels/transfers/transfer_details.dart';
import 'package:good_wallet/datamodels/user/statistics/user_statistics.dart';
import 'package:good_wallet/datamodels/user/user.dart';
import 'package:good_wallet/enums/bottom_navigator_index.dart';
import 'package:good_wallet/enums/money_source.dart';
import 'package:good_wallet/enums/transfer_type.dart';
import 'package:good_wallet/exceptions/money_transfer_exception.dart';
import 'package:good_wallet/exceptions/user_data_service_exception.dart';
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
/// Make unions for senderInfo and recipientInfo to distinguish money transfer types
///

class TransferFundsAmountViewModel extends FormViewModel {
  final NavigationService? _navigationService = locator<NavigationService>();
  final BottomSheetService? _bottomSheetService = locator<BottomSheetService>();
  final SnackbarService? _snackbarService = locator<SnackbarService>();
  final UserDataService? _userDataService = locator<UserDataService>();
  final DialogService? _dialogService = locator<DialogService>();
  User get currentUser => _userDataService!.currentUser;
  final DummyPaymentService _dummyPaymentService =
      locator<DummyPaymentService>();
  final log = getLogger("transfer_funds_amount_viewmodel.dart");
  StreamSubscription<UserStatistics>? _walletSubscription;
  UserStatistics get userStats => _userDataService!.userStats!;

  final TransferType type;
  final RecipientInfo? recipientInfo;
  final SenderInfo senderInfo;
  num? amount;

  // TODO: Validate inputs here...if Donation, recipientInfo must not be null!
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

  Future showBottomSheetAndProcessPayment() async {
    if (!isValidData()) {
      log.e("Entered amount not valid");
      notifyListeners();
    } else {
      amount = num.parse(amountValue!);
      if (type == TransferType.PrepaidFund)
        await handleTopUpPayment();
      else if (type == TransferType.Peer2PeerSent) {
        await handleTransfer();
      } else if (type == TransferType.Donation) {
        await handleTransfer();
      } else if (type == TransferType.MoneyPoolContribution) {
        await handleTransfer();
      } else {
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
    } else if (type == TransferType.Donation &&
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
    if (type == TransferType.MoneyPoolContribution) {
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

    if (type == TransferType.Donation) {
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

  Future handleTransfer() async {
    SheetResponse? sheetResponse = await _showPaymentMethodBottomSheet();
    setBusy(true);
    if (sheetResponse?.confirmed == false) {
      // Ask for another final confirmation
      SheetResponse? finalConfirmation =
          await _showFinalConfirmationBottomSheet();
      if (finalConfirmation?.confirmed == false) {
        await _showAndAwaitSnackbar("You can come back any time :)");
        setBusy(false);
        navigateBack();
        return;
      }

      // FOR now, implemented dummy payment processing here
      try {
        final data = prepareTransferData();
        _dummyPaymentService.processTransfer(moneyTransfer: data);
        log.i("Processed transfer: $data");
      } catch (e) {
        if (e is MoneyTransferException) {
          await _showFailureDialog(e.prettyDetails);
        } else if (e is UserDataServiceException) {
          await _showFailureDialog(e.prettyDetails);
        } else {
          rethrow;
        }
      }
      await _showAndAwaitSnackbar("Success! You are great :)");

      if (type == TransferType.MoneyPoolContribution) {
        // navigate back to money pool
        navigateBack();
      } else {
        // clear view
        clearTillFirstAndShowHomeScreen();
      }
    } else if (sheetResponse?.confirmed == true) {
      await _showAndAwaitSnackbar("Not supported at the moment, sorry!");
    }
    setBusy(false);
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
          createdAt: FieldValue.serverTimestamp(),
        ),
        moneyPool: (value) => MoneyTransfer.moneyPoolContribution(
          transferDetails: transferDetails,
          moneyPoolInfo: value.moneyPoolInfo,
          createdAt: FieldValue.serverTimestamp(),
        ),
        orElse: () => MoneyTransfer.peer2peer(
          transferDetails: transferDetails,
          createdAt: FieldValue.serverTimestamp(),
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

  Future _showPaymentMethodBottomSheet() async {
    return await _bottomSheetService!.showBottomSheet(
        title: "Select Payment Method",
        description: "OR add new payment method +",
        confirmButtonTitle: "Credit Card / Google Pay",
        cancelButtonTitle: "Test Payment");
  }

  Future _showFailureDialog(String? message) async {
    return await _dialogService!.showConfirmationDialog(
      title: 'Failure',
      description: message,
      confirmationTitle: 'Ok',
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

  Future navigateToSingleProjectScreen({required String projectId}) async {
    await _navigationService!.navigateTo(Routes.singleProjectViewMobile,
        arguments: SingleProjectViewMobileArguments(projectId: projectId));
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
