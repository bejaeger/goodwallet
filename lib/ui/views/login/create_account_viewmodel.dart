import 'package:good_wallet/app/locator.dart';
import 'package:good_wallet/app/router.gr.dart';
import 'package:good_wallet/enums/authentication_method.dart';
import 'package:good_wallet/ui/views/common_viewmodels/authentication_viewmodel.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:stacked_firebase_auth/src/firebase_authentication_service.dart';
import 'package:good_wallet/ui/views/login/create_account_view.form.dart';

class CreateAccountViewModel extends AuthenticationViewModel {
  CreateAccountViewModel() : super(successRoute: Routes.homeViewMobile);
  final _firebaseAuthenticationService =
      locator<FirebaseAuthenticationService>();
  final log = getLogger("LoginViewModel");

  @override
  Future<FirebaseAuthenticationResult> runAuthentication(
      AuthenticationMethod method) {
    if (method == AuthenticationMethod.email) {
      _firebaseAuthenticationService.createAccountWithEmail(
        email: emailValue,
        password: passwordValue,
      );
    } else {
      log.e(
          "The authentication method you tried to use is not implemented yet. Use E-mail, Google, Facebook, or Apple to authenticate");
      return null;
    }
  }

  void navigateBack() => navigationService.back();
}
