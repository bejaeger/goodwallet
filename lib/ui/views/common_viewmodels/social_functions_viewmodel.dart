import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/services/user/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';

class SocialFunctionsViewModel extends BaseViewModel {
  final UserService? _userService = locator<UserService>();
  final SnackbarService? _snackbarService = locator<SnackbarService>();

  final log = getLogger("social_functions_viewmodel.dart");

  bool isFriend(String uid) {
    return _userService!.isFriend(uid: uid);
  }

  Future addOrRemoveFriend(String uid) async {
    try {
      bool add = await _userService!.addOrRemoveFriend(uid: uid);
      notifyListeners();
      if (add) {
        _snackbarService!.showSnackbar(
            title: "Added friend.",
            message: "",
            duration: Duration(seconds: 1));
      } else {
        _snackbarService!.showSnackbar(
            title: "Removed friend.",
            message: "",
            duration: Duration(seconds: 1));
      }
    } catch (e) {
      log.wtf("Could not add or remove friend due to error $e");
      rethrow;
    }
  }
}
