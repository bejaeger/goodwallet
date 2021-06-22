import 'package:good_wallet/apis/firestore_api.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/user/statistics/user_statistics.dart';
import 'package:good_wallet/datamodels/user/user.dart';
import 'package:good_wallet/enums/dialog_type.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';

class PublicProfileViewModel extends BaseModel {
  final DialogService? _dialogService = locator<DialogService>();
  final FirestoreApi _firestoreApi = locator<FirestoreApi>();
  final NavigationService? _navigationService = locator<NavigationService>();

  final log = getLogger("public_profile_viewmodel.dart");
  User? user;
  UserStatistics? otherUserStats;
  Future fetchUserData(String uid) async {
    setBusy(true);
    user = await _firestoreApi.getUser(uid: uid);
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
    setBusy(false);
  }

  ///////////////////////////////////////////////////
  /// Dialogs
  Future showStatsDialog(User user, UserStatistics userStats) async {
    await _dialogService!.showCustomDialog(
      barrierDismissible: true,
      variant: DialogType
          .Stats, // Which builder you'd like to call that was assigned in the builders function above.
      title: user.fullName + "'s Impact",
      customData: userStats,
    );
  }
}
