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
    required num prepaidFundBalance,
    required MoneyTransferStatistics moneyTransferStatistics,
    required DonationStatistics donationStatistics,
  }) = _UserStatistics;

  factory UserStatistics.fromJson(Map<String, dynamic> json) =>
      _$UserStatisticsFromJson(json);
}

// Unfortunately json serializable only supports literals as default
// We simply create a top-level function to get an empty a user statistics
// model that is empty. This is used for creating the initial documents in firestore
UserStatistics getEmptyUserStatistics() {
  return UserStatistics(
      currentBalance: 0,
      prepaidFundBalance: 0,
      moneyTransferStatistics: MoneyTransferStatistics(
          totalRaised: 0,
          totalSentToPeers: 0,
          totalRaisedViaMoneyPool: 0,
          totalRaisedViaPeer2Peer: 0,
          totalRaisedViaSubsidiaryApp: 0),
      donationStatistics: DonationStatistics(
          supportedProjects: [], totalDonations: 0, monthlyDonations: []));
}
