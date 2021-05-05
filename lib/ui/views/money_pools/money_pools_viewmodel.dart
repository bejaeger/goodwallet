import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/data/description_texts.dart';
import 'package:good_wallet/datamodels/money_pools/base/money_pool.dart';
import 'package:good_wallet/enums/bottom_sheet_type.dart';
import 'package:good_wallet/enums/fund_transfer_type.dart';
import 'package:good_wallet/services/money_pools/money_pool_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class MoneyPoolsViewModel extends BaseModel {
  final NavigationService? _navigationService = locator<NavigationService>();
  final MoneyPoolService? _moneyPoolService = locator<MoneyPoolService>();
  final SnackbarService? _snackbarService = locator<SnackbarService>();
  final DialogService? _dialogService = locator<DialogService>();
  final BottomSheetService? _bottomSheetService = locator<BottomSheetService>();

  List<MoneyPool> get moneyPools => _moneyPoolService!.moneyPools;
  List<MoneyPool> get moneyPoolsInvitedTo =>
      _moneyPoolService!.moneyPoolsInvitedTo;

  final log = getLogger("money_pools_viewmodel.dart");

  Future fetchMoneyPools({bool force = false}) async {
    setBusy(true);
    try {
      await _moneyPoolService!.loadMoneyPools(currentUser.id, force);
      await _moneyPoolService!.loadMoneyPoolsInvitedTo(currentUser.id);
    } catch (e) {
      // Need to set some validation
      log.e("Could not fetch money pools, error: ${e.toString()}");
      log.e("NEED TO SET SOME public facing validation method HERE!");
    }
    setBusy(false);
  }

  Future showInformationDialog() async {
    await _dialogService!.showDialog(
      title: "Money pools",
      description: DescriptionText.moneyPoolDescription,
    );
  }

  Future showInvitationBottomSheet(int index) async {
    var sheetResponse = await _bottomSheetService!.showCustomSheet(
      variant: BottomSheetType.moneyPoolInvitation,
      customData: moneyPoolsInvitedTo[index],
      barrierDismissible: true,
    );
    if (sheetResponse != null) {
      log.i("Response data from bottom sheet: ${sheetResponse.responseData}");
      if (sheetResponse.responseData is Function) sheetResponse.responseData();

      if (sheetResponse.confirmed) {
        setBusy(true);
        // accepted invitation
        bool success = await _moneyPoolService!.acceptInvitation(
            currentUser.id, currentUser.fullName, moneyPoolsInvitedTo[index]);
        if (success is String)
          _snackbarService!.showSnackbar(
              title: "Invitation could not be accepted",
              message: success as String);
        else
          _snackbarService!.showSnackbar(message: "Accepted invitation");
        setBusy(false);
      } else {
        // devlined invitation
        await _moneyPoolService!
            .declineInvitation(currentUser.id, moneyPoolsInvitedTo[index]);
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
            type: FundTransferType.prepaidFundTopUp));
  }
}
