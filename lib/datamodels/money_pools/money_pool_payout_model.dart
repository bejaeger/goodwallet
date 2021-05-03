import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:good_wallet/datamodels/money_pools/money_pool_model.dart';
import 'package:good_wallet/datamodels/money_pools/paid_out_user.dart';

part 'money_pool_payout_model.freezed.dart';
part 'money_pool_payout_model.g.dart';

@freezed
abstract class MoneyPoolPayoutModel with _$MoneyPoolPayoutModel {
  @JsonSerializable(explicitToJson: true)
  factory MoneyPoolPayoutModel({
    // Money pool information
    required MoneyPoolModel moneyPool,
    // List of users and payout amount
    required List<PaidOutUser> paidOutUsers,
    // List of user Ids that receive money
    required List<String> paidOutUsersIds,
    // Id of the document in firestore
    //
    // Must be set before setting data!
    String? payoutId,
    // NOT IMPLEMENTED YET
    String? status,
    // NOT IMPLEMENTED YET
    bool?
        keepMoneyPoolAlive, // potential option for user to keep money pool in continuous use
  }) = _MoneyPoolPayoutModel;

  factory MoneyPoolPayoutModel.fromJson(Map<String, dynamic> json) =>
      _$MoneyPoolPayoutModelFromJson(json);
}
