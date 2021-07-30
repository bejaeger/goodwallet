import 'dart:async';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/user/user.dart';
import 'package:good_wallet/enums/user_status.dart';
import 'package:good_wallet/services/money_pools/money_pools_service.dart';
import 'package:good_wallet/services/user/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';

class StartUpLogicViewModel extends BaseViewModel {
  final UserService? _userService = locator<UserService>();
  final NavigationService? _navigationService = locator<NavigationService>();
  final MoneyPoolsService? _moneyPoolsService = locator<MoneyPoolsService>();
  User get currentUser => _userService!.currentUser;

  final log = getLogger("startup_logic_viewmodel.dart");

  UserStatus? userStatus;
  StreamSubscription? _userStateSubscription;
  //Stripe.publishableKey = accountKey;
  void handleStartUpLogic() {
    _userStateSubscription = _userService!.userStateSubject.listen(
      (state) async {
        log.v("Listening to auth state change update: state = $state");
        userStatus = state;
        if (state == UserStatus.Initialized) {
          log.i("User already signed in, navigating to home view");
          _moneyPoolsService!.init(uid: currentUser.uid);
          _navigationService!.replaceWith(
            Routes.layoutTemplateViewMobile,
          );
          _userStateSubscription?.cancel();
        }
        if (state == UserStatus.SignedOut) {
          _navigationService!.replaceWith(
            Routes.loginView,
          );
          _userStateSubscription?.cancel();
        }
        if (state == UserStatus.SignedInNotInitialized) {
          log.wtf(
              "Found user in SignedInNotInitialized state. Please check the code, this is bad!");
          _navigationService!.replaceWith(
            Routes.loginView,
          );
        }
        // cancel afterwards
      },
    );
  }

  bool showLoadingScreen() {
    if (userStatus == UserStatus.SignedInNotInitialized) {
      return false;
    } else {
      return true;
    }
  }

  @override
  void dispose() {
    log.i("Cancel start-up handler subscription");
    _userStateSubscription?.cancel();
    super.dispose();
  }
}
