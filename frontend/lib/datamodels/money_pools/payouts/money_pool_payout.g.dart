// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'money_pool_payout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MoneyPoolPayout _$_$_MoneyPoolPayoutFromJson(Map<String, dynamic> json) {
  return _$_MoneyPoolPayout(
    transfersDetails: (json['transfersDetails'] as List<dynamic>)
        .map((e) => TransferDetails.fromJson(e as Map<String, dynamic>))
        .toList(),
    paidOutUsersIds: (json['paidOutUsersIds'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
    moneyPool: MoneyPool.fromJson(json['moneyPool'] as Map<String, dynamic>),
    createdAt: json['createdAt'] ?? '',
    status: _$enumDecodeNullable(_$TransferStatusEnumMap, json['status']) ??
        TransferStatus.Initialized,
    payoutId: json['payoutId'] as String,
    deleteMoneyPool: json['deleteMoneyPool'] as bool? ?? true,
  );
}

Map<String, dynamic> _$_$_MoneyPoolPayoutToJson(_$_MoneyPoolPayout instance) =>
    <String, dynamic>{
      'transfersDetails':
          instance.transfersDetails.map((e) => e.toJson()).toList(),
      'paidOutUsersIds': instance.paidOutUsersIds,
      'moneyPool': instance.moneyPool.toJson(),
      'createdAt': instance.createdAt,
      'status': _$TransferStatusEnumMap[instance.status],
      'payoutId': instance.payoutId,
      'deleteMoneyPool': instance.deleteMoneyPool,
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

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$TransferStatusEnumMap = {
  TransferStatus.Initialized: 'Initialized',
  TransferStatus.Success: 'Success',
  TransferStatus.Pending: 'Pending',
};
