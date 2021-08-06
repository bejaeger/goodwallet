import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/enums/search_type.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RaiseMoneyBottomSheetViewModel extends BaseModel {
  final NavigationService? _navigationService = locator<NavigationService>();
  final log = getLogger("RaiseMoneyBottomSheetViewModel");

  Future navigateToAcceptPaymentsView() async {
    log.i("Clicked navigating to accept payments view (not yet implemented!)");
    await _navigationService!.navigateTo(Routes.qRCodeViewMobile,
        arguments: QRCodeViewMobileArguments(
            initialIndex: 1, searchType: SearchType.None));
  }

  Future navigateToManageMoneyPoolsView() async {
    await _navigationService!.navigateTo(Routes.moneyPoolsView);
  }

  void navigateToCreateMoneyPoolView() {
    _navigationService!.navigateTo(Routes.createMoneyPoolIntroView);
  }
}
