// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'money_pool_payout_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MoneyPoolPayoutModel _$_$_MoneyPoolPayoutModelFromJson(
    Map<String, dynamic> json) {
  return _$_MoneyPoolPayoutModel(
    moneyPool:
        MoneyPoolModel.fromJson(json['moneyPool'] as Map<String, dynamic>),
    paidOutUsers: (json['paidOutUsers'] as List<dynamic>)
        .map((e) => PaidOutUser.fromJson(e as Map<String, dynamic>))
        .toList(),
    paidOutUsersIds: (json['paidOutUsersIds'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
    payoutId: json['payoutId'] as String?,
    status: json['status'] as String?,
    keepMoneyPoolAlive: json['keepMoneyPoolAlive'] as bool?,
  );
}

Map<String, dynamic> _$_$_MoneyPoolPayoutModelToJson(
        _$_MoneyPoolPayoutModel instance) =>
    <String, dynamic>{
      'moneyPool': instance.moneyPool.toJson(),
      'paidOutUsers': instance.paidOutUsers.map((e) => e.toJson()).toList(),
      'paidOutUsersIds': instance.paidOutUsersIds,
      'payoutId': instance.payoutId,
      'status': instance.status,
      'keepMoneyPoolAlive': instance.keepMoneyPoolAlive,
    };
