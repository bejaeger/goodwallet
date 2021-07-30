import 'dart:async';

import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/money_pools/base/money_pool.dart';
import 'package:good_wallet/enums/user_status.dart';
import 'package:good_wallet/services/money_pools/money_pools_service.dart';
import 'package:good_wallet/services/user/user_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:rxdart/subjects.dart';

class LayoutTemplateViewModel extends BaseModel {
  final MoneyPoolsService? _moneyPoolsService = locator<MoneyPoolsService>();
  final UserService? _userService = locator<UserService>();

  List<MoneyPool> get moneyPoolsInvitedTo =>
      _moneyPoolsService!.moneyPoolsInvitedTo;
  UserStatus? userStatus;
  StreamSubscription? _userState;

  int numberInvitedMoneyPoolsSubject = 0;

  final log = getLogger("layout_template_viewmodel.dart");
  LayoutTemplateViewModel() {
    //  listen to changes in auth state
    _userState = _userService!.userStateSubject.listen(
      (state) {
        baseModelLog.v("Listened to auth state change update: state = $state");
        userStatus = state;
        notifyListeners();
      },
    );

    // listen to the number of money pools the user is invited to
    // to adjust "money pool" icon
    _moneyPoolsService!.numberInvitedMoneyPoolsSubject.listen((int integer) {
      numberInvitedMoneyPoolsSubject = integer;
      notifyListeners();
    });

    log.i("Constructing layout template view model");
  }
}
