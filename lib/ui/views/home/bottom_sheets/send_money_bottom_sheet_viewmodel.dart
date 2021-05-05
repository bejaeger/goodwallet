import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/transactions/transaction.dart';
import 'package:good_wallet/datamodels/user/public_user_info.dart';
import 'package:good_wallet/enums/bottom_navigator_index.dart';
import 'package:good_wallet/enums/fund_transfer_type.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';

class SendMoneyBottomSheetViewModel extends BaseModel {
  final NavigationService? _navigationService = locator<NavigationService>();

  final List<Peer2PeerTransaction> latestTransactions;
  SendMoneyBottomSheetViewModel({required this.latestTransactions});
  final log = getLogger("send_money_bottom_sheet_viewmodel.dart");

  void navigateToSearchViewMobile() {
    _navigationService!.navigateTo(Routes.searchView);
  }

  void navigateToScanQRCodeView() {
    _navigationService!.navigateTo(Routes.qRCodeViewMobile,
        arguments: QRCodeViewMobileArguments(initialIndex: 0));
  }

  void navigateToTransferFundsAmountView(
      Peer2PeerTransaction previousTransaction) {
    var userInfo = PublicUserInfo(
        name: previousTransaction.transactionDetails.recipientName,
        uid: previousTransaction.transactionDetails.recipientId);
    _navigationService!.navigateTo(
      Routes.transferFundsAmountView,
      arguments: TransferFundsAmountViewArguments(
        type: FundTransferType.transferToPeer,
        receiverInfo: userInfo,
      ),
    );
  }
}
