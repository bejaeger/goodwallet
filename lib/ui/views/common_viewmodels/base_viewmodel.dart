import 'dart:async';

import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/user/statistics/user_statistics.dart';
import 'package:good_wallet/datamodels/user/user.dart';
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

  User get currentUser => _userDataService!.currentUser;

  bool get isUserSignedIn =>
      _userDataService!.userStatus == UserStatus.SignedIn ||
      _userDataService!.userStatus == UserStatus.Initialized;
  bool get isUserInitialized =>
      _userDataService!.userStatus == UserStatus.Initialized;

  UserStatistics get userStats => _userDataService!.userStats!;
  StreamSubscription? _userStatsSubscription;

  BaseModel() {
    baseModelLog.i("Initialized!");

    //--------------------------------------
    // Set up top-level listeners

    // listen to changes in wallet
    _userStatsSubscription = _userDataService!.userStatsSubject.listen(
      (stats) {
        baseModelLog.v("Listened to stats update");
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
    _userStatsSubscription?.cancel();
    super.dispose();
  }
}
