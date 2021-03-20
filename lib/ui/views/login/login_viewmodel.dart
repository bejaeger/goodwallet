import 'package:flutter/material.dart';
import 'package:good_wallet/app/locator.dart';
import 'package:good_wallet/app/router.gr.dart';
import 'package:good_wallet/enums/auth_mode.dart';
import 'package:good_wallet/services/authentification/authentification_service.dart';
import 'package:good_wallet/ui/views/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LoginViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

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

  bool _isPwShown = false;
  bool get isPwShown => _isPwShown;
  setIsPwShown(bool isPwShown) {
    _isPwShown = isPwShown;
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
    await loginWithEmail("test@gmail.com", "m1m1m1");
    navigateToWalletView();
    // else {
    //   _errorMessage = 'Login failed';
    //   notifyListeners();
    // }
  }
}
