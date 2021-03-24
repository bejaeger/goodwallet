import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/services/authentification/authentification_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfileViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future logout() async {
    setBusy(true);
    await _authenticationService.logout();
    setBusy(false);
    navigateToLoginView();
  }

  void navigateToLoginView() {
    _navigationService.replaceWith(Routes.loginView);
  }

  void navigateBack() => _navigationService.back();
}
