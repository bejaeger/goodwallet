import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:good_wallet/datamodels/user/statistics/donation_statistics.dart';
import 'package:good_wallet/datamodels/user/statistics/money_transfer_statistics.dart';

part 'user_statistics.freezed.dart';
part 'user_statistics.g.dart';

@freezed
class UserStatistics with _$UserStatistics {
  @JsonSerializable(explicitToJson: true)
  factory UserStatistics({
    required num currentBalance,
    required MoneyTransferStatistics moneyTransferStatistics,
    required DonationStatistics donationStatistics,
  }) = _UserStatistics;
  factory UserStatistics.fromJson(Map<String, dynamic> json) =>
      _$UserStatisticsFromJson(json);
}
