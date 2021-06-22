import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/user/user_settings.dart';
import 'package:good_wallet/services/user/user_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:good_wallet/utils/logger.dart';

class SettingsViewModel extends BaseModel {
  final UserService? _userService = locator<UserService>();

  final log = getLogger("settings_viewmodel.dart");

  Future updateUserSettingsShowStats(bool newValue) async {
    log.i(
        "Changing user settings for showing detailed statistics to $newValue");
    final UserSettings newUserSettings =
        currentUser.userSettings.copyWith(showDetailedStatistics: newValue);
    await _userService!.updateUserSettings(userSettings: newUserSettings);
    notifyListeners();
  }
}
