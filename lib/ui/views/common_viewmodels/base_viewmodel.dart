import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/user/user_model.dart';
import 'package:good_wallet/datamodels/user/user_state_model.dart';
import 'package:good_wallet/enums/user_status.dart';
import 'package:good_wallet/services/authentification/authentification_service.dart';
import 'package:good_wallet/services/userdata/user_data_service.dart';
import 'package:good_wallet/services/userdata/wallet_client_service.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stacked/stacked.dart';

// The Basemodel
// All our ViewModels inherit from this class so
// put everything here that needs to be available throughout the
// entire App

class BaseModel extends IndexTrackingViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final UserDataService _userDataService = locator<UserDataService>();
  final UserWalletService _userWalletService = locator<UserWalletService>();
  final log = getLogger("BaseModel");

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_userWalletService];

  MyUser get currentUser => _userDataService.currentUser;
  UserStatus get userStatus => _authenticationService.userStatus;
  bool get isSignedIn => _authenticationService.isSignedIn;

  BehaviorSubject<UserState> get userStateSubject =>
      _authenticationService.userStateSubject;

  num get balance => _userWalletService.balance;
  num get implicitDonations => _userWalletService.implicitDonations;
  num get donations => _userWalletService.donations;

  BaseModel() {
    log.i("Initialized!");
    _authenticationService.userStateSubject.listen((state) {
      notifyListeners();
    });
  }
}
