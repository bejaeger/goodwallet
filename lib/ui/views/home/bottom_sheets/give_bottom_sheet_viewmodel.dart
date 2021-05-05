import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/causes/preview_details/project_preview_details.dart';
import 'package:good_wallet/datamodels/transactions/transaction.dart';
import 'package:good_wallet/enums/transaction_direction.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

class GiveBottomSheetViewModel extends BaseModel {
  final NavigationService? _navigationService = locator<NavigationService>();

  final List<Donation> latestDonations;
  GiveBottomSheetViewModel({required this.latestDonations});

  void navigateToCausesView() {
    _navigationService!.replaceWith(Routes.layoutTemplateViewMobile,
        arguments:
            LayoutTemplateViewMobileArguments(initialBottomNavBarIndex: 1));
  }

  void navigateToAllPreviousDonations() {
    _navigationService!.navigateTo(Routes.transactionsView,
        arguments: TransactionsViewArguments(
            historyType: TransactionDirection.Donation));
  }
}
