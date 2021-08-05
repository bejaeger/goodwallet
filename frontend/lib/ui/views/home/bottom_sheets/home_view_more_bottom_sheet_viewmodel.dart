import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/sender_info.dart';
import 'package:good_wallet/enums/money_source.dart';
import 'package:good_wallet/enums/search_type.dart';
import 'package:good_wallet/enums/transfer_type.dart';
import 'package:good_wallet/exceptions/money_transfer_exception.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewMoreBottomSheetViewModel extends BaseModel {
  final NavigationService? _navigationService = locator<NavigationService>();

  void navigateToExploreView() {
    _navigationService!.navigateTo(Routes.searchView,
        arguments: SearchViewArguments(
            searchType: SearchType.FindFriends, autofocus: true));
  }

  Future navigateToCommitMoneyView() async {
    await _navigationService!.navigateTo(Routes.transferFundsAmountView,
        arguments: TransferFundsAmountViewArguments(
            senderInfo: SenderInfo(moneySource: MoneySource.Bank),
            type: TransferType.User2OwnGoodWallet));
  }

  void navigateToQRCodeView() {
    _navigationService!.navigateTo(Routes.qRCodeViewMobile,
        arguments: QRCodeViewMobileArguments(initialIndex: 1));
  }

  void navigateToStripeView() {
    try {
      _navigationService!.navigateTo(
        Routes.paymentView,
      );
    } catch (error) {
      throw MoneyTransferException(
        message: 'Failed to create new user',
        devDetails: '$error',
      );
    }
    //_navigationService!.navigateTo(Routes.paymentView);
  }
}
