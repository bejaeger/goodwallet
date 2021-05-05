// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paid_out_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PaidOutUser _$_$_PaidOutUserFromJson(Map<String, dynamic> json) {
  return _$_PaidOutUser(
    name: json['name'] as String,
    uid: json['uid'] as String,
    amount: json['amount'] as num,
  );
}

Map<String, dynamic> _$_$_PaidOutUserToJson(_$_PaidOutUser instance) =>
    <String, dynamic>{
      'name': instance.name,
      'uid': instance.uid,
      'amount': instance.amount,
    };
