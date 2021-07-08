import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/user/user.dart';
import 'package:good_wallet/services/user/user_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';

class FriendsViewModel extends BaseModel {
  final UserService? _userService = locator<UserService>();
  final NavigationService? _navigationService = locator<NavigationService>();
  final SnackbarService? _snackbarService = locator<SnackbarService>();

  List<User> friends = [];
  final log = getLogger("friends_viewmodel.dart");

  Future fetchFriends() async {
    setBusy(true);
    friends = await _userService!.fetchFriends();
    log.i("Found ${friends.length} friends!");
    setBusy(false);
  }

  Future onSelected(Map<String, dynamic> map) async {
    if (map.containsKey("uid")) {
      setBusy(true);
      await _userService!.addOrRemoveFriend(uid: map["uid"]);
      log.i("Removed friend");
      await fetchFriends();
      _snackbarService!.showSnackbar(
          title: "Removed friend.",
          message: "",
          duration: Duration(seconds: 1));
      setBusy(false);
    }
  }

  Future navigateToPublicProfileView(String uid) async {
    bool result = await _navigationService!.navigateTo(
        Routes.publicProfileViewMobile,
        arguments: PublicProfileViewMobileArguments(uid: uid));
    if (result == false) {
      _snackbarService!.showSnackbar(message: "User could not be found");
    }
  }

  // Search View needs to be made more flexible!
  void navigateToSearchView() {
    _navigationService!.navigateTo(Routes.searchView);
  }
}
