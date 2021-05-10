// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserStatistics _$_$_UserStatisticsFromJson(Map<String, dynamic> json) {
  return _$_UserStatistics(
    currentBalance: json['currentBalance'] as num,
    moneyTransferStatistics: MoneyTransferStatistics.fromJson(
        json['moneyTransferStatistics'] as Map<String, dynamic>),
    donationStatistics: DonationStatistics.fromJson(
        json['donationStatistics'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_UserStatisticsToJson(_$_UserStatistics instance) =>
    <String, dynamic>{
      'currentBalance': instance.currentBalance,
      'moneyTransferStatistics': instance.moneyTransferStatistics.toJson(),
      'donationStatistics': instance.donationStatistics.toJson(),
    };
