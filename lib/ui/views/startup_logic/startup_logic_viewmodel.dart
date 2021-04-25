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

  StreamSubscription? _userStateSubscription;

  final log = getLogger("startup_logic_viewmodel.dart");

  void handleStartUpLogic() {
    _userStateSubscription = _userDataService!.userStateSubject.listen(
      (state) async {
        if (state == UserStatus.Initialized) {
          // TODO: improve transition!
          log.i("User already signed in, navigating to home view");
          await _moneyPoolService!.init(currentUser.id);
          Future.delayed(Duration(seconds: 1));
          await _navigationService!.replaceWithTransition(
              LayoutTemplateViewMobile(),
              duration: Duration(milliseconds: 1500));
          _userStateSubscription?.cancel();
        }
        if (state == UserStatus.SignedOut) {
          _navigationService!.replaceWithTransition(LoginView(),
              duration: Duration(seconds: 1500));
          // _userStateSubscription?.cancel();
        }
        if (state == UserStatus.SignedInNotInitialized) {
          log.e(
              "Found user in SignedInNotInitialized state. Please check the code, this is bad!");
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
