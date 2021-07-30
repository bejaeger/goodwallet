import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/recipient_info.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/sender_info.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
import 'package:good_wallet/enums/money_source.dart';
import 'package:good_wallet/enums/search_type.dart';
import 'package:good_wallet/enums/transfer_type.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';

class SendMoneyBottomSheetViewModel extends BaseModel {
  final NavigationService? _navigationService = locator<NavigationService>();

  final List<MoneyTransfer> latestTransactions;
  SendMoneyBottomSheetViewModel({required this.latestTransactions});
  final log = getLogger("send_money_bottom_sheet_viewmodel.dart");

  void navigateToSearchViewMobile() {
    _navigationService!.navigateTo(Routes.exploreView,
        arguments: ExploreViewArguments(
            searchType: SearchType.UserToTransferTo, autofocus: true));
  }

  void navigateToScanQRCodeView() {
    _navigationService!.navigateTo(Routes.qRCodeViewMobile,
        arguments: QRCodeViewMobileArguments(initialIndex: 0));
  }

  void navigateToTransferFundsAmountView(MoneyTransfer previousTransaction) {
    var userInfo = RecipientInfo.user(
        name: previousTransaction.transferDetails.recipientName,
        id: previousTransaction.transferDetails.recipientId);
    _navigationService!.navigateTo(
      Routes.transferFundsAmountView,
      arguments: TransferFundsAmountViewArguments(
        type: TransferType.User2UserSent,
        senderInfo: SenderInfo(moneySource: MoneySource.Bank),
        recipientInfo: userInfo,
      ),
    );
  }
}
