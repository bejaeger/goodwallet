// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'money_transfer_statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MoneyTransferStatistics _$_$_MoneyTransferStatisticsFromJson(
    Map<String, dynamic> json) {
  return _$_MoneyTransferStatistics(
    totalSentToPeers: json['totalSentToPeers'] as num,
    totalRaised: json['totalRaised'] as num,
    totalRaisedViaMoneyPool: json['totalRaisedViaMoneyPool'] as num,
    totalRaisedViaPeer2Peer: json['totalRaisedViaPeer2Peer'] as num,
    totalRaisedViaSubsidiaryApp: json['totalRaisedViaSubsidiaryApp'] as num,
  );
}

Map<String, dynamic> _$_$_MoneyTransferStatisticsToJson(
        _$_MoneyTransferStatistics instance) =>
    <String, dynamic>{
      'totalSentToPeers': instance.totalSentToPeers,
      'totalRaised': instance.totalRaised,
      'totalRaisedViaMoneyPool': instance.totalRaisedViaMoneyPool,
      'totalRaisedViaPeer2Peer': instance.totalRaisedViaPeer2Peer,
      'totalRaisedViaSubsidiaryApp': instance.totalRaisedViaSubsidiaryApp,
    };

_$_EmptyMoneyTransferStatistics _$_$_EmptyMoneyTransferStatisticsFromJson(
    Map<String, dynamic> json) {
  return _$_EmptyMoneyTransferStatistics(
    totalSentToPeers: json['totalSentToPeers'] as num? ?? 0,
    totalRaised: json['totalRaised'] as num? ?? 0,
    totalRaisedViaMoneyPool: json['totalRaisedViaMoneyPool'] as num? ?? 0,
    totalRaisedViaPeer2Peer: json['totalRaisedViaPeer2Peer'] as num? ?? 0,
    totalRaisedViaSubsidiaryApp:
        json['totalRaisedViaSubsidiaryApp'] as num? ?? 0,
  );
}

Map<String, dynamic> _$_$_EmptyMoneyTransferStatisticsToJson(
        _$_EmptyMoneyTransferStatistics instance) =>
    <String, dynamic>{
      'totalSentToPeers': instance.totalSentToPeers,
      'totalRaised': instance.totalRaised,
      'totalRaisedViaMoneyPool': instance.totalRaisedViaMoneyPool,
      'totalRaisedViaPeer2Peer': instance.totalRaisedViaPeer2Peer,
      'totalRaisedViaSubsidiaryApp': instance.totalRaisedViaSubsidiaryApp,
    };
