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
  );
}

Map<String, dynamic> _$_$_MoneyTransferStatisticsToJson(
        _$_MoneyTransferStatistics instance) =>
    <String, dynamic>{
      'totalSentToPeers': instance.totalSentToPeers,
      'totalRaised': instance.totalRaised,
    };

_$_EmptyMoneyTransferStatistics _$_$_EmptyMoneyTransferStatisticsFromJson(
    Map<String, dynamic> json) {
  return _$_EmptyMoneyTransferStatistics(
    totalSentToPeers: json['totalSentToPeers'] as num? ?? 0,
    totalRaised: json['totalRaised'] as num? ?? 0,
  );
}

Map<String, dynamic> _$_$_EmptyMoneyTransferStatisticsToJson(
        _$_EmptyMoneyTransferStatistics instance) =>
    <String, dynamic>{
      'totalSentToPeers': instance.totalSentToPeers,
      'totalRaised': instance.totalRaised,
    };
