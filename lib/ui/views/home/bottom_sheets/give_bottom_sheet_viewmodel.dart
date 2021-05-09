import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

class GiveBottomSheetViewModel extends BaseModel {
  final NavigationService? _navigationService = locator<NavigationService>();

  final List<MoneyTransfer> latestDonations;
  GiveBottomSheetViewModel({required this.latestDonations});

  void navigateToCausesView() {
    _navigationService!.replaceWith(Routes.layoutTemplateViewMobile,
        arguments:
            LayoutTemplateViewMobileArguments(initialBottomNavBarIndex: 1));
  }

  void navigateToAllPreviousDonations() {
    _navigationService!.navigateTo(Routes.transfersHistoryView);
  }
}
