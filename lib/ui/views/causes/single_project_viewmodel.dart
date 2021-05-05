import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/enums/fund_transfer_type.dart';
import 'package:good_wallet/services/payments/dummy_payment_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';

class SingleProjectViewModel extends BaseModel {
  final DialogService? _dialogService = locator<DialogService>();
  final DummyPaymentService? _dummyPaymentService =
      locator<DummyPaymentService>();
  final NavigationService? _navigationService = locator<NavigationService>();

  final log = getLogger("single_project_viewmodel.dart");

  void navigateToTransferFundAmountView(dynamic project) {
    _navigationService!.navigateTo(Routes.transferFundsAmountView,
        arguments: TransferFundsAmountViewArguments(
            type: FundTransferType.donation, receiverInfo: project));
  }

  Future showAmountTooHighDialog(String donationAmount) async {
    await _dialogService!.showConfirmationDialog(
      title: 'Donation Amount Too High',
      description:
          'You cannot donate \$ $donationAmount with just \$ ${userWallet.currentBalance / 100} in your account.',
    );
  }

  void navigateBack() {
    _navigationService!.back();
  }
}
