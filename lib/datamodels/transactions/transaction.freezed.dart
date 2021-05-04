// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType'] as String) {
    case 'peer2peer':
      return Peer2PeerTransaction.fromJson(json);
    case 'donation':
      return Donation.fromJson(json);
    case 'moneyPoolContribution':
      return MoneyPoolContribution.fromJson(json);
    case 'moneyPoolPayout':
      return MoneyPoolPayout.fromJson(json);

    default:
      throw FallThroughError();
  }
}

/// @nodoc
class _$TransactionTearOff {
  const _$TransactionTearOff();

  Peer2PeerTransaction peer2peer(
      {required TransactionDetails transactionDetails,
      required String status,
      required String transactionId,
      required dynamic createdAt,
      TransactionType type = TransactionType.Peer2Peer}) {
    return Peer2PeerTransaction(
      transactionDetails: transactionDetails,
      status: status,
      transactionId: transactionId,
      createdAt: createdAt,
      type: type,
    );
  }

  Donation donation(
      {required TransactionDetails transactionDetails,
      required String status,
      required String transactionId,
      required dynamic createdAt,
      TransactionType type = TransactionType.Donation}) {
    return Donation(
      transactionDetails: transactionDetails,
      status: status,
      transactionId: transactionId,
      createdAt: createdAt,
      type: type,
    );
  }

  MoneyPoolContribution moneyPoolContribution(
      {required TransactionDetails transactionDetails,
      required String status,
      required String transactionId,
      required dynamic createdAt,
      TransactionType type = TransactionType.MoneyPoolContribution}) {
    return MoneyPoolContribution(
      transactionDetails: transactionDetails,
      status: status,
      transactionId: transactionId,
      createdAt: createdAt,
      type: type,
    );
  }

  MoneyPoolPayout moneyPoolPayout(
      {required List<TransactionDetails> transactionsDetails,
      required List<String> paidOutUsersIds,
      required MoneyPool moneyPool,
      required String status,
      required String transactionId,
      required dynamic createdAt,
      TransactionType type = TransactionType.MoneyPoolPayout}) {
    return MoneyPoolPayout(
      transactionsDetails: transactionsDetails,
      paidOutUsersIds: paidOutUsersIds,
      moneyPool: moneyPool,
      status: status,
      transactionId: transactionId,
      createdAt: createdAt,
      type: type,
    );
  }

  Transaction fromJson(Map<String, Object> json) {
    return Transaction.fromJson(json);
  }
}

/// @nodoc
const $Transaction = _$TransactionTearOff();

/// @nodoc
mixin _$Transaction {
  String get status => throw _privateConstructorUsedError;
  String get transactionId => throw _privateConstructorUsedError;
  dynamic get createdAt => throw _privateConstructorUsedError;
  TransactionType get type => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            TransactionDetails transactionDetails,
            String status,
            String transactionId,
            dynamic createdAt,
            TransactionType type)
        peer2peer,
    required TResult Function(
            TransactionDetails transactionDetails,
            String status,
            String transactionId,
            dynamic createdAt,
            TransactionType type)
        donation,
    required TResult Function(
            TransactionDetails transactionDetails,
            String status,
            String transactionId,
            dynamic createdAt,
            TransactionType type)
        moneyPoolContribution,
    required TResult Function(
            List<TransactionDetails> transactionsDetails,
            List<String> paidOutUsersIds,
            MoneyPool moneyPool,
            String status,
            String transactionId,
            dynamic createdAt,
            TransactionType type)
        moneyPoolPayout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TransactionDetails transactionDetails, String status,
            String transactionId, dynamic createdAt, TransactionType type)?
        peer2peer,
    TResult Function(TransactionDetails transactionDetails, String status,
            String transactionId, dynamic createdAt, TransactionType type)?
        donation,
    TResult Function(TransactionDetails transactionDetails, String status,
            String transactionId, dynamic createdAt, TransactionType type)?
        moneyPoolContribution,
    TResult Function(
            List<TransactionDetails> transactionsDetails,
            List<String> paidOutUsersIds,
            MoneyPool moneyPool,
            String status,
            String transactionId,
            dynamic createdAt,
            TransactionType type)?
        moneyPoolPayout,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Peer2PeerTransaction value) peer2peer,
    required TResult Function(Donation value) donation,
    required TResult Function(MoneyPoolContribution value)
        moneyPoolContribution,
    required TResult Function(MoneyPoolPayout value) moneyPoolPayout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Peer2PeerTransaction value)? peer2peer,
    TResult Function(Donation value)? donation,
    TResult Function(MoneyPoolContribution value)? moneyPoolContribution,
    TResult Function(MoneyPoolPayout value)? moneyPoolPayout,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransactionCopyWith<Transaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionCopyWith<$Res> {
  factory $TransactionCopyWith(
          Transaction value, $Res Function(Transaction) then) =
      _$TransactionCopyWithImpl<$Res>;
  $Res call(
      {String status,
      String transactionId,
      dynamic createdAt,
      TransactionType type});
}

