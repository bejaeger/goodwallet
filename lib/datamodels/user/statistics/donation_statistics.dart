import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:good_wallet/datamodels/causes/concise_info/concise_project_info.dart';

part 'donation_statistics.freezed.dart';
part 'donation_statistics.g.dart';

@freezed
class DonationStatistics with _$DonationStatistics {
  @JsonSerializable(explicitToJson: true)
  factory DonationStatistics({
    required num totalDonations,
    required List<ConciseProjectInfo> supportedProjects,
  }) = _DonationStatistics;

  factory DonationStatistics.fromJson(Map<String, dynamic> json) =>
      _$DonationStatisticsFromJson(json);
}
