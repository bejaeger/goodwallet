// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GlobalStatistics _$_$_GlobalStatisticsFromJson(Map<String, dynamic> json) {
  return _$_GlobalStatistics(
    totalDonations: json['totalDonations'] as num,
    supportedProjects: (json['supportedProjects'] as List<dynamic>)
        .map((e) =>
            SupportedProjectStatistics.fromJson(e as Map<String, dynamic>))
        .toList(),
    projectTopPicksIds: (json['projectTopPicksIds'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
  );
}

Map<String, dynamic> _$_$_GlobalStatisticsToJson(
        _$_GlobalStatistics instance) =>
    <String, dynamic>{
      'totalDonations': instance.totalDonations,
      'supportedProjects':
          instance.supportedProjects.map((e) => e.toJson()).toList(),
      'projectTopPicksIds': instance.projectTopPicksIds,
    };
