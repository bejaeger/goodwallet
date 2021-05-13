// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'money_transfer_query_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MoneyTransferQueryConfig _$_$_MoneyTransferQueryConfigFromJson(
    Map<String, dynamic> json) {
  return _$_MoneyTransferQueryConfig(
    type: _$enumDecode(_$TransferTypeEnumMap, json['type']),
    isEqualToFilter: (json['isEqualToFilter'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
    maxNumberReturns: json['maxNumberReturns'] as int?,
    makeUnique: json['makeUnique'] as bool?,
  );
}

Map<String, dynamic> _$_$_MoneyTransferQueryConfigToJson(
        _$_MoneyTransferQueryConfig instance) =>
    <String, dynamic>{
      'type': _$TransferTypeEnumMap[instance.type],
      'isEqualToFilter': instance.isEqualToFilter,
      'maxNumberReturns': instance.maxNumberReturns,
      'makeUnique': instance.makeUnique,
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

const _$TransferTypeEnumMap = {
  TransferType.Peer2Peer: 'Peer2Peer',
  TransferType.Peer2PeerSent: 'Peer2PeerSent',
  TransferType.Peer2PeerReceived: 'Peer2PeerReceived',
  TransferType.Donation: 'Donation',
  TransferType.MoneyPoolPayoutTransfer: 'MoneyPoolPayoutTransfer',
  TransferType.MoneyPoolPayout: 'MoneyPoolPayout',
  TransferType.MoneyPoolContribution: 'MoneyPoolContribution',
  TransferType.PrepaidFund: 'PrepaidFund',
  TransferType.Commitment: 'Commitment',
  TransferType.All: 'All',
  TransferType.Invalid: 'Invalid',
};