/// @nodoc
class _$TransactionCopyWithImpl<$Res> implements $TransactionCopyWith<$Res> {
  _$TransactionCopyWithImpl(this._value, this._then);

  final Transaction _value;
  // ignore: unused_field
  final $Res Function(Transaction) _then;

  @override
  $Res call({
    Object? status = freezed,
    Object? transactionId = freezed,
    Object? createdAt = freezed,
    Object? type = freezed,
  }) {
    return _then(_value.copyWith(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      transactionId: transactionId == freezed
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TransactionType,
    ));
  }
}

/// @nodoc
abstract class $Peer2PeerTransactionCopyWith<$Res>
    implements $TransactionCopyWith<$Res> {
  factory $Peer2PeerTransactionCopyWith(Peer2PeerTransaction value,
          $Res Function(Peer2PeerTransaction) then) =
      _$Peer2PeerTransactionCopyWithImpl<$Res>;
  @override
  $Res call(
      {TransactionDetails transactionDetails,
      String status,
      String transactionId,
      dynamic createdAt,
      TransactionType type});

  $TransactionDetailsCopyWith<$Res> get transactionDetails;
}

/// @nodoc
class _$Peer2PeerTransactionCopyWithImpl<$Res>
    extends _$TransactionCopyWithImpl<$Res>
    implements $Peer2PeerTransactionCopyWith<$Res> {
  _$Peer2PeerTransactionCopyWithImpl(
      Peer2PeerTransaction _value, $Res Function(Peer2PeerTransaction) _then)
      : super(_value, (v) => _then(v as Peer2PeerTransaction));

  @override
  Peer2PeerTransaction get _value => super._value as Peer2PeerTransaction;

  @override
  $Res call({
    Object? transactionDetails = freezed,
    Object? status = freezed,
    Object? transactionId = freezed,
    Object? createdAt = freezed,
    Object? type = freezed,
  }) {
    return _then(Peer2PeerTransaction(
      transactionDetails: transactionDetails == freezed
          ? _value.transactionDetails
          : transactionDetails // ignore: cast_nullable_to_non_nullable
              as TransactionDetails,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      transactionId: transactionId == freezed
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TransactionType,
    ));
  }

  @override
  $TransactionDetailsCopyWith<$Res> get transactionDetails {
    return $TransactionDetailsCopyWith<$Res>(_value.transactionDetails,
        (value) {
      return _then(_value.copyWith(transactionDetails: value));
    });
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$Peer2PeerTransaction extends Peer2PeerTransaction {
  const _$Peer2PeerTransaction(
      {required this.transactionDetails,
      required this.status,
      required this.transactionId,
      required this.createdAt,
      this.type = TransactionType.Peer2Peer})
      : super._();

  factory _$Peer2PeerTransaction.fromJson(Map<String, dynamic> json) =>
      _$_$Peer2PeerTransactionFromJson(json);

  @override
  final TransactionDetails transactionDetails;
  @override
  final String status;
  @override
  final String transactionId;
  @override
  final dynamic createdAt;
  @JsonKey(defaultValue: TransactionType.Peer2Peer)
  @override
  final TransactionType type;

  @override
  String toString() {
    return 'Transaction.peer2peer(transactionDetails: $transactionDetails, status: $status, transactionId: $transactionId, createdAt: $createdAt, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Peer2PeerTransaction &&
            (identical(other.transactionDetails, transactionDetails) ||
                const DeepCollectionEquality()
                    .equals(other.transactionDetails, transactionDetails)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.transactionId, transactionId) ||
                const DeepCollectionEquality()
                    .equals(other.transactionId, transactionId)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(transactionDetails) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(transactionId) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(type);

  @JsonKey(ignore: true)
  @override
  $Peer2PeerTransactionCopyWith<Peer2PeerTransaction> get copyWith =>
      _$Peer2PeerTransactionCopyWithImpl<Peer2PeerTransaction>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            TransactionDetails transactionDetails,
            String status,
            String transactionId,
            dynamic createdAt,
            TransactionType type)
        peer2peer,
    required TResult Function(
            TransactionDetails transactionDetails,
            String status,
            String transactionId,
            dynamic createdAt,
            TransactionType type)
        donation,
    required TResult Function(
            TransactionDetails transactionDetails,
            String status,
            String transactionId,
            dynamic createdAt,
            TransactionType type)
        moneyPoolContribution,
    required TResult Function(
            List<TransactionDetails> transactionsDetails,
            List<String> paidOutUsersIds,
            MoneyPool moneyPool,
            String status,
            String transactionId,
            dynamic createdAt,
            TransactionType type)
        moneyPoolPayout,
  }) {
    return peer2peer(
        transactionDetails, status, transactionId, createdAt, type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TransactionDetails transactionDetails, String status,
            String transactionId, dynamic createdAt, TransactionType type)?
        peer2peer,
    TResult Function(TransactionDetails transactionDetails, String status,
            String transactionId, dynamic createdAt, TransactionType type)?
        donation,
    TResult Function(TransactionDetails transactionDetails, String status,
            String transactionId, dynamic createdAt, TransactionType type)?
        moneyPoolContribution,
    TResult Function(
            List<TransactionDetails> transactionsDetails,
            List<String> paidOutUsersIds,
            MoneyPool moneyPool,
            String status,
            String transactionId,
            dynamic createdAt,
            TransactionType type)?
        moneyPoolPayout,
    required TResult orElse(),
  }) {
    if (peer2peer != null) {
      return peer2peer(
          transactionDetails, status, transactionId, createdAt, type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Peer2PeerTransaction value) peer2peer,
    required TResult Function(Donation value) donation,
    required TResult Function(MoneyPoolContribution value)
        moneyPoolContribution,
    required TResult Function(MoneyPoolPayout value) moneyPoolPayout,
  }) {
    return peer2peer(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Peer2PeerTransaction value)? peer2peer,
    TResult Function(Donation value)? donation,
    TResult Function(MoneyPoolContribution value)? moneyPoolContribution,
    TResult Function(MoneyPoolPayout value)? moneyPoolPayout,
    required TResult orElse(),
  }) {
    if (peer2peer != null) {
      return peer2peer(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$Peer2PeerTransactionToJson(this)..['runtimeType'] = 'peer2peer';
  }
}

abstract class Peer2PeerTransaction extends Transaction {
  const factory Peer2PeerTransaction(
      {required TransactionDetails transactionDetails,
      required String status,
      required String transactionId,
      required dynamic createdAt,
      TransactionType type}) = _$Peer2PeerTransaction;
  const Peer2PeerTransaction._() : super._();

  factory Peer2PeerTransaction.fromJson(Map<String, dynamic> json) =
      _$Peer2PeerTransaction.fromJson;

  TransactionDetails get transactionDetails =>
      throw _privateConstructorUsedError;
  @override
  String get status => throw _privateConstructorUsedError;
  @override
  String get transactionId => throw _privateConstructorUsedError;
  @override
  dynamic get createdAt => throw _privateConstructorUsedError;
  @override
  TransactionType get type => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $Peer2PeerTransactionCopyWith<Peer2PeerTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DonationCopyWith<$Res> implements $TransactionCopyWith<$Res> {
  factory $DonationCopyWith(Donation value, $Res Function(Donation) then) =
      _$DonationCopyWithImpl<$Res>;
  @override
  $Res call(
      {TransactionDetails transactionDetails,
      String status,
      String transactionId,
      dynamic createdAt,
      TransactionType type});

  $TransactionDetailsCopyWith<$Res> get transactionDetails;
}

/// @nodoc
class _$DonationCopyWithImpl<$Res> extends _$TransactionCopyWithImpl<$Res>
    implements $DonationCopyWith<$Res> {
  _$DonationCopyWithImpl(Donation _value, $Res Function(Donation) _then)
      : super(_value, (v) => _then(v as Donation));

  @override
  Donation get _value => super._value as Donation;

  @override
  $Res call({
    Object? transactionDetails = freezed,
    Object? status = freezed,
    Object? transactionId = freezed,
    Object? createdAt = freezed,
    Object? type = freezed,
  }) {
    return _then(Donation(
      transactionDetails: transactionDetails == freezed
          ? _value.transactionDetails
          : transactionDetails // ignore: cast_nullable_to_non_nullable
              as TransactionDetails,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      transactionId: transactionId == freezed
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TransactionType,
    ));
  }

  @override
  $TransactionDetailsCopyWith<$Res> get transactionDetails {
    return $TransactionDetailsCopyWith<$Res>(_value.transactionDetails,
        (value) {
      return _then(_value.copyWith(transactionDetails: value));
    });
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$Donation extends Donation {
  const _$Donation(
      {required this.transactionDetails,
      required this.status,
      required this.transactionId,
      required this.createdAt,
      this.type = TransactionType.Donation})
      : super._();

  factory _$Donation.fromJson(Map<String, dynamic> json) =>
      _$_$DonationFromJson(json);

  @override
  final TransactionDetails transactionDetails;
  @override
  final String status;
  @override
  final String transactionId;
  @override
  final dynamic createdAt;
  @JsonKey(defaultValue: TransactionType.Donation)
  @override
  final TransactionType type;

  @override
  String toString() {
    return 'Transaction.donation(transactionDetails: $transactionDetails, status: $status, transactionId: $transactionId, createdAt: $createdAt, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Donation &&
            (identical(other.transactionDetails, transactionDetails) ||
                const DeepCollectionEquality()
                    .equals(other.transactionDetails, transactionDetails)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.transactionId, transactionId) ||
                const DeepCollectionEquality()
                    .equals(other.transactionId, transactionId)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(transactionDetails) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(transactionId) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(type);

  @JsonKey(ignore: true)
  @override
  $DonationCopyWith<Donation> get copyWith =>
      _$DonationCopyWithImpl<Donation>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            TransactionDetails transactionDetails,
            String status,
            String transactionId,
            dynamic createdAt,
            TransactionType type)
        peer2peer,
    required TResult Function(
            TransactionDetails transactionDetails,
            String status,
            String transactionId,
            dynamic createdAt,
            TransactionType type)
        donation,
    required TResult Function(
            TransactionDetails transactionDetails,
            String status,
            String transactionId,
            dynamic createdAt,
            TransactionType type)
        moneyPoolContribution,
    required TResult Function(
            List<TransactionDetails> transactionsDetails,
            List<String> paidOutUsersIds,
            MoneyPool moneyPool,
            String status,
            String transactionId,
            dynamic createdAt,
            TransactionType type)
        moneyPoolPayout,
  }) {
    return donation(transactionDetails, status, transactionId, createdAt, type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TransactionDetails transactionDetails, String status,
            String transactionId, dynamic createdAt, TransactionType type)?
        peer2peer,
    TResult Function(TransactionDetails transactionDetails, String status,
            String transactionId, dynamic createdAt, TransactionType type)?
        donation,
    TResult Function(TransactionDetails transactionDetails, String status,
            String transactionId, dynamic createdAt, TransactionType type)?
        moneyPoolContribution,
    TResult Function(
            List<TransactionDetails> transactionsDetails,
            List<String> paidOutUsersIds,
            MoneyPool moneyPool,
            String status,
            String transactionId,
            dynamic createdAt,
            TransactionType type)?
        moneyPoolPayout,
    required TResult orElse(),
  }) {
    if (donation != null) {
      return donation(
          transactionDetails, status, transactionId, createdAt, type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Peer2PeerTransaction value) peer2peer,
    required TResult Function(Donation value) donation,
    required TResult Function(MoneyPoolContribution value)
        moneyPoolContribution,
    required TResult Function(MoneyPoolPayout value) moneyPoolPayout,
  }) {
    return donation(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Peer2PeerTransaction value)? peer2peer,
    TResult Function(Donation value)? donation,
    TResult Function(MoneyPoolContribution value)? moneyPoolContribution,
    TResult Function(MoneyPoolPayout value)? moneyPoolPayout,
    required TResult orElse(),
  }) {
    if (donation != null) {
      return donation(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$DonationToJson(this)..['runtimeType'] = 'donation';
  }
}

abstract class Donation extends Transaction {
  const factory Donation(
      {required TransactionDetails transactionDetails,
      required String status,
      required String transactionId,
      required dynamic createdAt,
      TransactionType type}) = _$Donation;
  const Donation._() : super._();

  factory Donation.fromJson(Map<String, dynamic> json) = _$Donation.fromJson;

  TransactionDetails get transactionDetails =>
      throw _privateConstructorUsedError;
  @override
  String get status => throw _privateConstructorUsedError;
  @override
  String get transactionId => throw _privateConstructorUsedError;
  @override
  dynamic get createdAt => throw _privateConstructorUsedError;
  @override
  TransactionType get type => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $DonationCopyWith<Donation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoneyPoolContributionCopyWith<$Res>
    implements $TransactionCopyWith<$Res> {
  factory $MoneyPoolContributionCopyWith(MoneyPoolContribution value,
          $Res Function(MoneyPoolContribution) then) =
      _$MoneyPoolContributionCopyWithImpl<$Res>;
  @override
  $Res call(
      {TransactionDetails transactionDetails,
      String status,
      String transactionId,
      dynamic createdAt,
      TransactionType type});

  $TransactionDetailsCopyWith<$Res> get transactionDetails;
}

/// @nodoc
class _$MoneyPoolContributionCopyWithImpl<$Res>
    extends _$TransactionCopyWithImpl<$Res>
    implements $MoneyPoolContributionCopyWith<$Res> {
  _$MoneyPoolContributionCopyWithImpl(
      MoneyPoolContribution _value, $Res Function(MoneyPoolContribution) _then)
      : super(_value, (v) => _then(v as MoneyPoolContribution));

  @override
  MoneyPoolContribution get _value => super._value as MoneyPoolContribution;

  @override
  $Res call({
    Object? transactionDetails = freezed,
    Object? status = freezed,
    Object? transactionId = freezed,
    Object? createdAt = freezed,
    Object? type = freezed,
  }) {
    return _then(MoneyPoolContribution(
      transactionDetails: transactionDetails == freezed
          ? _value.transactionDetails
          : transactionDetails // ignore: cast_nullable_to_non_nullable
              as TransactionDetails,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      transactionId: transactionId == freezed
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TransactionType,
    ));
  }

  @override
  $TransactionDetailsCopyWith<$Res> get transactionDetails {
    return $TransactionDetailsCopyWith<$Res>(_value.transactionDetails,
        (value) {
      return _then(_value.copyWith(transactionDetails: value));
    });
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$MoneyPoolContribution extends MoneyPoolContribution {
  const _$MoneyPoolContribution(
      {required this.transactionDetails,
      required this.status,
      required this.transactionId,
      required this.createdAt,
      this.type = TransactionType.MoneyPoolContribution})
      : super._();

  factory _$MoneyPoolContribution.fromJson(Map<String, dynamic> json) =>
      _$_$MoneyPoolContributionFromJson(json);

  @override
  final TransactionDetails transactionDetails;
  @override
  final String status;
  @override
  final String transactionId;
  @override
  final dynamic createdAt;
  @JsonKey(defaultValue: TransactionType.MoneyPoolContribution)
  @override
  final TransactionType type;

  @override
  String toString() {
    return 'Transaction.moneyPoolContribution(transactionDetails: $transactionDetails, status: $status, transactionId: $transactionId, createdAt: $createdAt, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is MoneyPoolContribution &&
            (identical(other.transactionDetails, transactionDetails) ||
                const DeepCollectionEquality()
                    .equals(other.transactionDetails, transactionDetails)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.transactionId, transactionId) ||
                const DeepCollectionEquality()
                    .equals(other.transactionId, transactionId)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(transactionDetails) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(transactionId) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(type);

  @JsonKey(ignore: true)
  @override
  $MoneyPoolContributionCopyWith<MoneyPoolContribution> get copyWith =>
      _$MoneyPoolContributionCopyWithImpl<MoneyPoolContribution>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            TransactionDetails transactionDetails,
            String status,
            String transactionId,
            dynamic createdAt,
            TransactionType type)
        peer2peer,
    required TResult Function(
            TransactionDetails transactionDetails,
            String status,
            String transactionId,
            dynamic createdAt,
            TransactionType type)
        donation,
    required TResult Function(
            TransactionDetails transactionDetails,
            String status,
            String transactionId,
            dynamic createdAt,
            TransactionType type)
        moneyPoolContribution,
    required TResult Function(
            List<TransactionDetails> transactionsDetails,
            List<String> paidOutUsersIds,
            MoneyPool moneyPool,
            String status,
            String transactionId,
            dynamic createdAt,
            TransactionType type)
        moneyPoolPayout,
  }) {
    return moneyPoolContribution(
        transactionDetails, status, transactionId, createdAt, type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TransactionDetails transactionDetails, String status,
            String transactionId, dynamic createdAt, TransactionType type)?
        peer2peer,
    TResult Function(TransactionDetails transactionDetails, String status,
            String transactionId, dynamic createdAt, TransactionType type)?
        donation,
    TResult Function(TransactionDetails transactionDetails, String status,
            String transactionId, dynamic createdAt, TransactionType type)?
        moneyPoolContribution,
    TResult Function(
            List<TransactionDetails> transactionsDetails,
            List<String> paidOutUsersIds,
            MoneyPool moneyPool,
            String status,
            String transactionId,
            dynamic createdAt,
            TransactionType type)?
        moneyPoolPayout,
    required TResult orElse(),
  }) {
    if (moneyPoolContribution != null) {
      return moneyPoolContribution(
          transactionDetails, status, transactionId, createdAt, type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Peer2PeerTransaction value) peer2peer,
    required TResult Function(Donation value) donation,
    required TResult Function(MoneyPoolContribution value)
        moneyPoolContribution,
    required TResult Function(MoneyPoolPayout value) moneyPoolPayout,
  }) {
    return moneyPoolContribution(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Peer2PeerTransaction value)? peer2peer,
    TResult Function(Donation value)? donation,
    TResult Function(MoneyPoolContribution value)? moneyPoolContribution,
    TResult Function(MoneyPoolPayout value)? moneyPoolPayout,
    required TResult orElse(),
  }) {
    if (moneyPoolContribution != null) {
      return moneyPoolContribution(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$MoneyPoolContributionToJson(this)
      ..['runtimeType'] = 'moneyPoolContribution';
  }
}

abstract class MoneyPoolContribution extends Transaction {
  const factory MoneyPoolContribution(
      {required TransactionDetails transactionDetails,
      required String status,
      required String transactionId,
      required dynamic createdAt,
      TransactionType type}) = _$MoneyPoolContribution;
  const MoneyPoolContribution._() : super._();

  factory MoneyPoolContribution.fromJson(Map<String, dynamic> json) =
      _$MoneyPoolContribution.fromJson;

  TransactionDetails get transactionDetails =>
      throw _privateConstructorUsedError;
  @override
  String get status => throw _privateConstructorUsedError;
  @override
  String get transactionId => throw _privateConstructorUsedError;
  @override
  dynamic get createdAt => throw _privateConstructorUsedError;
  @override
  TransactionType get type => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $MoneyPoolContributionCopyWith<MoneyPoolContribution> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoneyPoolPayoutCopyWith<$Res>
    implements $TransactionCopyWith<$Res> {
  factory $MoneyPoolPayoutCopyWith(
          MoneyPoolPayout value, $Res Function(MoneyPoolPayout) then) =
      _$MoneyPoolPayoutCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<TransactionDetails> transactionsDetails,
      List<String> paidOutUsersIds,
      MoneyPool moneyPool,
      String status,
      String transactionId,
      dynamic createdAt,
      TransactionType type});

  $MoneyPoolCopyWith<$Res> get moneyPool;
}

/// @nodoc
class _$MoneyPoolPayoutCopyWithImpl<$Res>
    extends _$TransactionCopyWithImpl<$Res>
    implements $MoneyPoolPayoutCopyWith<$Res> {
  _$MoneyPoolPayoutCopyWithImpl(
      MoneyPoolPayout _value, $Res Function(MoneyPoolPayout) _then)
      : super(_value, (v) => _then(v as MoneyPoolPayout));

  @override
  MoneyPoolPayout get _value => super._value as MoneyPoolPayout;

  @override
  $Res call({
    Object? transactionsDetails = freezed,
    Object? paidOutUsersIds = freezed,
    Object? moneyPool = freezed,
    Object? status = freezed,
    Object? transactionId = freezed,
    Object? createdAt = freezed,
    Object? type = freezed,
  }) {
    return _then(MoneyPoolPayout(
      transactionsDetails: transactionsDetails == freezed
          ? _value.transactionsDetails
          : transactionsDetails // ignore: cast_nullable_to_non_nullable
              as List<TransactionDetails>,
      paidOutUsersIds: paidOutUsersIds == freezed
          ? _value.paidOutUsersIds
          : paidOutUsersIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      moneyPool: moneyPool == freezed
          ? _value.moneyPool
          : moneyPool // ignore: cast_nullable_to_non_nullable
              as MoneyPool,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      transactionId: transactionId == freezed
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TransactionType,
    ));
  }

  @override
  $MoneyPoolCopyWith<$Res> get moneyPool {
    return $MoneyPoolCopyWith<$Res>(_value.moneyPool, (value) {
      return _then(_value.copyWith(moneyPool: value));
    });
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$MoneyPoolPayout extends MoneyPoolPayout {
  const _$MoneyPoolPayout(
      {required this.transactionsDetails,
      required this.paidOutUsersIds,
      required this.moneyPool,
      required this.status,
      required this.transactionId,
      required this.createdAt,
      this.type = TransactionType.MoneyPoolPayout})
      : super._();

  factory _$MoneyPoolPayout.fromJson(Map<String, dynamic> json) =>
      _$_$MoneyPoolPayoutFromJson(json);

  @override
  final List<TransactionDetails> transactionsDetails;
  @override // List of user Ids that receive money for easy querying
  final List<String> paidOutUsersIds;
  @override
  final MoneyPool moneyPool;
  @override
  final String status;
  @override
  final String transactionId;
  @override
  final dynamic createdAt;
  @JsonKey(defaultValue: TransactionType.MoneyPoolPayout)
  @override
  final TransactionType type;

  @override
  String toString() {
    return 'Transaction.moneyPoolPayout(transactionsDetails: $transactionsDetails, paidOutUsersIds: $paidOutUsersIds, moneyPool: $moneyPool, status: $status, transactionId: $transactionId, createdAt: $createdAt, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is MoneyPoolPayout &&
            (identical(other.transactionsDetails, transactionsDetails) ||
                const DeepCollectionEquality()
                    .equals(other.transactionsDetails, transactionsDetails)) &&
            (identical(other.paidOutUsersIds, paidOutUsersIds) ||
                const DeepCollectionEquality()
                    .equals(other.paidOutUsersIds, paidOutUsersIds)) &&
            (identical(other.moneyPool, moneyPool) ||
                const DeepCollectionEquality()
                    .equals(other.moneyPool, moneyPool)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.transactionId, transactionId) ||
                const DeepCollectionEquality()
                    .equals(other.transactionId, transactionId)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(transactionsDetails) ^
      const DeepCollectionEquality().hash(paidOutUsersIds) ^
      const DeepCollectionEquality().hash(moneyPool) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(transactionId) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(type);

  @JsonKey(ignore: true)
  @override
  $MoneyPoolPayoutCopyWith<MoneyPoolPayout> get copyWith =>
      _$MoneyPoolPayoutCopyWithImpl<MoneyPoolPayout>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            TransactionDetails transactionDetails,
            String status,
            String transactionId,
            dynamic createdAt,
            TransactionType type)
        peer2peer,
    required TResult Function(
            TransactionDetails transactionDetails,
            String status,
            String transactionId,
            dynamic createdAt,
            TransactionType type)
        donation,
    required TResult Function(
            TransactionDetails transactionDetails,
            String status,
            String transactionId,
            dynamic createdAt,
            TransactionType type)
        moneyPoolContribution,
    required TResult Function(
            List<TransactionDetails> transactionsDetails,
            List<String> paidOutUsersIds,
            MoneyPool moneyPool,
            String status,
            String transactionId,
            dynamic createdAt,
            TransactionType type)
        moneyPoolPayout,
  }) {
    return moneyPoolPayout(transactionsDetails, paidOutUsersIds, moneyPool,
        status, transactionId, createdAt, type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TransactionDetails transactionDetails, String status,
            String transactionId, dynamic createdAt, TransactionType type)?
        peer2peer,
    TResult Function(TransactionDetails transactionDetails, String status,
            String transactionId, dynamic createdAt, TransactionType type)?
        donation,
    TResult Function(TransactionDetails transactionDetails, String status,
            String transactionId, dynamic createdAt, TransactionType type)?
        moneyPoolContribution,
    TResult Function(
            List<TransactionDetails> transactionsDetails,
            List<String> paidOutUsersIds,
            MoneyPool moneyPool,
            String status,
            String transactionId,
            dynamic createdAt,
            TransactionType type)?
        moneyPoolPayout,
    required TResult orElse(),
  }) {
    if (moneyPoolPayout != null) {
      return moneyPoolPayout(transactionsDetails, paidOutUsersIds, moneyPool,
          status, transactionId, createdAt, type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Peer2PeerTransaction value) peer2peer,
    required TResult Function(Donation value) donation,
    required TResult Function(MoneyPoolContribution value)
        moneyPoolContribution,
    required TResult Function(MoneyPoolPayout value) moneyPoolPayout,
  }) {
    return moneyPoolPayout(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Peer2PeerTransaction value)? peer2peer,
    TResult Function(Donation value)? donation,
    TResult Function(MoneyPoolContribution value)? moneyPoolContribution,
    TResult Function(MoneyPoolPayout value)? moneyPoolPayout,
    required TResult orElse(),
  }) {
    if (moneyPoolPayout != null) {
      return moneyPoolPayout(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$MoneyPoolPayoutToJson(this)..['runtimeType'] = 'moneyPoolPayout';
  }
}

abstract class MoneyPoolPayout extends Transaction {
  const factory MoneyPoolPayout(
      {required List<TransactionDetails> transactionsDetails,
      required List<String> paidOutUsersIds,
      required MoneyPool moneyPool,
      required String status,
      required String transactionId,
      required dynamic createdAt,
      TransactionType type}) = _$MoneyPoolPayout;
  const MoneyPoolPayout._() : super._();

  factory MoneyPoolPayout.fromJson(Map<String, dynamic> json) =
      _$MoneyPoolPayout.fromJson;

  List<TransactionDetails> get transactionsDetails =>
      throw _privateConstructorUsedError; // List of user Ids that receive money for easy querying
  List<String> get paidOutUsersIds => throw _privateConstructorUsedError;
  MoneyPool get moneyPool => throw _privateConstructorUsedError;
  @override
  String get status => throw _privateConstructorUsedError;
  @override
  String get transactionId => throw _privateConstructorUsedError;
  @override
  dynamic get createdAt => throw _privateConstructorUsedError;
  @override
  TransactionType get type => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $MoneyPoolPayoutCopyWith<MoneyPoolPayout> get copyWith =>
      throw _privateConstructorUsedError;
}
