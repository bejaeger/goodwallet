import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:good_wallet/datamodels/money_pools/settings/money_pool_settings.dart';
import 'package:good_wallet/datamodels/money_pools/users/contributing_user.dart';
import 'package:good_wallet/datamodels/user/public_user_info.dart';
import 'package:good_wallet/exceptions/datamodel_exception.dart';

part 'money_pool.freezed.dart';
part 'money_pool.g.dart';

@freezed
class MoneyPool with _$MoneyPool {
  static String _checkIfMoneyPoolIdIsSet(String id) {
    if (id == "placeholder") {
      throw DataModelException(
          message:
              "MoneyPool: You can't serialize a money pool that still has a placeholder for the 'moneyPoolId'!",
          devDetails:
              "Please provide a valid 'moneyPoolId' by creating a new 'MoneyPool' with the copyWith constructor and adding the firestore DocumentReference id as 'moneyPoolId'");
    } else
      return id;
  }

  @JsonSerializable(explicitToJson: true)
  factory MoneyPool({
    required num total,
    required String name,
    required String adminUID,
    required String adminName,
    required String currency,
    String? description,
    required MoneyPoolSettings moneyPoolSettings,
    required dynamic createdAt,
    required List<ContributingUser> contributingUsers,
    required List<PublicUserInfo> invitedUsers,
    // for querying purposes
    required List<String> contributingUserIds,
    required List<String> invitedUserIds,
    @JsonKey(
      name: "moneyPoolId",
      toJson: MoneyPool._checkIfMoneyPoolIdIsSet,
    )
    @Default("placeholder")
        String moneyPoolId,
  }) = _MoneyPool;

  factory MoneyPool.fromJson(Map<String, dynamic> json) =>
      _$MoneyPoolFromJson(json);
}
