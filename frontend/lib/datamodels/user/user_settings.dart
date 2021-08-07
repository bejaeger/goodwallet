import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_settings.freezed.dart';
part 'user_settings.g.dart';

@freezed
class UserSettings with _$UserSettings {
  factory UserSettings({
    List<String>? favoriteProjectIds,
    List<String>? friendsIds,
    @Default(true) bool showEmail,
    @Default(true) bool showSummaryStatistics,
    @Default(true) bool showDetailedStatistics,
  }) = _UserSettings;

  factory UserSettings.fromJson(Map<String, dynamic> json) =>
      _$UserSettingsFromJson(json);
}
