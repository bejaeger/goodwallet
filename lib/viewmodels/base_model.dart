// The Basemodel
// Put everything here that needs to be available throughout the
// entire Ap

import 'package:good_wallet/app/locator.dart';
import 'package:good_wallet/datamodels/user/user.dart';
import 'package:good_wallet/datamodels/user/user_state.dart';
import 'package:good_wallet/enums/user_status.dart';
import 'package:good_wallet/services/authentification/authentification_service.dart';
import 'package:good_wallet/services/layout/layout_service.dart';
import 'package:good_wallet/services/userdata/wallet_client_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stacked/stacked.dart';

class BaseModel extends ReactiveViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final UserWalletService _userWalletService = locator<UserWalletService>();
  final LayoutService _layoutService = locator<LayoutService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_userWalletService, _layoutService];

  MyUser get currentUser => _authenticationService.currentUser;
  UserStatus get userStatus => _authenticationService.userStatus;
  BehaviorSubject<UserState> get userStateSubject =>
      _authenticationService.userStateSubject;

  num get balance => _userWalletService.balance;
  num get implicitDonations => _userWalletService.implicitDonations;
  num get donations => _userWalletService.donations;

  bool get showNavigationBar => _layoutService.showNavigationBar;
  void setShowNavigationBar(bool show) {
    _layoutService.setShowNavigationBar(show);
  }

  // TODO: When is this initialized!?
  BaseModel() {
    print("INFO: Initialize BaseModel!");
    _authenticationService.userStateSubject.listen((state) {
      notifyListeners();
    });
  }
}
