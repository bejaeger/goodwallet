// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supported_project_statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SupportedProjectStatistics _$_$_SupportedProjectStatisticsFromJson(
    Map<String, dynamic> json) {
  return _$_SupportedProjectStatistics(
    projectInfo: ConciseProjectInfo.fromJson(
        json['projectInfo'] as Map<String, dynamic>),
    totalDonations: json['totalDonations'] as num,
  );
}

Map<String, dynamic> _$_$_SupportedProjectStatisticsToJson(
        _$_SupportedProjectStatistics instance) =>
    <String, dynamic>{
      'projectInfo': instance.projectInfo.toJson(),
      'totalDonations': instance.totalDonations,
    };
