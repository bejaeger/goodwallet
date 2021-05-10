// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donation_statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DonationStatistics _$_$_DonationStatisticsFromJson(
    Map<String, dynamic> json) {
  return _$_DonationStatistics(
    totalDonations: json['totalDonations'] as num,
    supportedProjects: (json['supportedProjects'] as List<dynamic>)
        .map((e) => ConciseProjectInfo.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$_$_DonationStatisticsToJson(
        _$_DonationStatistics instance) =>
    <String, dynamic>{
      'totalDonations': instance.totalDonations,
      'supportedProjects':
          instance.supportedProjects.map((e) => e.toJson()).toList(),
    };
