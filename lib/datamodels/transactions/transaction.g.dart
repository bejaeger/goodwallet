// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Peer2PeerTransaction _$_$Peer2PeerTransactionFromJson(
    Map<String, dynamic> json) {
  return _$Peer2PeerTransaction(
    transactionDetails: TransactionDetails.fromJson(
        json['transactionDetails'] as Map<String, dynamic>),
    status: json['status'] as String,
    transactionId: json['transactionId'] as String,
    createdAt: json['createdAt'],
    type: _$enumDecodeNullable(_$TransactionTypeEnumMap, json['type']) ??
        TransactionType.Peer2Peer,
  );
}

Map<String, dynamic> _$_$Peer2PeerTransactionToJson(
        _$Peer2PeerTransaction instance) =>
    <String, dynamic>{
      'transactionDetails': instance.transactionDetails.toJson(),
      'status': instance.status,
      'transactionId': instance.transactionId,
      'createdAt': instance.createdAt,
      'type': _$TransactionTypeEnumMap[instance.type],
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

const _$TransactionTypeEnumMap = {
  TransactionType.Peer2Peer: 'Peer2Peer',
  TransactionType.Donation: 'Donation',
  TransactionType.MoneyPoolContribution: 'MoneyPoolContribution',
  TransactionType.MoneyPoolPayout: 'MoneyPoolPayout',
  TransactionType.PrepaidFundTopUp: 'PrepaidFundTopUp',
};

_$Donation _$_$DonationFromJson(Map<String, dynamic> json) {
  return _$Donation(
    transactionDetails: TransactionDetails.fromJson(
        json['transactionDetails'] as Map<String, dynamic>),
    status: json['status'] as String,
    transactionId: json['transactionId'] as String,
    createdAt: json['createdAt'],
    type: _$enumDecodeNullable(_$TransactionTypeEnumMap, json['type']) ??
        TransactionType.Donation,
  );
}

Map<String, dynamic> _$_$DonationToJson(_$Donation instance) =>
    <String, dynamic>{
      'transactionDetails': instance.transactionDetails.toJson(),
      'status': instance.status,
      'transactionId': instance.transactionId,
      'createdAt': instance.createdAt,
      'type': _$TransactionTypeEnumMap[instance.type],
    };

_$MoneyPoolContribution _$_$MoneyPoolContributionFromJson(
    Map<String, dynamic> json) {
  return _$MoneyPoolContribution(
    transactionDetails: TransactionDetails.fromJson(
        json['transactionDetails'] as Map<String, dynamic>),
    status: json['status'] as String,
    transactionId: json['transactionId'] as String,
    createdAt: json['createdAt'],
    type: _$enumDecodeNullable(_$TransactionTypeEnumMap, json['type']) ??
        TransactionType.MoneyPoolContribution,
  );
}

Map<String, dynamic> _$_$MoneyPoolContributionToJson(
        _$MoneyPoolContribution instance) =>
    <String, dynamic>{
      'transactionDetails': instance.transactionDetails.toJson(),
      'status': instance.status,
      'transactionId': instance.transactionId,
      'createdAt': instance.createdAt,
      'type': _$TransactionTypeEnumMap[instance.type],
    };

_$MoneyPoolPayout _$_$MoneyPoolPayoutFromJson(Map<String, dynamic> json) {
  return _$MoneyPoolPayout(
    transactionsDetails: (json['transactionsDetails'] as List<dynamic>)
        .map((e) => TransactionDetails.fromJson(e as Map<String, dynamic>))
        .toList(),
    paidOutUsersIds: (json['paidOutUsersIds'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
    moneyPool: MoneyPool.fromJson(json['moneyPool'] as Map<String, dynamic>),
    status: json['status'] as String,
    transactionId: json['transactionId'] as String,
    createdAt: json['createdAt'],
    type: _$enumDecodeNullable(_$TransactionTypeEnumMap, json['type']) ??
        TransactionType.MoneyPoolPayout,
  );
}

Map<String, dynamic> _$_$MoneyPoolPayoutToJson(_$MoneyPoolPayout instance) =>
    <String, dynamic>{
      'transactionsDetails':
          instance.transactionsDetails.map((e) => e.toJson()).toList(),
      'paidOutUsersIds': instance.paidOutUsersIds,
      'moneyPool': instance.moneyPool.toJson(),
      'status': instance.status,
      'transactionId': instance.transactionId,
      'createdAt': instance.createdAt,
      'type': _$TransactionTypeEnumMap[instance.type],
    };
