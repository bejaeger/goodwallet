import 'package:good_wallet/app/locator.dart';
import 'package:good_wallet/app/router.gr.dart';
import 'package:good_wallet/enums/auth_mode.dart';
import 'package:good_wallet/services/authentification/authentification_service.dart';
import 'package:good_wallet/viewmodels/base_model.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  AuthMode _authMode = AuthMode.Login;
  AuthMode get authMode => _authMode;
  setAuthMode(AuthMode authMode) {
    _authMode = authMode;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  setIsLoading(bool isLoading) {
    _isLoading = isLoading;
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
    await _authenticationService.loginWithEmail(
        email: email, password: password);
  }

  Future signUpWithEmail(String email, String password,
      [String fullName]) async {
    await _authenticationService.signUpWithEmail(
        email: email, password: password, fullName: "NewName");
  }

  Future navigateToWalletView() async {
    setShowNavigationBar(true);
    await _navigationService.navigateTo(Routes.walletView);
  }
}
