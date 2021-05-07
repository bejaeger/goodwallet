import 'package:freezed_annotation/freezed_annotation.dart';

part 'money_pool_preview_info.freezed.dart';
part 'money_pool_preview_info.g.dart';

@freezed
class MoneyPoolPreviewInfo with _$MoneyPoolPreviewInfo {
  factory MoneyPoolPreviewInfo({
    required String total,
    required String name,
    required String moneyPoolId,
  }) = _MoneyPoolPreviewInfo;

  factory MoneyPoolPreviewInfo.fromJson(Map<String, dynamic> json) =>
      _$MoneyPoolPreviewInfoFromJson(json);
}
