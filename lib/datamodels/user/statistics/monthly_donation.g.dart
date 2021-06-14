// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_donation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MonthlyDonation _$_$_MonthlyDonationFromJson(Map<String, dynamic> json) {
  return _$_MonthlyDonation(
    month: DateTime.parse(json['month'] as String),
    totalDonations: json['totalDonations'] as num,
  );
}

Map<String, dynamic> _$_$_MonthlyDonationToJson(_$_MonthlyDonation instance) =>
    <String, dynamic>{
      'month': instance.month.toIso8601String(),
      'totalDonations': instance.totalDonations,
    };
