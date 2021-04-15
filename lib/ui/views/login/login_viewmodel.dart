import 'dart:async';

import 'package:flutter/material.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/enums/auth_mode.dart';
import 'package:good_wallet/enums/authentication_method.dart';
import 'package:good_wallet/ui/views/common_viewmodels/authentication_viewmodel.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:good_wallet/ui/views/login/login_view.form.dart';

class LoginViewModel extends AuthenticationViewModel {
  LoginViewModel() : super(successRoute: Routes.layoutTemplateViewMobile);
  //    kIsWeb ? Routes.walletView : Routes.layoutTemplateViewMobile);

  final NavigationService? _navigationService = locator<NavigationService>();
  final log = getLogger("login_viewmodel.dart");
  // stacked firebase services
  final FirebaseAuthenticationService? _firebaseAuthenticationService =
      locator<FirebaseAuthenticationService>();

  @override
  Future<FirebaseAuthenticationResult> runAuthentication(
      AuthenticationMethod method) {
    if (method == AuthenticationMethod.email) {
      log.i("Login with e-mail");
      return _firebaseAuthenticationService!
          .loginWithEmail(email: emailValue!, password: passwordValue!);
    } else if (method == AuthenticationMethod.google) {
      log.i("Login with google");
      return _firebaseAuthenticationService!.signInWithGoogle();
    } else if (method == AuthenticationMethod.dummy) {
      log.i("Login with dummy account");
      return _firebaseAuthenticationService!
          .loginWithEmail(email: "test@gmail.com", password: "m1m1m1");
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

  // ---------------------------------------
  // To be visited, mostly deprecated code follows

  final GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<FormState> get formKey => _formKey;

  final Map<String, String> _authData = {
    'email': '',
    'password': '',
    'name': '',
  };
  Map<String, String> get authData => _authData;

  void setName(String name) {
    _authData["name"] = name;
  }

  void setPassword(String password) {
    _authData["password"] = password;
  }

  void setEmail(String email) {
    _authData["email"] = email;
  }

  AuthMode _authMode = AuthMode.Login;
  AuthMode get authMode => _authMode;
  setAuthMode(AuthMode authMode) {
    _authMode = authMode;
    notifyListeners();
  }

  bool _hasError = false;
  bool get hasError => _hasError;
  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  void setErrorMessage(bool hasError, String error) {
    _hasError = hasError;
    _errorMessage = error;
    notifyListeners();
  }
}
