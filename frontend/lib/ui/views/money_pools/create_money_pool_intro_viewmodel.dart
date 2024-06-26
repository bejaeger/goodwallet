import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

class CreateMoneyPoolIntroViewModel extends BaseModel {
  final NavigationService? _navigationService = locator<NavigationService>();

  Future navigateToCreateMoneyPoolFormView() async {
    await _navigationService!.navigateTo(Routes.createMoneyPoolFormView);
  }
}
