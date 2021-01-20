// The Basemodel
// Put everything here that needs to be available throughout the
// entire Ap

import 'package:good_wallet/app/locator.dart';
import 'package:good_wallet/datamodels/user.dart';
import 'package:good_wallet/datamodels/user_state.dart';
import 'package:good_wallet/enums/user_status.dart';
import 'package:good_wallet/services/authentification/authentification_service.dart';
import 'package:good_wallet/services/userdata/wallet_client_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stacked/stacked.dart';

// TODO: I think a ReactiveViewModel is enough here
class BaseModel extends ReactiveViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final UserWalletService _userWalletService = locator<UserWalletService>();
  @override
  List<ReactiveServiceMixin> get reactiveServices => [_userWalletService];

  //BehaviorSubject<MyUser> currentUserSubj

  MyUser get currentUser => _authenticationService.currentUser;
  UserStatus get userStatus => _authenticationService.userStatus;
  BehaviorSubject<UserState> get userStateSubject =>
      _authenticationService.userState;

  num get balance => _userWalletService.balance;
  num get implicitDonations => _userWalletService.implicitDonations;
  num get donations => _userWalletService.donations;

  // TODO: When is this initialized!?
  BaseModel() {
    print("Initialize BaseModel!");
    _authenticationService.userState.listen((state) {
      notifyListeners();
    });
  }
}
