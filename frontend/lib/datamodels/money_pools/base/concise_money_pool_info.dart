import 'package:freezed_annotation/freezed_annotation.dart';

part 'concise_money_pool_info.freezed.dart';
part 'concise_money_pool_info.g.dart';

@freezed
class ConciseMoneyPoolInfo with _$ConciseMoneyPoolInfo {
  factory ConciseMoneyPoolInfo({
    required num total,
    required String name,
    required String moneyPoolId,
  }) = _MoneyPoolPreviewInfo;

  factory ConciseMoneyPoolInfo.fromJson(Map<String, dynamic> json) =>
      _$ConciseMoneyPoolInfoFromJson(json);
}
