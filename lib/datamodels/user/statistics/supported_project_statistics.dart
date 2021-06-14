import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:good_wallet/datamodels/causes/concise_info/concise_project_info.dart';

part 'supported_project_statistics.freezed.dart';
part 'supported_project_statistics.g.dart';

@freezed
class SupportedProjectStatistics with _$SupportedProjectStatistics {
  @JsonSerializable(explicitToJson: true)
  factory SupportedProjectStatistics({
    required ConciseProjectInfo projectInfo,
    required num totalDonations,
  }) = _SupportedProjectStatistics;

  factory SupportedProjectStatistics.fromJson(Map<String, dynamic> json) =>
      _$SupportedProjectStatisticsFromJson(json);
}
