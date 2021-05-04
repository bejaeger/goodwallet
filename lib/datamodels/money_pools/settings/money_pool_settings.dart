import 'package:freezed_annotation/freezed_annotation.dart';

part 'money_pool_settings.freezed.dart';
part 'money_pool_settings.g.dart';

@freezed
class MoneyPoolSettings with _$MoneyPoolSettings {
  factory MoneyPoolSettings({
    required String showTotal,
  }) = _MoneyPoolSettings;

  factory MoneyPoolSettings.fromJson(Map<String, dynamic> json) =>
      _$MoneyPoolSettingsFromJson(json);
}
