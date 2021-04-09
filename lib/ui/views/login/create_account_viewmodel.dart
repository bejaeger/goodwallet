import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/enums/authentication_method.dart';
import 'package:good_wallet/services/userdata/user_data_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/authentication_viewmodel.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:stacked_firebase_auth/src/firebase_authentication_service.dart';
import 'package:good_wallet/ui/views/login/create_account_view.form.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class CreateAccountViewModel extends AuthenticationViewModel {
  CreateAccountViewModel()
      : super(
            successRoute:
                kIsWeb ? Routes.walletView : Routes.layoutTemplateViewMobile);

  final _firebaseAuth = FirebaseAuth.instance;
  final FirebaseAuthenticationService? _firebaseAuthenticationService =
      locator<FirebaseAuthenticationService>();
  final log = getLogger("LoginViewModel");
  final UserDataService? _userDataService = locator<UserDataService>();

  // TODO
  // Maybe we want to use stacked's version again and change the createUser function
  // to be able to retrieve the userId and fullName only?

  @override
  Future<FirebaseAuthenticationResult> runAuthentication(
      AuthenticationMethod method) async {
    if (method == AuthenticationMethod.email) {
      UserCredential result;
      //FirebaseAuthenticationResult result;
      log.i("Creating account with e-mail");
      try {
        // use actual firebase auth here because stacked's version does
        // not expose the user in the result
        log.e("E-mail: $emailValue");
        result = await _firebaseAuth.createUserWithEmailAndPassword(
            email: emailValue!, password: passwordValue!);

        //result = await _firebaseAuth.userChanges()
        // create user in databank when it is the first time!
        // Reconsider this!
        // Think about how to get User from uid!
        // TODO: This has gladly changed in the stacked firebase auth and now
        // the User is retrieved! rethink the following lines....

        UserDataServiceResult result2 =
            await (_userDataService!.createUser(result.user!, fullNameValue));
        if (result2.hasError) {
          return FirebaseAuthenticationResult.error(
              errorMessage:
                  "Something went wrong when creating a new user in our databank. Please try again later or contact support!");
        }
      } on FirebaseAuthException catch (e) {
        log.e(
            "FirebaseAuthException when creating user account: ${e.toString()}");
        return FirebaseAuthenticationResult.error(
            errorMessage: getErrorMessageFromFirebaseException(e));
      } catch (e) {
        log.e("And unknwon error accoured: ${e.toString()}");
        return FirebaseAuthenticationResult.error(
            errorMessage:
                "An unknown error accoured when creating a new user. Please try again later or contact support.");
      }
      return FirebaseAuthenticationResult(user: result.user);
    } else {
      log.e(
          "The authentication method you tried to use is not implemented yet. Use E-mail, Google, Facebook, or Apple to authenticate");
      return FirebaseAuthenticationResult.error(
          errorMessage: "Authentication method not valid!");
    }
  }

  void navigateBack() => navigationService!.back();
}
