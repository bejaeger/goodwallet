import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/enums/authentication_method.dart';
import 'package:good_wallet/services/authentification/authentification_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

abstract class AuthenticationViewModel extends FormViewModel {
  final navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final String successRoute;
  AuthenticationViewModel({@required this.successRoute});

  @override
  void setFormStatus() {}

  Future saveData(AuthenticationMethod method) async {
    // Run the authentication and set viewmodel to busy
    final FirebaseAuthenticationResult result =
        await runBusyFuture(runAuthentication(method));

    // Check result
    if (!result.hasError) {
      // initialize user data here?
      // Get User
      await runBusyFuture(initializeUser(result.uid));

      // add error handling

      // if success:

      // Navigate to successful route
      navigationService.replaceWith(successRoute);

      // if failure:
      // setValidationMessage(result.errorMessage);

    } else {
      // set validation message if we have an error
      setValidationMessage(result.errorMessage);
    }
  }

  Future initializeUser(String uid) async {
    await _authenticationService.initializeCurrentUser(uid);
  }

  // needs to be overrriden!
  Future<FirebaseAuthenticationResult> runAuthentication(
      AuthenticationMethod method);
}
