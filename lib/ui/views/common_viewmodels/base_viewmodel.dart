import 'dart:async';

import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/user/statistics/user_statistics.dart';
import 'package:good_wallet/datamodels/user/user_model.dart';
import 'package:good_wallet/enums/user_status.dart';
import 'package:good_wallet/services/userdata/user_data_service.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

// The Basemodel
// All our ViewModels inherit from this class so
// put everything here that needs to be available throughout the
// entire App

class BaseModel extends BaseViewModel {
  final UserDataService? _userDataService = locator<UserDataService>();
  final SnackbarService? _snackbarService = locator<SnackbarService>();
  final NavigationService? _navigationService = locator<NavigationService>();

  final baseModelLog = getLogger("BaseModel");

  GWUser get currentUser => _userDataService!.currentUser;

  UserStatus? userStatus;
  bool get isUserSignedIn =>
      userStatus == UserStatus.SignedIn || userStatus == UserStatus.Initialized;
  bool get isUserInitialized => userStatus == UserStatus.Initialized;

  late UserStatistics userStats;

  StreamSubscription? _userState;
  StreamSubscription? _userStats;

  BaseModel() {
    baseModelLog.i("Initialized!");

    //--------------------------------------
    // Set up top-level listeners

    //  listen to changes in auth state
    _userState = _userDataService!.userStateSubject.listen(
      (state) {
        baseModelLog.v("Listened to auth state change update: state = $state");
        userStatus = state;
        notifyListeners();
      },
    );

    // listen to changes in wallet
    _userStats = _userDataService!.userStatsSubject.listen(
      (wallet) {
        baseModelLog.v("Listened to wallet update");
        userStats = wallet;
        notifyListeners();
      },
    );
  }

  void showNotImplementedSnackbar() {
    _snackbarService!.showSnackbar(
        title: "Not yet implemented.",
        message: "I know... it's sad",
        duration: Duration(seconds: 2));
  }

  void navigateBack() {
    _navigationService!.back();
  }

  @override
  dispose() {
    _userState?.cancel();
    _userStats?.cancel();
    super.dispose();
  }
}
