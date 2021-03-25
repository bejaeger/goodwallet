import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/services/userdata/user_data_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

class NavigationBarViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final UserDataService _userDataService = locator<UserDataService>();

  Future navigateToWelcomeView() async {
    await _navigationService.navigateTo(Routes.welcomeView);
  }

  Future navigateToWalletView() async {
    await _navigationService.navigateTo(Routes.walletView);
  }

  Future navigateToSendMoneyView() async {
    await _navigationService.navigateTo(Routes.sendMoneyView);
  }

  Future navigateToDonationView() async {
    await _navigationService.navigateTo(Routes.donationView);
  }

  Future navigateToLoginScreen() async {
    //setShowNavigationBar(false);
    await _navigationService.navigateTo(Routes.loginView);
  }

  Future logout() async {
    await runBusyFuture(_userDataService.handleLogoutEvent());
    navigateToWelcomeView();
  }
}
