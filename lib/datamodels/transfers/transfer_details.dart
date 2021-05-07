import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:good_wallet/enums/money_source.dart';

part 'transfer_details.freezed.dart';
part 'transfer_details.g.dart';

@freezed
class TransferDetails with _$TransferDetails {
  const factory TransferDetails({
    required String recipientId,
    required String recipientName,
    required String senderId,
    required String senderName,
    required num amount,
    required String currency,
    required MoneySource sourceType,
  }) = _TransferDetails;

  factory TransferDetails.fromJson(Map<String, dynamic> json) =>
      _$TransferDetailsFromJson(json);
}
