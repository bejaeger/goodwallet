import 'package:flutter/material.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/enums/auth_mode.dart';
import 'package:good_wallet/enums/authentication_method.dart';
import 'package:good_wallet/services/authentification/authentification_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/authentication_viewmodel.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:good_wallet/ui/views/login/login_view.form.dart';

class LoginViewModel extends AuthenticationViewModel {
  LoginViewModel()
      : super(
            successRoute:
                kIsWeb ? Routes.walletView : Routes.layoutTemplateViewMobile);

  final NavigationService _navigationService = locator<NavigationService>();
  final log = getLogger("login_viewmodel.dart");
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  // stacked firebase services
  final FirebaseAuthenticationService _firebaseAuthenticationService =
      locator<FirebaseAuthenticationService>();

  @override
  Future<FirebaseAuthenticationResult> runAuthentication(
      AuthenticationMethod method) {
    if (method == AuthenticationMethod.email) {
      log.i("Login with e-mail");
      return _firebaseAuthenticationService.loginWithEmail(
          email: emailValue, password: passwordValue);
    } else if (method == AuthenticationMethod.google) {
      log.i("Login with google");
      return _firebaseAuthenticationService.signInWithGoogle();
    } else if (method == AuthenticationMethod.facebook) {
      log.i("Login with facebook");
      return _firebaseAuthenticationService.signInWithFacebook();
    } else if (method == AuthenticationMethod.apple) {
      log.i("Login with apple");
      return _firebaseAuthenticationService.signInWithApple();
    } else if (method == AuthenticationMethod.dummy) {
      log.i("Login with dummy account");
      return _firebaseAuthenticationService.loginWithEmail(
          email: "test@gmail.com", password: "m1m1m1");
    } else {
      log.e(
          "The authentication method you tried to use is not implemented yet. Use E-mail, Google, Facebook, or Apple to authenticate");
      return null;
    }
  }

  void navigateToCreateAccount() {
    navigationService.navigateTo(Routes.createAccountView);
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

  Future<void> submit() async {
    if (!_formKey.currentState.validate()) {
      print('Form data invalid!');
      return;
    }
    _formKey.currentState.save();
    setBusy(true);
    try {
      if (_authMode == AuthMode.Login) {
        await loginWithEmail(_authData['email'], _authData['password']);
      } else {
        await signUpWithEmail(
            _authData['email'], _authData['password'], _authData['name']);
      }
      if (_authData['email'] == null || _authData['password'] == null) {
        throw ("EMPTY_ERROR: Please enter e-mail and password");
      }
      if (_authenticationService.currentUser != null) {
        setBusy(false);
        await navigateToWalletView();
      }
    } catch (error) {
      _errorMessage = 'Authentication failed.';
      if (error.toString().contains('EMAIL_EXISTS')) {
        _errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        _errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        _errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        _errorMessage = 'The email is not found';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        _errorMessage = 'Invalid password';
      } else if (error.toString().contains('EMPTY_ERROR')) {
        _errorMessage = error.toString();
      } else
        _errorMessage = 'Couldnt authenticate. Please try again later.';
    }
    setBusy(false);
    notifyListeners();
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

  void switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setAuthMode(AuthMode.Signup);
    } else {
      setAuthMode(AuthMode.Login);
    }
    notifyListeners();
  }

  Future loginWithEmail(String email, String password) async {
    final result = await _authenticationService.loginWithEmail(
        email: email, password: password);
    // // This uses the stacked service
    // final result = await _firebaseAuthenticationService.loginWithEmail(
    //     email: email, password: password);
    if (!result is String) {
      // Navigate to successful route
      print("Successfully logged in!");
      return true;
      //navigateToWalletView();
    } else {
      print("Error when trying to login!");
      print(result);
      return false;
    }
  }

  Future signUpWithEmail(String email, String password, String name) async {
    final result = await _authenticationService.signUpWithEmail(
        email: email, password: password, fullName: name);
    if (!result is String) {
      // Navigate to successful route
      print("Successfully signed-up!");
      // navigateToWalletView();
    } else {
      print(result);
    }
  }

  Future navigateToWalletView() async {
    //setShowNavigationBar(true);
    if (kIsWeb)
      await _navigationService.navigateTo(Routes.walletView);
    else
      await _navigationService.navigateTo(Routes.layoutTemplateViewMobile);
  }

  Future loginWithGoogle() async {
    setBusy(true);
    var result = await _authenticationService.loginWithGoogle();
    if (!result) print("WARNING: Failed logging in user!");
    setBusy(false);
    navigateToWalletView();
  }

  Future dummyLoginHans() async {
    log.i("Trying to log in hans with e-mail: test\@gmail.com and pw: m1m1m1");
    await loginWithEmail("test@gmail.com", "m1m1m1");
    navigateToWalletView();
  }
}
