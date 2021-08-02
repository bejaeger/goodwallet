import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/recipient_info.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/sender_info.dart';
import 'package:good_wallet/datamodels/user/user.dart';
import 'package:good_wallet/enums/money_source.dart';
import 'package:good_wallet/enums/search_type.dart';
import 'package:good_wallet/enums/transfer_type.dart';
import 'package:good_wallet/services/user/user_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/transfer_base_model.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';

class SocialFunctionsViewModel extends TransferBaseViewModel {
  final UserService? _userService = locator<UserService>();
  final SnackbarService? _snackbarService = locator<SnackbarService>();
  final NavigationService? _navigationService = locator<NavigationService>();

  final log = getLogger("social_functions_viewmodel.dart");

  List<User> get friends => _userService!.friends;

  bool isFriend(String uid) {
    return _userService!.isFriend(uid: uid);
  }

  Future listenToFriends({List<User>? friendsPreloaded}) async {
    if (friendsPreloaded != null) {
      return;
    } else {
      setBusy(true);
      await _userService!.listenToFriends();
      setBusy(false);
    }
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

  /////////////////////////////////////////////////
  // Navigations

  Future navigateToPublicProfileView(String uid) async {
    final result = await _navigationService!.navigateTo(
        Routes.publicProfileViewMobile,
        arguments: PublicProfileViewMobileArguments(uid: uid));
    if (result == false) {
      _snackbarService!.showSnackbar(message: "User could not be found");
    }
  }

  Future navigateToTransferViewWithUser(User user) async {
    _navigationService!.navigateTo(Routes.transferFundsAmountView,
        arguments: TransferFundsAmountViewArguments(
            senderInfo: SenderInfo(moneySource: MoneySource.Bank),
            type: TransferType.User2UserSent,
            recipientInfo:
                RecipientInfo.user(name: user.fullName, id: user.uid)));
  }

  void navigateToFindFriendsView() {
    _navigationService!.navigateTo(Routes.searchView,
        arguments: SearchViewArguments(
            searchType: SearchType.FindFriends, autofocus: true));
  }

  Future navigateToFriendsView({List<User>? friends}) async {
    _navigationService!.navigateTo(Routes.friendsView,
        arguments: FriendsViewArguments(friends: friends));
  }
}
