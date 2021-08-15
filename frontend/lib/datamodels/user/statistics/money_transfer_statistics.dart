import 'package:freezed_annotation/freezed_annotation.dart';

part 'money_transfer_statistics.freezed.dart';
part 'money_transfer_statistics.g.dart';

@freezed
class MoneyTransferStatistics with _$MoneyTransferStatistics {
  factory MoneyTransferStatistics({
    required num totalSentToPeers,
    @Default(0) num totalSentToMoneyPools,
    required num totalRaised,
    required num totalPledged,
    required num totalRaisedViaMoneyPool,
    required num totalRaisedViaPeer2Peer,
    required num totalRaisedViaSubsidiaryApp,
  }) = _MoneyTransferStatistics;

  const factory MoneyTransferStatistics.empty({
    @Default(0) num totalSentToPeers,
    @Default(0) num totalSentToMoneyPools,
    @Default(0) num totalRaised,
    @Default(0) num totalPledged,
    @Default(0) num totalRaisedViaMoneyPool,
    @Default(0) num totalRaisedViaPeer2Peer,
    @Default(0) num totalRaisedViaSubsidiaryApp,
  }) = _EmptyMoneyTransferStatistics;

  factory MoneyTransferStatistics.fromJson(Map<String, dynamic> json) =>
      _$MoneyTransferStatisticsFromJson(json);
}
