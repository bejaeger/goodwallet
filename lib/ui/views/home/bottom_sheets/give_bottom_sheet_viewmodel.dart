import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/recipient_info.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/sender_info.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
import 'package:good_wallet/enums/money_source.dart';
import 'package:good_wallet/enums/transfer_type.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';

class GiveBottomSheetViewModel extends BaseModel {
  final NavigationService? _navigationService = locator<NavigationService>();
  final SnackbarService? _snackbarService = locator<SnackbarService>();
  final List<MoneyTransfer> latestDonations;
  GiveBottomSheetViewModel({required this.latestDonations});

  final log = getLogger("give_bottom_sheet_viewmodel.dart");

  void navigateToCausesView() {
    _navigationService!.replaceWith(Routes.layoutTemplateViewMobile,
        arguments:
            LayoutTemplateViewMobileArguments(initialBottomNavBarIndex: 1));
  }

  void navigateToAllPreviousDonations() {
    _navigationService!.navigateTo(Routes.transfersHistoryView);
  }

  void navigateToTransferFundsAmountView(MoneyTransfer previousTransaction) {
    RecipientInfo? userInfo;
    userInfo = previousTransaction.maybeMap(
        donation: (value) => RecipientInfo.donation(
            name: value.transferDetails.recipientName,
            id: value.transferDetails.recipientId,
            projectInfo: value.projectInfo),
        orElse: () => null);
    if (userInfo == null) {
      log.e("User Info could not be found, something went wrong!");
      _snackbarService!.showSnackbar(
          message:
              "An error occured, please navigate through the projects list");
    }
    _navigationService!.navigateTo(
      Routes.transferFundsAmountView,
      arguments: TransferFundsAmountViewArguments(
        type: TransferType.User2Project,
        senderInfo: SenderInfo(moneySource: MoneySource.GoodWallet),
        recipientInfo: userInfo!,
      ),
    );
  }
}
