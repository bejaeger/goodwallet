// The Basemodel
// Put everything here that needs to be available throughout the
// entire Ap

import 'package:good_wallet/app/locator.dart';
import 'package:good_wallet/datamodels/user.dart';
import 'package:good_wallet/services/authentification/authentification_service.dart';
import 'package:good_wallet/services/userdata/wallet_client_service.dart';
import 'package:stacked/stacked.dart';

class BaseModel extends IndexTrackingViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final UserWalletService _userWalletService = locator<UserWalletService>();
  @override
  List<ReactiveServiceMixin> get reactiveServices => [_userWalletService];

  MyUser get currentUser => _authenticationService.currentUser;
  num get balance => _userWalletService.balance;
  num get implicitDonations => _userWalletService.implicitDonations;
  num get donations => _userWalletService.donations;
}
