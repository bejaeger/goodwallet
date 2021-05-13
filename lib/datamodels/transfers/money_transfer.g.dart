// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'money_transfer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Peer2PeerTransfer _$_$Peer2PeerTransferFromJson(Map<String, dynamic> json) {
  return _$Peer2PeerTransfer(
    transferDetails: TransferDetails.fromJson(
        json['transferDetails'] as Map<String, dynamic>),
    createdAt: json['createdAt'],
    status: _$enumDecodeNullable(_$TransferStatusEnumMap, json['status']) ??
        TransferStatus.Initialized,
    type: _$enumDecodeNullable(_$TransferTypeEnumMap, json['type']) ??
        TransferType.Peer2Peer,
    transferId: json['transferId'] as String,
  );
}

Map<String, dynamic> _$_$Peer2PeerTransferToJson(
        _$Peer2PeerTransfer instance) =>
    <String, dynamic>{
      'transferDetails': instance.transferDetails.toJson(),
      'createdAt': instance.createdAt,
      'status': _$TransferStatusEnumMap[instance.status],
      'type': _$TransferTypeEnumMap[instance.type],
      'transferId': MoneyTransfer._checkIftransferIdIsSet(instance.transferId),
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

_$Donation _$_$DonationFromJson(Map<String, dynamic> json) {
  return _$Donation(
    transferDetails: TransferDetails.fromJson(
        json['transferDetails'] as Map<String, dynamic>),
    projectInfo: ConciseProjectInfo.fromJson(
        json['projectInfo'] as Map<String, dynamic>),
    createdAt: json['createdAt'],
    status: _$enumDecodeNullable(_$TransferStatusEnumMap, json['status']) ??
        TransferStatus.Initialized,
    type: _$enumDecodeNullable(_$TransferTypeEnumMap, json['type']) ??
        TransferType.Donation,
    transferId: json['transferId'] as String,
  );
}

Map<String, dynamic> _$_$DonationToJson(_$Donation instance) =>
    <String, dynamic>{
      'transferDetails': instance.transferDetails.toJson(),
      'projectInfo': instance.projectInfo.toJson(),
      'createdAt': instance.createdAt,
      'status': _$TransferStatusEnumMap[instance.status],
      'type': _$TransferTypeEnumMap[instance.type],
      'transferId': MoneyTransfer._checkIftransferIdIsSet(instance.transferId),
    };

_$MoneyPoolContribution _$_$MoneyPoolContributionFromJson(
    Map<String, dynamic> json) {
  return _$MoneyPoolContribution(
    transferDetails: TransferDetails.fromJson(
        json['transferDetails'] as Map<String, dynamic>),
    moneyPoolInfo: ConciseMoneyPoolInfo.fromJson(
        json['moneyPoolInfo'] as Map<String, dynamic>),
    createdAt: json['createdAt'],
    status: _$enumDecodeNullable(_$TransferStatusEnumMap, json['status']) ??
        TransferStatus.Initialized,
    type: _$enumDecodeNullable(_$TransferTypeEnumMap, json['type']) ??
        TransferType.MoneyPoolContribution,
    transferId: json['transferId'] as String,
  );
}

Map<String, dynamic> _$_$MoneyPoolContributionToJson(
        _$MoneyPoolContribution instance) =>
    <String, dynamic>{
      'transferDetails': instance.transferDetails.toJson(),
      'moneyPoolInfo': instance.moneyPoolInfo.toJson(),
      'createdAt': instance.createdAt,
      'status': _$TransferStatusEnumMap[instance.status],
      'type': _$TransferTypeEnumMap[instance.type],
      'transferId': MoneyTransfer._checkIftransferIdIsSet(instance.transferId),
    };

_$MoneyPoolPayoutTransfer _$_$MoneyPoolPayoutTransferFromJson(
    Map<String, dynamic> json) {
  return _$MoneyPoolPayoutTransfer(
    transferDetails: TransferDetails.fromJson(
        json['transferDetails'] as Map<String, dynamic>),
    moneyPoolInfo: ConciseMoneyPoolInfo.fromJson(
        json['moneyPoolInfo'] as Map<String, dynamic>),
    payoutId: json['payoutId'] as String,
    createdAt: json['createdAt'],
    status: _$enumDecodeNullable(_$TransferStatusEnumMap, json['status']) ??
        TransferStatus.Initialized,
    type: _$enumDecodeNullable(_$TransferTypeEnumMap, json['type']) ??
        TransferType.MoneyPoolPayoutTransfer,
    transferId: json['transferId'] as String,
  );
}

Map<String, dynamic> _$_$MoneyPoolPayoutTransferToJson(
        _$MoneyPoolPayoutTransfer instance) =>
    <String, dynamic>{
      'transferDetails': instance.transferDetails.toJson(),
      'moneyPoolInfo': instance.moneyPoolInfo.toJson(),
      'payoutId': instance.payoutId,
      'createdAt': instance.createdAt,
      'status': _$TransferStatusEnumMap[instance.status],
      'type': _$TransferTypeEnumMap[instance.type],
      'transferId': MoneyTransfer._checkIftransferIdIsSet(instance.transferId),
    };
