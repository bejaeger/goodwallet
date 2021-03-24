import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/enums/authentication_method.dart';
import 'package:good_wallet/services/authentification/authentification_service.dart';
import 'package:good_wallet/services/userdata/user_data_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';

abstract class AuthenticationViewModel extends FormViewModel {
  final navigationService = locator<NavigationService>();
  final UserDataService _userDataService = locator<UserDataService>();
  final String successRoute;
  AuthenticationViewModel({@required this.successRoute});
  final log = getLogger("authentication_viewmodel.dart");

  @override
  void setFormStatus() {}

  Future saveData(AuthenticationMethod method) async {
    // Run the authentication and set viewmodel to busy
    final FirebaseAuthenticationResult result =
        await runBusyFuture(runAuthentication(method));

    // Check result
    if (!result.hasError) {
      log.i("Authentication successful, now initializing user data");
      // initialize user
      final UserDataServiceResult result2 =
          await runBusyFuture(initializeUser(result.uid));
      if (!result2.hasError) {
        navigationService.replaceWith(successRoute);
      } else {
        log.e("Failed initializing user with error: ${result2.errorMessage}");
        setValidationMessage(
            "Authentication successful but initiliazation failed due to an internal problem. Please, try again later or contact our support.");
      }
      navigationService.replaceWith(successRoute);
    } else {
      log.w("User could not be logged in, error thrown:");
      log.w(result.errorMessage);

      // set validation message if we have an error
      setValidationMessage(result.errorMessage);
    }
  }

  Future<UserDataServiceResult> initializeUser(String uid) async {
    return await _userDataService.initializeCurrentUser(uid);
  }

  // needs to be overrriden!
  Future<FirebaseAuthenticationResult> runAuthentication(
      AuthenticationMethod method);
}
