import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:good_wallet/datamodels/causes/concise_info/concise_project_info.dart';
import 'package:good_wallet/datamodels/money_pools/base/concise_money_pool_info.dart';

part 'recipient_info.freezed.dart';
part 'recipient_info.g.dart';

// List all possible recipients
// What about top up of prepaid fund and commitment to good wallet!?

@freezed
class RecipientInfo with _$RecipientInfo {
  @JsonSerializable(explicitToJson: true)
  factory RecipientInfo.user({
    required String name,
    required String id,
    String? email,
  }) = UserRecipientInfo;

  // @JsonSerializable(explicitToJson: true)
  // factory RecipientInfo.commitment({
  //   required String name,
  //   required String id,
  //   String? email,
  // }) = _UserRecipientInfo;

  // @JsonSerializable(explicitToJson: true)
  // factory RecipientInfo.prepaid({
  //   required String name,
  //   required String id,
  //   String? email,
  // }) = _UserRecipientInfo;

  @JsonSerializable(explicitToJson: true)
  factory RecipientInfo.moneyPool({
    required String name,
    required String id,
    required ConciseMoneyPoolInfo moneyPoolInfo,
  }) = MoneyPoolRecipientInfo;

  @JsonSerializable(explicitToJson: true)
  factory RecipientInfo.donation({
    required String name,
    required String id,
    required ConciseProjectInfo projectInfo,
  }) = DonationRecipientInfo;

  factory RecipientInfo.fromJson(Map<String, dynamic> json) =>
      _$RecipientInfoFromJson(json);
}
