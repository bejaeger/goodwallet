import 'package:good_wallet/app/locator.dart';
import 'package:good_wallet/app/router.gr.dart';
import 'package:good_wallet/ui/views/base_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RaiseMoneyBottomSheetViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();

  Future navigateToSettingsView() async {
    await _navigationService.navigateTo(Routes.settingsView);
  }
}
