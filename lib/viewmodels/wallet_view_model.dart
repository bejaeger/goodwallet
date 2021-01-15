import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:good_wallet/app/locator.dart';
import 'package:good_wallet/app/router.gr.dart';
import 'package:good_wallet/services/authentification/authentification_service.dart';
import 'package:good_wallet/services/userdata/wallet_client_service.dart';
import 'package:good_wallet/viewmodels/base_model.dart';
import 'package:stacked_services/stacked_services.dart';

class WalletViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final UserWalletService _userWalletService = locator<UserWalletService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future navigateToTransferView() async {
    await _navigationService.navigateTo(Routes.sendMoneyView);
  }

  Future updateBalances() async {
    _userWalletService.updateBalancesLocal(currentUser.id);
    super.notifyListeners();
  }

  Future loginWithGoogle() async {
    setBusy(true);
    final result = await _authenticationService.loginWithGoogle();
    if (result) {
      print("INFO: User succesfully logged in!");
    } else {
      print("INFO: Failed logging in user!");
    }
    setBusy(false);
  }
}
