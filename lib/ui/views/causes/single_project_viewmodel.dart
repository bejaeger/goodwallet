import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/causes/concise_info/concise_project_info.dart';
import 'package:good_wallet/datamodels/causes/project.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/recipient_info.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/sender_info.dart';
import 'package:good_wallet/enums/money_source.dart';
import 'package:good_wallet/enums/transfer_type.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';

class SingleProjectViewModel extends BaseModel {
  final DialogService? _dialogService = locator<DialogService>();
  final NavigationService? _navigationService = locator<NavigationService>();

  final log = getLogger("single_project_viewmodel.dart");

  void navigateToTransferFundAmountView(Project project) {
    final recipientInfo = RecipientInfo.donation(
        name: project.name,
        id: project.id,
        projectInfo: ConciseProjectInfo(
            name: project.name, id: project.id, area: project.area));
    _navigationService!.navigateTo(Routes.transferFundsAmountView,
        arguments: TransferFundsAmountViewArguments(
            senderInfo: SenderInfo(moneySource: MoneySource.GoodWallet),
            type: TransferType.Donation,
            recipientInfo: recipientInfo));
  }

  Future showAmountTooHighDialog(String donationAmount) async {
    await _dialogService!.showConfirmationDialog(
      title: 'Donation Amount Too High',
      description:
          'You cannot donate \$ $donationAmount with just \$ ${userStats.currentBalance / 100} in your account.',
    );
  }

  void navigateBack() {
    _navigationService!.back();
  }
}
