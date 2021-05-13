// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sender_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SenderInfo _$_$_SenderInfoFromJson(Map<String, dynamic> json) {
  return _$_SenderInfo(
    name: json['name'] as String?,
    id: json['id'] as String?,
    moneySource: _$enumDecode(_$MoneySourceEnumMap, json['moneySource']),
  );
}

Map<String, dynamic> _$_$_SenderInfoToJson(_$_SenderInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'moneySource': _$MoneySourceEnumMap[instance.moneySource],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$MoneySourceEnumMap = {
  MoneySource.GoodWallet: 'GoodWallet',
  MoneySource.Bank: 'Bank',
  MoneySource.PrepaidFund: 'PrepaidFund',
  MoneySource.MoneyPool: 'MoneyPool',
};
