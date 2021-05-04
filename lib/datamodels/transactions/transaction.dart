import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:good_wallet/datamodels/money_pools/base/money_pool.dart';
import 'package:good_wallet/datamodels/transactions/transaction_details.dart';
import 'package:good_wallet/enums/transaction_type.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

@freezed
abstract class Transaction with _$Transaction {
  const Transaction._(); // private constructor for implemented methods to work

  @JsonSerializable(explicitToJson: true)
  const factory Transaction.peer2peer({
    required TransactionDetails transactionDetails,
    required String status,
    required String transactionId,
    required dynamic createdAt,
    @Default(TransactionType.Peer2Peer) TransactionType type,
  }) = Peer2PeerTransaction;

  @JsonSerializable(explicitToJson: true)
  const factory Transaction.donation({
    required TransactionDetails transactionDetails,
    required String status,
    required String transactionId,
    required dynamic createdAt,
    @Default(TransactionType.Donation) TransactionType type,
  }) = Donation;

  @JsonSerializable(explicitToJson: true)
  const factory Transaction.moneyPoolContribution({
    required TransactionDetails transactionDetails,
    required String status,
    required String transactionId,
    required dynamic createdAt,
    @Default(TransactionType.MoneyPoolContribution) TransactionType type,
  }) = MoneyPoolContribution;

  // This is a transaction where a money pool is disbursed to multiple users
  @JsonSerializable(explicitToJson: true)
  const factory Transaction.moneyPoolPayout({
    required List<TransactionDetails> transactionsDetails,
    // List of user Ids that receive money for easy querying
    required List<String> paidOutUsersIds,
    required MoneyPool moneyPool,
    required String status,
    required String transactionId,
    required dynamic createdAt,
    @Default(TransactionType.MoneyPoolPayout) TransactionType type,
  }) = MoneyPoolPayout;

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
}
