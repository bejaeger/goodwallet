import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:good_wallet/enums/money_source.dart';

part 'sender_info.freezed.dart';
part 'sender_info.g.dart';

@freezed
class SenderInfo with _$SenderInfo {
  factory SenderInfo({
    String? name,
    String? id,
    required MoneySource moneySource,
  }) = _SenderInfo;

  factory SenderInfo.fromJson(Map<String, dynamic> json) =>
      _$SenderInfoFromJson(json);
}
