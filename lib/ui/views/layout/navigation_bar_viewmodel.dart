import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/services/money_pools/money_pools_service.dart';
import 'package:good_wallet/services/user/user_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

class NavigationBarViewModel extends BaseModel {
  final NavigationService? _navigationService = locator<NavigationService>();
  final UserService? _userService = locator<UserService>();
  final MoneyPoolsService? _moneyPoolsService = locator<MoneyPoolsService>();

  Future navigateToWelcomeView() async {
    await _navigationService!.navigateTo(Routes.welcomeView);
  }

  Future navigateToWalletView() async {
    await _navigationService!.navigateTo(Routes.walletView);
  }

  Future navigateToSendMoneyView() async {
    await _navigationService!.navigateTo(Routes.sendMoneyView);
  }

  Future navigateToLoginScreen() async {
    //setShowNavigationBar(false);
    await _navigationService!.navigateTo(Routes.loginView);
  }

  Future logout() async {
    _moneyPoolsService!.clearData();
    await runBusyFuture(_userService!.handleLogoutEvent());
    navigateToWelcomeView();
  }
}
