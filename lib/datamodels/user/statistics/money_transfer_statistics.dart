import 'package:freezed_annotation/freezed_annotation.dart';

part 'money_transfer_statistics.freezed.dart';
part 'money_transfer_statistics.g.dart';

@freezed
class MoneyTransferStatistics with _$MoneyTransferStatistics {
  factory MoneyTransferStatistics({
    required num totalSentToPeers,
    required num totalRaised,
  }) = _MoneyTransferStatistics;

  const factory MoneyTransferStatistics.empty({
    @Default(0) num totalSentToPeers,
    @Default(0) num totalRaised,
  }) = _EmptyMoneyTransferStatistics;

  factory MoneyTransferStatistics.fromJson(Map<String, dynamic> json) =>
      _$MoneyTransferStatisticsFromJson(json);
}
