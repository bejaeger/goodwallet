import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:good_wallet/datamodels/money_pools/base/money_pool.dart';
import 'package:good_wallet/datamodels/transfers/transfer_details.dart';
import 'package:good_wallet/enums/transfer_status.dart';
import 'package:good_wallet/enums/transfer_type.dart';
import 'package:good_wallet/exceptions/datamodel_exception.dart';

part 'money_pool_payout.freezed.dart';
part 'money_pool_payout.g.dart';

@freezed
class MoneyPoolPayout with _$MoneyPoolPayout {
  static String _checkIftransferIdIsSet(String id) {
    if (id == "placeholder") {
      throw DataModelException(
          message:
              "MoneyPoolPayout: You can't serialize a money pool payout model that still has a placeholder for the 'payoutId'!",
          devDetails:
              "Please provide a valid 'payoutId' by creating a new 'Transaction' with the copyWith constructor and adding the firestore DocumentReference id as 'payoutId'");
    } else
      return id;
  }

  @JsonSerializable(explicitToJson: true)
  factory MoneyPoolPayout({
    required List<TransferDetails> transfersDetails,
    required List<String> paidOutUsersIds,
    required MoneyPool moneyPool,
    required dynamic createdAt,
    @Default(TransferType.MoneyPoolPayout)
        TransferType type,
    @Default(TransferStatus.Initialized)
        TransferStatus status,
    @JsonKey(
      name: "payoutId",
      toJson: MoneyPoolPayout._checkIftransferIdIsSet,
    )
    @Default("placeholder")
        String payoutId,
    @Default(true)
        bool deleteMoneyPool,
  }) = _MoneyPoolPayout;

  factory MoneyPoolPayout.fromJson(Map<String, dynamic> json) =>
      _$MoneyPoolPayoutFromJson(json);
}
