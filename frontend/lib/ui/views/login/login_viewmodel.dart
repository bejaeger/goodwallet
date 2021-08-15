import 'dart:async';

import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/enums/authentication_method.dart';
import 'package:good_wallet/flavor_config.dart';
import 'package:good_wallet/ui/views/common_viewmodels/authentication_viewmodel.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:good_wallet/ui/views/login/login_view.form.dart';

class LoginViewModel extends AuthenticationViewModel {
  LoginViewModel() : super(successRoute: Routes.layoutTemplateViewMobile);
  //    kIsWeb ? Routes.walletView : Routes.layoutTemplateViewMobile);
  final FlavorConfigProvider _flavorConfigProvider =
      locator<FlavorConfigProvider>();
  String get releaseName => _flavorConfigProvider.releaseName;
  final log = getLogger("login_viewmodel.dart");
  // stacked firebase services
  final FirebaseAuthenticationService? _firebaseAuthenticationService =
      locator<FirebaseAuthenticationService>();

  dynamic onDummyLoginTapped() {
    if (_flavorConfigProvider.flavor == Flavor.dev) {
      return () => saveData(AuthenticationMethod.dummy);
    } else {
      return null;
    }
  }

  @override
  Future<FirebaseAuthenticationResult> runAuthentication(
      AuthenticationMethod method) {
    if (method == AuthenticationMethod.Email) {
      log.i("Login with e-mail");
      return _firebaseAuthenticationService!
          .loginWithEmail(email: emailValue!, password: passwordValue!);
    } else if (method == AuthenticationMethod.google) {
      log.i("Login with google");
      return _firebaseAuthenticationService!.signInWithGoogle();
      // } else if (method == AuthenticationMethod.apple) {
      //   log.i("Login with apple");
      //   return _firebaseAuthenticationService!.signInWithApple();
    } else if (method == AuthenticationMethod.dummy) {
      log.i("Login with test account");
      return _firebaseAuthenticationService!.loginWithEmail(
          email: _flavorConfigProvider.testUserEmail,
          password: _flavorConfigProvider.testUserPassword);
    } else {
      log.e(
          "The authentication method you tried to use is not implemented yet. Use E-mail, Google, or Apple to authenticate");
      return Future.value(FirebaseAuthenticationResult.error(
          errorMessage:
              "Authentification method you try to use is not available."));
    }
  }

  void navigateToCreateAccount() {
    navigationService!.navigateTo(Routes.createAccountView);
  }

  bool isPwShown = false;
  setIsPwShown(bool show) {
    isPwShown = show;
    notifyListeners();
  }
}
