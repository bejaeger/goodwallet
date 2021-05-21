import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/data/description_texts.dart';
import 'package:good_wallet/datamodels/money_pools/base/money_pool.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/sender_info.dart';
import 'package:good_wallet/enums/bottom_sheet_type.dart';
import 'package:good_wallet/enums/money_source.dart';
import 'package:good_wallet/enums/transfer_type.dart';
import 'package:good_wallet/services/money_pools/money_pools_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class MoneyPoolsViewModel extends BaseModel {
  final NavigationService? _navigationService = locator<NavigationService>();
  final MoneyPoolsService? _moneyPoolsService = locator<MoneyPoolsService>();
  final SnackbarService? _snackbarService = locator<SnackbarService>();
  final DialogService? _dialogService = locator<DialogService>();
  final BottomSheetService? _bottomSheetService = locator<BottomSheetService>();

  List<MoneyPool> get moneyPools => _moneyPoolsService!.moneyPools;
  List<MoneyPool> get moneyPoolsInvitedTo =>
      _moneyPoolsService!.moneyPoolsInvitedTo;

  final log = getLogger("money_pools_viewmodel.dart");

  // Starting money pool listener. Should only ever be called once!
  Future listenToMoneyPools() async {
    setBusy(true);
    await _moneyPoolsService!.listenToMoneyPools(uid: currentUser.uid);
    setBusy(false);
  }

  Future refresh() async {
    await Future.delayed(Duration(seconds: 1));
    notifyListeners();
  }

  Future showInformationDialog() async {
    await _dialogService!.showDialog(
      title: "Money pools",
      description: DescriptionText.moneyPoolDescription,
    );
  }

  Future showInvitationBottomSheet(int index) async {
    var sheetResponse = await _bottomSheetService!.showCustomSheet(
      variant: BottomSheetType.MoneyPoolInvitation,
      customData: moneyPoolsInvitedTo[index],
      barrierDismissible: true,
    );
    if (sheetResponse != null) {
      log.i("Response data from bottom sheet: ${sheetResponse.responseData}");
      if (sheetResponse.responseData is Function) sheetResponse.responseData();

      if (sheetResponse.confirmed) {
        setBusy(true);
        // accepted invitation
        bool success = await _moneyPoolsService!.acceptInvitation(
            currentUser.uid, currentUser.fullName, moneyPoolsInvitedTo[index]);
        if (success is String)
          _snackbarService!.showSnackbar(
              title: "Invitation could not be accepted",
              message: success as String);
        else
          _snackbarService!.showSnackbar(message: "Accepted invitation");
        setBusy(false);
      } else {
        // devlined invitation
        await _moneyPoolsService!
            .declineInvitation(currentUser.uid, moneyPoolsInvitedTo[index]);
        _snackbarService!.showSnackbar(message: "Declined invitation");
      }
    }
  }

  Future navigateToSingleMoneyPoolView(MoneyPool moneyPool) async {
    await _navigationService!.navigateTo(Routes.singleMoneyPoolView,
        arguments: SingleMoneyPoolViewArguments(moneyPool: moneyPool));
  }

  void navigateToCreateMoneyPoolView() {
    _navigationService!.navigateTo(Routes.createMoneyPoolIntroView);
  }

  void navigateToTransferFundAmountView() {
    _navigationService!.navigateTo(Routes.transferFundsAmountView,
        arguments: TransferFundsAmountViewArguments(
            senderInfo: SenderInfo(moneySource: MoneySource.Bank),
            type: TransferType.PrepaidFund));
  }
}
