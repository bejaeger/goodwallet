import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:good_wallet/datamodels/causes/preview_details/project_preview_details.dart';
import 'package:good_wallet/datamodels/money_pools/base/money_pool.dart';
import 'package:good_wallet/datamodels/transactions/transaction_details.dart';
import 'package:good_wallet/enums/transaction_status.dart';
import 'package:good_wallet/enums/transaction_type.dart';
import 'package:good_wallet/exceptions/transaction_datamodel_exception.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

@freezed
class Transaction with _$Transaction {
  const Transaction._(); // private constructor for implemented methods to work

  static String _checkIfTransactionIdIsSet(String id) {
    if (id == "placeholder") {
      throw TransactionDataModelException(
          message:
              "You can't serialize a transaction model that still has a placeholder for the 'transactionId'!",
          devDetails:
              "Please provide a valid 'transactionId' by creating a new 'Transaction' with the copyWith constructor and adding the firestore DocumentReference id as 'transactionId'");
    } else
      return id;
  }

  // Transaction between peers
  //
  //
  @JsonSerializable(explicitToJson: true)
  const factory Transaction.peer2peer({
    required TransactionDetails transactionDetails,
    required dynamic createdAt,
    @Default(TransactionStatus.Initialized)
        TransactionStatus status,
    @Default(TransactionType.Peer2Peer)
        TransactionType type,
    @JsonKey(
      name: "transactionId",
      toJson: Transaction._checkIfTransactionIdIsSet,
    )
    @Default("placeholder")
        String transactionId,
  }) = Peer2PeerTransaction;

  // Transaction from good wallet user to project (donation)
  //
  //
  @JsonSerializable(explicitToJson: true)
  const factory Transaction.donation({
    required TransactionDetails transactionDetails,
    required ProjectPreviewDetails projectPreviewDetails,
    required dynamic createdAt,
    @Default(TransactionStatus.Initialized)
        TransactionStatus status,
    @Default(TransactionType.Donation)
        TransactionType type,
    @JsonKey(
      name: "transactionId",
      toJson: Transaction._checkIfTransactionIdIsSet,
    )
    @Default("placeholder")
        String transactionId,
  }) = Donation;

  // Transaction from user to money pool
  //
  //
  @JsonSerializable(explicitToJson: true)
  const factory Transaction.moneyPoolContribution({
    required TransactionDetails transactionDetails,
    required dynamic createdAt,
    @Default(TransactionStatus.Initialized)
        TransactionStatus status,
    @Default(TransactionType.MoneyPoolContribution)
        TransactionType type,
    @JsonKey(
      name: "transactionId",
      toJson: Transaction._checkIfTransactionIdIsSet,
    )
    @Default("placeholder")
        String transactionId,
  }) = MoneyPoolContribution;

  // Transaction from money pool to (can be multiple) users
  //
  //
  @JsonSerializable(explicitToJson: true)
  const factory Transaction.moneyPoolPayout({
    required List<TransactionDetails> transactionsDetails,
    // List of user Ids that receive money for easy querying
    required List<String> paidOutUsersIds,
    required MoneyPool moneyPool,
    required dynamic createdAt,
    @Default(TransactionStatus.Initialized)
        TransactionStatus status,
    @Default(TransactionType.MoneyPoolPayout)
        TransactionType type,
    @JsonKey(
      name: "transactionId",
      toJson: Transaction._checkIfTransactionIdIsSet,
    )
    @Default("placeholder")
        String transactionId,
  }) = MoneyPoolPayout;

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
}
