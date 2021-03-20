import 'package:good_wallet/app/locator.dart';
import 'package:good_wallet/app/router.gr.dart';
import 'package:good_wallet/services/authentification/authentification_service.dart';
import 'package:good_wallet/ui/views/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeCustomAppBarViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future logout() async {
    setBusy(true);
    await _authenticationService.logout();
    setBusy(false);
    navigateToLoginView();
  }

  Future navigateToLoginView() async {
    await _navigationService.navigateTo(Routes.loginView);
  }
}
