// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payments_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PaymentData _$_$_PaymentDataFromJson(Map<String, dynamic> json) {
  return _$_PaymentData(
    amount: json['amount'] as int,
    billingDetails:
        BillingDetails.fromJson(json['billingDetails'] as Map<String, dynamic>),
    currency: json['currency'] as String,
  );
}

Map<String, dynamic> _$_$_PaymentDataToJson(_$_PaymentData instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'billingDetails': instance.billingDetails,
      'currency': instance.currency,
    };
