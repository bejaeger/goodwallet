import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:good_wallet/enums/money_source.dart';

part 'transaction_details.freezed.dart';
part 'transaction_details.g.dart';

@freezed
class TransactionDetails with _$TransactionDetails {
  const factory TransactionDetails({
    required String recipientId,
    required String recipientName,
    required String senderId,
    required String senderName,
    required num amount,
    required String currency,
    required MoneySource sourceType,
  }) = _TransactionDetails;

  factory TransactionDetails.fromJson(Map<String, dynamic> json) =>
      _$TransactionDetailsFromJson(json);
}
