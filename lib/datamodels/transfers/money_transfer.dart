import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:good_wallet/datamodels/causes/preview_details/project_preview_info.dart';
import 'package:good_wallet/datamodels/money_pools/base/money_pool_preview_info.dart';
import 'package:good_wallet/datamodels/transfers/transfer_details.dart';
import 'package:good_wallet/enums/transfer_status.dart';
import 'package:good_wallet/enums/transfer_type.dart';
import 'package:good_wallet/exceptions/datamodel_exception.dart';

part 'money_transfer.freezed.dart';
part 'money_transfer.g.dart';

@freezed
class MoneyTransfer with _$MoneyTransfer {
  const MoneyTransfer._(); // private constructor for implemented methods to work

  static String _checkIftransferIdIsSet(String id) {
    if (id == "placeholder") {
      throw DataModelException(
          message:
              "MoneyTransfer: You can't serialize a money transfer model that still has a placeholder for the 'transferId'!",
          devDetails:
              "Please provide a valid 'transferId' by creating a new 'Transaction' with the copyWith constructor and adding the firestore DocumentReference id as 'transferId'");
    } else
      return id;
  }

  // Transaction between peers
  // From the user perspective this can still be
  // an outgoing or incoming transaction
  @JsonSerializable(explicitToJson: true)
  const factory MoneyTransfer.peer2peer({
    required TransferDetails transferDetails,
    required dynamic createdAt,
    @Default(TransferStatus.Initialized)
        TransferStatus status,
    // Important: The json key name will be used in the cloud functions.
    @JsonKey(name: "Peer2Peer")
    @Default(TransferType.Peer2Peer)
        TransferType type,
    @JsonKey(
      name: "transferId",
      toJson: MoneyTransfer._checkIftransferIdIsSet,
    )
    @Default("placeholder")
        String transferId,
  }) = Peer2PeerTransfer;

  // Transaction from good wallet user to project (donation)
  //
  //
  @JsonSerializable(explicitToJson: true)
  const factory MoneyTransfer.donation({
    required TransferDetails transferDetails,
    required ProjectPreviewInfo projectInfo,
    required dynamic createdAt,
    @Default(TransferStatus.Initialized)
        TransferStatus status,
    @JsonKey(name: "Donation")
    @Default(TransferType.Donation)
        TransferType type,
    @JsonKey(
      name: "transferId",
      toJson: MoneyTransfer._checkIftransferIdIsSet,
    )
    @Default("placeholder")
        String transferId,
  }) = Donation;

  // Transaction from user to money pool
  //
  //
  @JsonSerializable(explicitToJson: true)
  const factory MoneyTransfer.moneyPoolContribution({
    required TransferDetails transferDetails,
    required MoneyPoolPreviewInfo moneyPoolInfo,
    required dynamic createdAt,
    @Default(TransferStatus.Initialized)
        TransferStatus status,
    @JsonKey(name: "MoneyPoolContribution")
    @Default(TransferType.MoneyPoolContribution)
        TransferType type,
    @JsonKey(
      name: "transferId",
      toJson: MoneyTransfer._checkIftransferIdIsSet,
    )
    @Default("placeholder")
        String transferId,
  }) = MoneyPoolContribution;

  // Transaction from money pool to user
  //
  //
  @JsonSerializable(explicitToJson: true)
  const factory MoneyTransfer.moneyPoolPayout({
    required TransferDetails transferDetails,
    required MoneyPoolPreviewInfo moneyPoolInfo,
    // id of money pool payout that stores
    // entire info of money pool payout
    required String payoutId,
    required dynamic createdAt,
    @Default(TransferStatus.Initialized)
        TransferStatus status,
    @JsonKey(name: "MoneyPoolPayout")
    @Default(TransferType.MoneyPoolPayout)
        TransferType type,
    @JsonKey(
      name: "transferId",
      toJson: MoneyTransfer._checkIftransferIdIsSet,
    )
    @Default("placeholder")
        String transferId,
  }) = MoneyPoolPayoutTransfer;

  factory MoneyTransfer.fromJson(Map<String, dynamic> json) =>
      _$MoneyTransferFromJson(json);
}
