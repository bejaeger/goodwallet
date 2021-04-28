import 'package:freezed_annotation/freezed_annotation.dart';

part 'money_pool_contribution.freezed.dart';
part 'money_pool_contribution.g.dart';

@freezed
abstract class MoneyPoolContributionModel with _$MoneyPoolContributionModel {
  factory MoneyPoolContributionModel({
    required String moneyPoolId,
    required String moneyPoolName,
    required String uid,
    required String userName,
    required num amount,
    required String currency,
    String? message,
    required dynamic createdAt,
    required String status,
    String? transactionId,
  }) = _MoneyPoolContributionModel;

  factory MoneyPoolContributionModel.fromJson(Map<String, dynamic> json) =>
      _$MoneyPoolContributionModelFromJson(json);
}
