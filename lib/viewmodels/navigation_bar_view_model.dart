import 'package:good_wallet/app/locator.dart';
import 'package:good_wallet/app/router.gr.dart';
import 'package:good_wallet/services/authentification/authentification_service.dart';
import 'package:good_wallet/viewmodels/base_model.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/material.dart';

class NavigationBarViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();

  Future navigateToWelcomeView() async {
    await _navigationService.navigateTo(Routes.welcomeView);
  }

  Future navigateToWalletView() async {
    await _navigationService.navigateTo(Routes.walletView);
  }

  Future navigateToSendMoneyView() async {
    await _navigationService.navigateTo(Routes.sendMoneyView);
  }

  Future navigateToDonationView() async {
    await _navigationService.navigateTo(Routes.donationView);
  }

  Future loginWithGoogle() async {
    setBusy(true);
    final result = await _authenticationService.loginWithGoogle();
    if (result) {
      print("INFO: User succesfully logged in!");
    } else {
      print("INFO: Failed logging in user!");
    }
    setBusy(false);
  }

  Future loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    setBusy(true);

    var result = await _authenticationService.loginWithEmail(
      email: email,
      password: password,
    );

    setBusy(false);

    if (result is bool) {
      if (result) {
        print("INFO: User is logged in!");
      } else {
        await _dialogService.showDialog(
          title: 'Login Failure',
          description: 'General login failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Login Failure',
        description: result,
      );
    }
  }

  Future signUp({
    @required String email,
    @required String password,
    @required String fullName,
  }) async {
    setBusy(true);

    var result = await _authenticationService.signUpWithEmail(
        email: email, password: password, fullName: fullName);

    setBusy(false);

    if (result is bool) {
      if (result) {
        print("User is logged in!");
      } else {
        await _dialogService.showDialog(
          title: 'Sign Up Failure',
          description: 'General sign up failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Sign Up Failure',
        description: result,
      );
    }
  }

  //  TODO put in some proper initializer!
  Future handleStartUpLogic() async {
    print("INFO: Check if user is logged in");
    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();
    if (hasLoggedInUser) {
      print(
          "INFO: User ${_authenticationService.currentUser.fullName} logged in");
    } else {
      print("INFO: No user is logged in");
    }
    notifyListeners();
  }

  Future logout() async {
    setBusy(true);
    await _authenticationService.logout();
    setBusy(false);
    notifyListeners();
  }
}
