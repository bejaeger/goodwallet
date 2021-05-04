import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:good_wallet/datamodels/money_pools/settings/money_pool_settings.dart';
import 'package:good_wallet/datamodels/money_pools/users/contributing_user.dart';
import 'package:good_wallet/datamodels/user/public_user_info.dart';

part 'money_pool.freezed.dart';
part 'money_pool.g.dart';

@freezed
class MoneyPool with _$MoneyPool {
  @JsonSerializable(explicitToJson: true)
  factory MoneyPool({
    required String name,
    required String adminUID,
    required String adminName,
    required num total,
    required String currency,
    String? description,
    required String moneyPoolId,
    required MoneyPoolSettings
        moneyPoolSettings, // convert this to a MoneyPoolSettings class!
    required dynamic createdAt,
    required List<ContributingUser> contributingUsers,
    required List<PublicUserInfo> invitedUsers,
    // for querying purposes
    required List<String> contributingUserIds,
    required List<String> invitedUserIds,
  }) = _MoneyPool;

  factory MoneyPool.fromJson(Map<String, dynamic> json) =>
      _$MoneyPoolFromJson(json);
}
