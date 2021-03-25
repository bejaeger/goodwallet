import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/payments/wallet_balances_model.dart';
import 'package:good_wallet/datamodels/user/user_model.dart';
import 'package:good_wallet/enums/user_status.dart';
import 'package:good_wallet/services/userdata/user_data_service.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:stacked/stacked.dart';

// The Basemodel
// All our ViewModels inherit from this class so
// put everything here that needs to be available throughout the
// entire App

class BaseModel extends IndexTrackingViewModel {
  final UserDataService _userDataService = locator<UserDataService>();
  final log = getLogger("BaseModel");

  MyUser get currentUser => _userDataService.currentUser;

  UserStatus userStatus;
  bool get isUserSignedIn =>
      userStatus == UserStatus.SignedIn || userStatus == UserStatus.Initialized;
  bool get isUserInitialized => userStatus == UserStatus.Initialized;

  WalletBalancesModel userWallet = WalletBalancesModel.empty();

  BaseModel() {
    log.i("Initialized!");

    //--------------------------------------
    // Set up top-level listeners

    //  listen to changes in auth state
    _userDataService.userStateSubject.listen(
      (state) {
        log.v("Listened to auth state change update: state = $state");
        userStatus = state;
        notifyListeners();
      },
    );

    // listen to changes in wallet
    _userDataService.userWalletSubject.listen(
      (wallet) {
        log.v("Listened to wallet update");
        if (wallet != null) {
          userWallet = wallet;
          notifyListeners();
        }
      },
    );
  }
}
