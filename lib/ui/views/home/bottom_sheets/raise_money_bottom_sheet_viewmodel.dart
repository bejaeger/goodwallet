import 'package:good_wallet/app/locator.dart';
import 'package:good_wallet/app/router.gr.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RaiseMoneyBottomSheetViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final log = getLogger("RaiseMoneyBottomSheetViewModel");

  Future navigateToSettingsView() async {
    log.i("Navigating to SettingsView");
    //await _navigationService.navigateTo(Routes.settingsView);
  }
}