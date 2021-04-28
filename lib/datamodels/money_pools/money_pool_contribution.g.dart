// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'money_pool_contribution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MoneyPoolContributionModel _$_$_MoneyPoolContributionModelFromJson(
    Map<String, dynamic> json) {
  return _$_MoneyPoolContributionModel(
    moneyPoolId: json['moneyPoolId'] as String,
    moneyPoolName: json['moneyPoolName'] as String,
    uid: json['uid'] as String,
    userName: json['userName'] as String,
    amount: json['amount'] as num,
    currency: json['currency'] as String,
    message: json['message'] as String?,
    createdAt: json['createdAt'],
    status: json['status'] as String,
    transactionId: json['transactionId'] as String?,
  );
}

Map<String, dynamic> _$_$_MoneyPoolContributionModelToJson(
        _$_MoneyPoolContributionModel instance) =>
    <String, dynamic>{
      'moneyPoolId': instance.moneyPoolId,
      'moneyPoolName': instance.moneyPoolName,
      'uid': instance.uid,
      'userName': instance.userName,
      'amount': instance.amount,
      'currency': instance.currency,
      'message': instance.message,
      'createdAt': instance.createdAt,
      'status': instance.status,
      'transactionId': instance.transactionId,
    };
