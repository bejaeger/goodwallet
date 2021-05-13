// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipient_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserRecipientInfo _$_$UserRecipientInfoFromJson(Map<String, dynamic> json) {
  return _$UserRecipientInfo(
    name: json['name'] as String,
    id: json['id'] as String,
    email: json['email'] as String?,
  );
}

Map<String, dynamic> _$_$UserRecipientInfoToJson(
        _$UserRecipientInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'email': instance.email,
    };

_$MoneyPoolRecipientInfo _$_$MoneyPoolRecipientInfoFromJson(
    Map<String, dynamic> json) {
  return _$MoneyPoolRecipientInfo(
    name: json['name'] as String,
    id: json['id'] as String,
    moneyPoolInfo: ConciseMoneyPoolInfo.fromJson(
        json['moneyPoolInfo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$MoneyPoolRecipientInfoToJson(
        _$MoneyPoolRecipientInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'moneyPoolInfo': instance.moneyPoolInfo.toJson(),
    };

_$DonationRecipientInfo _$_$DonationRecipientInfoFromJson(
    Map<String, dynamic> json) {
  return _$DonationRecipientInfo(
    name: json['name'] as String,
    id: json['id'] as String,
    projectInfo: ConciseProjectInfo.fromJson(
        json['projectInfo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$DonationRecipientInfoToJson(
        _$DonationRecipientInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'projectInfo': instance.projectInfo.toJson(),
    };
