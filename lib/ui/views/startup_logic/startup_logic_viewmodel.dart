import 'dart:async';

import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/enums/bottom_navigator_index.dart';
import 'package:good_wallet/enums/user_status.dart';
import 'package:good_wallet/services/money_pools/money_pool_service.dart';
import 'package:good_wallet/services/userdata/user_data_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:good_wallet/ui/views/home/home_view_mobile.dart';
import 'package:good_wallet/ui/views/layout/layout_template_view_mobile.dart';
import 'package:good_wallet/ui/views/login/login_view.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';

class StartUpLogicViewModel extends BaseModel {
  final UserDataService? _userDataService = locator<UserDataService>();
  final NavigationService? _navigationService = locator<NavigationService>();
  final MoneyPoolService? _moneyPoolService = locator<MoneyPoolService>();

  final log = getLogger("startup_logic_viewmodel.dart");

  UserStatus? userStatus;
  StreamSubscription? _userStateSubscription;

  void handleStartUpLogic() {
    _userStateSubscription = _userDataService!.userStateSubject.listen(
      (state) async {
        log.v("Listened to auth state change update: state = $state");
        userStatus = state;
        if (state == UserStatus.Initialized) {
          // TODO: improve transition!
          log.i("User already signed in, navigating to home view");
          await _moneyPoolService!.init(currentUser.uid);
          Future.delayed(Duration(seconds: 1));
          await _navigationService!.replaceWith(
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
        log.i("Listened to user state!");
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
