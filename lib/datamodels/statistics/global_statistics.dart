import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:good_wallet/datamodels/user/statistics/supported_project_statistics.dart';

part 'global_statistics.freezed.dart';
part 'global_statistics.g.dart';

@freezed
class GlobalStatistics with _$GlobalStatistics {
  @JsonSerializable(explicitToJson: true)
  factory GlobalStatistics({
    required List<SupportedProjectStatistics> supportedProjects,
  }) = _GlobalStatistics;

  factory GlobalStatistics.fromJson(Map<String, dynamic> json) =>
      _$GlobalStatisticsFromJson(json);
}
