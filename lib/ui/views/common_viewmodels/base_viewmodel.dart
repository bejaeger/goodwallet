import 'dart:async';

import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/user/statistics/user_statistics.dart';
import 'package:good_wallet/datamodels/user/user.dart';
import 'package:good_wallet/enums/user_status.dart';
import 'package:good_wallet/exceptions/firestore_api_exception.dart';
import 'package:good_wallet/exceptions/money_transfer_exception.dart';
import 'package:good_wallet/services/user/user_service.dart';
import 'package:good_wallet/ui/views/payments/payments_view.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

// The Basemodel
// All our ViewModels inherit from this class so
// put everything here that needs to be available throughout the
// entire App

class BaseModel extends BaseViewModel {
  final UserService? _userService = locator<UserService>();
  final SnackbarService? _snackbarService = locator<SnackbarService>();
  final NavigationService? _navigationService = locator<NavigationService>();

  final baseModelLog = getLogger("BaseModel");

  User get currentUser => _userService!.currentUser;

  bool get isUserSignedIn =>
      _userService!.userStatus == UserStatus.SignedIn ||
      _userService!.userStatus == UserStatus.Initialized;
  bool get isUserInitialized =>
      _userService!.userStatus == UserStatus.Initialized;

  UserStatistics get userStats => _userService!.userStats!;
  StreamSubscription? _userStatsSubscription;

  BaseModel() {
    baseModelLog.i("Initialized!");

    //--------------------------------------
    // Set up top-level listeners

    // listen to changes in wallet
    _userStatsSubscription = _userService!.userStatsSubject.listen(
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

  void navigateToStripeView() {
    try {
      _navigationService!.navigateTo(
        Routes.paymentView,
      );
    } catch (error) {
      throw MoneyTransferException(
        message: 'Failed to create new user',
        devDetails: '$error',
      );
    }
    //_navigationService!.navigateTo(Routes.paymentView);
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
