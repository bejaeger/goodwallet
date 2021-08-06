import 'package:good_wallet/apis/firestore_api.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/causes/concise_info/concise_project_info.dart';
import 'package:good_wallet/datamodels/causes/project.dart';
import 'package:good_wallet/datamodels/money_pools/base/money_pool.dart';
import 'package:good_wallet/datamodels/user/statistics/supported_project_statistics.dart';
import 'package:good_wallet/datamodels/user/statistics/user_statistics.dart';
import 'package:good_wallet/datamodels/user/user.dart';
import 'package:good_wallet/enums/dialog_type.dart';
import 'package:good_wallet/enums/search_type.dart';
import 'package:good_wallet/services/money_pools/money_pools_service.dart';
import 'package:good_wallet/services/projects/projects_service.dart';
import 'package:good_wallet/services/qrcode/qrcode_service.dart';
import 'package:good_wallet/services/user/user_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/social_functions_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';

class PublicProfileViewModel extends SocialFunctionsViewModel {
  final DialogService? _dialogService = locator<DialogService>();
  final FirestoreApi _firestoreApi = locator<FirestoreApi>();
  final NavigationService? _navigationService = locator<NavigationService>();
  final QRCodeService? _qrCodeService = locator<QRCodeService>();
  final UserService? _userService = locator<UserService>();
  final ProjectsService? _projectsService = locator<ProjectsService>();
  final MoneyPoolsService? _moneyPoolsService = locator<MoneyPoolsService>();

  final log = getLogger("public_profile_viewmodel.dart");
  User? user;
  UserStatistics? otherUserStats;
  List<MoneyPool> get moneyPools => _moneyPoolsService!.moneyPools;
  String? _uid;
  bool get isCurrentUsersProfile =>
      _uid != null ? _uid == currentUser.uid : false;

  List<Project> get favoriteProjects => _projectsService!.getProjectsWithIds(
      projectIds: currentUser.userSettings.favoriteProjectIds);

  List<SupportedProjectStatistics> get supportedProjects =>
      _userService!.getSupportedProjects();

  // Starting money pool listener. Should only ever be called once!
  Future listenAndFetchData(String uid) async {
    setBusy(true);
    await _projectsService!.listenToProjects(uid: currentUser.uid);
    await fetchUserData(uid);
    setBusy(false);
  }

  Future fetchUserData(String uid) async {
    _uid = uid;
    setBusy(true);
    if (isCurrentUsersProfile) {
      user = currentUser;
    } else {
      user = await _firestoreApi.getUser(uid: uid);
    }
    if (user == null) {
      log.wtf("User could not be found!");
      _navigationService!.back(result: false);
    }
    if (user!.userSettings.showDetailedStatistics == true) {
      otherUserStats = await _firestoreApi.getUserSummaryStatistics(uid: uid);
      if (otherUserStats == null) {
        log.wtf(
            "Something went terribly wrong, user summary stats could not be fetched!");
        _navigationService!.back(result: false);
      }
    }
    await _userService!.listenToFriends();
    setBusy(false);
  }

  ///////////////////////////////////////////////////
  /// Dialogs
  Future showStatsDialog(User user, UserStatistics userStats) async {
    await _dialogService!.showCustomDialog(
      barrierDismissible: true,
      variant: DialogType.Stats,
      title: user.fullName + "'s Impact",
      data: userStats,
    );
  }

  String getQRCodeUserInfoString(User user) {
    return _qrCodeService!.getEncodedUserInfo(user);
  }

/////////////////////////////////////
// Navigation
  void navigateToAccountView() {
    _navigationService!.navigateTo(Routes.accountView);
  }

  void navigateToQRCodeView() {
    _navigationService!.navigateTo(Routes.qRCodeViewMobile,
        arguments: QRCodeViewMobileArguments(
            initialIndex: 1, searchType: SearchType.None));
  }

  Future navigateToSingleProjectScreen(String projectId) async {
    await _navigationService!.navigateTo(Routes.singleProjectViewMobile,
        arguments: SingleProjectViewMobileArguments(projectId: projectId));
  }

  void navigateToAllMoneyPoolsView() {
    _navigationService!.navigateTo(Routes.moneyPoolsView);
  }
}
