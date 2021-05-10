import 'package:freezed_annotation/freezed_annotation.dart';

part 'money_transfer_statistics.freezed.dart';
part 'money_transfer_statistics.g.dart';

@freezed
class MoneyTransferStatistics with _$MoneyTransferStatistics {
  factory MoneyTransferStatistics({
    required num totalTransferredToPeers,
    required num totalRaised,
  }) = _MoneyTransferStatistics;

  factory MoneyTransferStatistics.fromJson(Map<String, dynamic> json) =>
      _$MoneyTransferStatisticsFromJson(json);
}
