import 'dart:async';

import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/user/user.dart';
import 'package:good_wallet/datamodels/user/user_settings.dart';
import 'package:good_wallet/enums/authentication_method.dart';
import 'package:good_wallet/exceptions/firestore_api_exception.dart';
import 'package:good_wallet/services/user/user_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/authentication_viewmodel.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:stacked_firebase_auth/src/firebase_authentication_service.dart';
import 'package:good_wallet/ui/views/login/create_account_view.form.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;

class CreateAccountViewModel extends AuthenticationViewModel {
  CreateAccountViewModel()
      : super(successRoute: Routes.layoutTemplateViewMobile);

  final FirebaseAuthenticationService? _firebaseAuthenticationService =
      locator<FirebaseAuthenticationService>();
  final log = getLogger("create_account_viewmodel.dart");
  final UserService? _userService = locator<UserService>();

  @override
  Future<FirebaseAuthenticationResult> runAuthentication(
      AuthenticationMethod method) async {
    if (method == AuthenticationMethod.Email) {
      FirebaseAuthenticationResult result;
      log.i("Creating account with e-mail");
      // use actual firebase auth here because stacked's version does
      // not expose the user in the result
      log.e("E-mail: $emailValue");
      result = await _firebaseAuthenticationService!
          .createAccountWithEmail(email: emailValue!, password: passwordValue!);
      if (result.hasError) {
        return result;
      } else {
        // create user in data bank
        try {
          final user = result.user!;
          await _userService!.createUser(
            user: User(
                uid: user.uid,
                fullName: fullNameValue ?? (user.displayName ?? ""),
                email: user.email ?? "",
                newUser: true,
                userSettings: UserSettings()),
          );
        } catch (e) {
          if (e is FirestoreApiException) {
            return FirebaseAuthenticationResult.error(
                errorMessage: e.prettyDetails ??
                    "Something went wrong when creating a new user in our databank. Please try again later or contact support!");
          } else {
            return FirebaseAuthenticationResult.error(
                errorMessage:
                    "Something went wrong when creating a new user in our databank. Please try again later or contact support!");
          }
        }
        return FirebaseAuthenticationResult(user: result.user);
      }
    } else {
      log.e(
          "The authentication method you tried to use is not implemented yet. Use E-mail, Google, Facebook, or Apple to authenticate");
      return FirebaseAuthenticationResult.error(
          errorMessage: "Authentication method not valid!");
    }
  }

  void navigateBack() => navigationService!.back();

  void replaceWithLoginView() =>
      navigationService!.replaceWith(Routes.loginView);
}
