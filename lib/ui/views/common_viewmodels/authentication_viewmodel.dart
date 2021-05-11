import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/enums/authentication_method.dart';
import 'package:good_wallet/exceptions/firestore_api_exception.dart';
import 'package:good_wallet/exceptions/user_data_service_exception.dart';
import 'package:good_wallet/services/userdata/user_data_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';

abstract class AuthenticationViewModel extends FormViewModel {
  final NavigationService? navigationService = locator<NavigationService>();
  final UserDataService? _userDataService = locator<UserDataService>();
  final String successRoute;
  AuthenticationViewModel({required this.successRoute});
  final log = getLogger("authentication_viewmodel.dart");

  @override
  void setFormStatus() {}

  Future saveData(AuthenticationMethod method) async {
    // Run the authentication and set viewmodel to busy
    final FirebaseAuthenticationResult result =
        await (runBusyFuture(runAuthentication(method)));

    if (!result.hasError) {
      log.i("Authentication successful, now initializing user data");

      try {
        await (runBusyFuture(initializeUser(result.user!)));
      } catch (e) {
        log.e("Failed initializing user with error: ${e.toString()}");
        String publicFacingMessage =
            "Authentication successful but initiliazation failed due to an internal problem. Please, try again later or contact our support.";
        if (e is UserDataServiceException)
          setValidationMessage(e.prettyDetails ?? publicFacingMessage);
        if (e is FirestoreApiException)
          setValidationMessage(e.prettyDetails ?? publicFacingMessage);
        else
          setValidationMessage(publicFacingMessage);
        return;
      }

      // authenticated and initialized -> go to successRoute
      navigationService!.replaceWith(successRoute);
    } else {
      log.e(
          "User could not be logged in or signed-up, error: ${result.errorMessage}");
      // set validation message if we have an error
      setValidationMessage(result.errorMessage);
    }
  }

  Future initializeUser(User user) async {
    return await _userDataService!.initializeCurrentUser(user);
  }

  // needs to be overrriden!
  Future<FirebaseAuthenticationResult> runAuthentication(
      AuthenticationMethod method);
}
