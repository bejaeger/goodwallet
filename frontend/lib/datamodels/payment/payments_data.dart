import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payments_data.freezed.dart';
part 'payments_data.g.dart';

@freezed
class PaymentData with _$PaymentData {
  factory PaymentData({
    required int amount,
    required BillingDetails billingDetails,
    required String currency,
  }) = _PaymentData;

  factory PaymentData.fromJson(Map<String, dynamic> json) =>
      _$PaymentDataFromJson(json);
}
