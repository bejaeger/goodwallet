// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'money_pool.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MoneyPool _$_$_MoneyPoolFromJson(Map<String, dynamic> json) {
  return _$_MoneyPool(
    name: json['name'] as String,
    adminUID: json['adminUID'] as String,
    adminName: json['adminName'] as String,
    total: json['total'] as num,
    currency: json['currency'] as String,
    description: json['description'] as String?,
    moneyPoolSettings: MoneyPoolSettings.fromJson(
        json['moneyPoolSettings'] as Map<String, dynamic>),
    createdAt: json['createdAt'],
    contributingUsers: (json['contributingUsers'] as List<dynamic>)
        .map((e) => ContributingUser.fromJson(e as Map<String, dynamic>))
        .toList(),
    invitedUsers: (json['invitedUsers'] as List<dynamic>)
        .map((e) => PublicUserInfo.fromJson(e as Map<String, dynamic>))
        .toList(),
    contributingUserIds: (json['contributingUserIds'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
    invitedUserIds: (json['invitedUserIds'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
    moneyPoolId: json['moneyPoolId'] as String,
  );
}

Map<String, dynamic> _$_$_MoneyPoolToJson(_$_MoneyPool instance) =>
    <String, dynamic>{
      'name': instance.name,
      'adminUID': instance.adminUID,
      'adminName': instance.adminName,
      'total': instance.total,
      'currency': instance.currency,
      'description': instance.description,
      'moneyPoolSettings': instance.moneyPoolSettings.toJson(),
      'createdAt': instance.createdAt,
      'contributingUsers':
          instance.contributingUsers.map((e) => e.toJson()).toList(),
      'invitedUsers': instance.invitedUsers.map((e) => e.toJson()).toList(),
      'contributingUserIds': instance.contributingUserIds,
      'invitedUserIds': instance.invitedUserIds,
      'moneyPoolId': MoneyPool._checkIfMoneyPoolIdIsSet(instance.moneyPoolId),
    };
