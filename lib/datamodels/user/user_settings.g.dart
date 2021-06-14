// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserSettings _$_$_UserSettingsFromJson(Map<String, dynamic> json) {
  return _$_UserSettings(
    favoriteProjectIds: (json['favoriteProjectIds'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    showEmail: json['showEmail'] as bool? ?? true,
    showSummaryStatistics: json['showSummaryStatistics'] as bool? ?? true,
    showDetailedStatistics: json['showDetailedStatistics'] as bool? ?? false,
  );
}

Map<String, dynamic> _$_$_UserSettingsToJson(_$_UserSettings instance) =>
    <String, dynamic>{
      'favoriteProjectIds': instance.favoriteProjectIds,
      'showEmail': instance.showEmail,
      'showSummaryStatistics': instance.showSummaryStatistics,
      'showDetailedStatistics': instance.showDetailedStatistics,
    };
