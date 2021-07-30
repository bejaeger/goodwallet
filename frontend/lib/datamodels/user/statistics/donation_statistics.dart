import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:good_wallet/datamodels/user/statistics/monthly_donation.dart';
import 'package:good_wallet/datamodels/user/statistics/supported_project_statistics.dart';

part 'donation_statistics.freezed.dart';
part 'donation_statistics.g.dart';

@freezed
class DonationStatistics with _$DonationStatistics {
  @JsonSerializable(explicitToJson: true)
  factory DonationStatistics({
    required num totalDonations,
    required List<SupportedProjectStatistics> supportedProjects,
    required List<MonthlyDonation> monthlyDonations,
  }) = _DonationStatistics;

  @JsonSerializable(explicitToJson: true)
  const factory DonationStatistics.empty({
    @Default(0) num totalDonations,
    List<SupportedProjectStatistics>? supportedProjects,
    List<MonthlyDonation>? monthlyDonations,
  }) = _EmptyDonationStatistics;

  factory DonationStatistics.fromJson(Map<String, dynamic> json) =>
      _$DonationStatisticsFromJson(json);
}
