// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'money_pool_payout.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MoneyPoolPayout _$MoneyPoolPayoutFromJson(Map<String, dynamic> json) {
  return _MoneyPoolPayout.fromJson(json);
}

/// @nodoc
class _$MoneyPoolPayoutTearOff {
  const _$MoneyPoolPayoutTearOff();

  _MoneyPoolPayout call(
      {required List<TransferDetails> transfersDetails,
      required List<String> paidOutUsersIds,
      required MoneyPool moneyPool,
      dynamic createdAt = "",
      TransferStatus status = TransferStatus.Initialized,
      @JsonKey(name: "payoutId") String payoutId = "placeholder",
      bool deleteMoneyPool = true}) {
    return _MoneyPoolPayout(
      transfersDetails: transfersDetails,
      paidOutUsersIds: paidOutUsersIds,
      moneyPool: moneyPool,
      createdAt: createdAt,
      status: status,
      payoutId: payoutId,
      deleteMoneyPool: deleteMoneyPool,
    );
  }

  MoneyPoolPayout fromJson(Map<String, Object> json) {
    return MoneyPoolPayout.fromJson(json);
  }
}

/// @nodoc
const $MoneyPoolPayout = _$MoneyPoolPayoutTearOff();

/// @nodoc
mixin _$MoneyPoolPayout {
  List<TransferDetails> get transfersDetails =>
      throw _privateConstructorUsedError;
  List<String> get paidOutUsersIds => throw _privateConstructorUsedError;
  MoneyPool get moneyPool => throw _privateConstructorUsedError;
  dynamic get createdAt => throw _privateConstructorUsedError;
  TransferStatus get status => throw _privateConstructorUsedError;
  @JsonKey(name: "payoutId")
  String get payoutId => throw _privateConstructorUsedError;
  bool get deleteMoneyPool => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MoneyPoolPayoutCopyWith<MoneyPoolPayout> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoneyPoolPayoutCopyWith<$Res> {
  factory $MoneyPoolPayoutCopyWith(
          MoneyPoolPayout value, $Res Function(MoneyPoolPayout) then) =
      _$MoneyPoolPayoutCopyWithImpl<$Res>;
  $Res call(
      {List<TransferDetails> transfersDetails,
      List<String> paidOutUsersIds,
      MoneyPool moneyPool,
      dynamic createdAt,
      TransferStatus status,
      @JsonKey(name: "payoutId") String payoutId,
      bool deleteMoneyPool});

  $MoneyPoolCopyWith<$Res> get moneyPool;
}

/// @nodoc
class _$MoneyPoolPayoutCopyWithImpl<$Res>
    implements $MoneyPoolPayoutCopyWith<$Res> {
  _$MoneyPoolPayoutCopyWithImpl(this._value, this._then);

  final MoneyPoolPayout _value;
  // ignore: unused_field
  final $Res Function(MoneyPoolPayout) _then;

  @override
  $Res call({
    Object? transfersDetails = freezed,
    Object? paidOutUsersIds = freezed,
    Object? moneyPool = freezed,
    Object? createdAt = freezed,
    Object? status = freezed,
    Object? payoutId = freezed,
    Object? deleteMoneyPool = freezed,
  }) {
    return _then(_value.copyWith(
      transfersDetails: transfersDetails == freezed
          ? _value.transfersDetails
          : transfersDetails // ignore: cast_nullable_to_non_nullable
              as List<TransferDetails>,
      paidOutUsersIds: paidOutUsersIds == freezed
          ? _value.paidOutUsersIds
          : paidOutUsersIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      moneyPool: moneyPool == freezed
          ? _value.moneyPool
          : moneyPool // ignore: cast_nullable_to_non_nullable
              as MoneyPool,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TransferStatus,
      payoutId: payoutId == freezed
          ? _value.payoutId
          : payoutId // ignore: cast_nullable_to_non_nullable
              as String,
      deleteMoneyPool: deleteMoneyPool == freezed
          ? _value.deleteMoneyPool
          : deleteMoneyPool // ignore: cast_nullable_to_non_nullable
              as bool,
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
abstract class _$MoneyPoolPayoutCopyWith<$Res>
    implements $MoneyPoolPayoutCopyWith<$Res> {
  factory _$MoneyPoolPayoutCopyWith(
          _MoneyPoolPayout value, $Res Function(_MoneyPoolPayout) then) =
      __$MoneyPoolPayoutCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<TransferDetails> transfersDetails,
      List<String> paidOutUsersIds,
      MoneyPool moneyPool,
      dynamic createdAt,
      TransferStatus status,
      @JsonKey(name: "payoutId") String payoutId,
      bool deleteMoneyPool});

  @override
  $MoneyPoolCopyWith<$Res> get moneyPool;
}

/// @nodoc
class __$MoneyPoolPayoutCopyWithImpl<$Res>
    extends _$MoneyPoolPayoutCopyWithImpl<$Res>
    implements _$MoneyPoolPayoutCopyWith<$Res> {
  __$MoneyPoolPayoutCopyWithImpl(
      _MoneyPoolPayout _value, $Res Function(_MoneyPoolPayout) _then)
      : super(_value, (v) => _then(v as _MoneyPoolPayout));

  @override
  _MoneyPoolPayout get _value => super._value as _MoneyPoolPayout;

  @override
  $Res call({
    Object? transfersDetails = freezed,
    Object? paidOutUsersIds = freezed,
    Object? moneyPool = freezed,
    Object? createdAt = freezed,
    Object? status = freezed,
    Object? payoutId = freezed,
    Object? deleteMoneyPool = freezed,
  }) {
    return _then(_MoneyPoolPayout(
      transfersDetails: transfersDetails == freezed
          ? _value.transfersDetails
          : transfersDetails // ignore: cast_nullable_to_non_nullable
              as List<TransferDetails>,
      paidOutUsersIds: paidOutUsersIds == freezed
          ? _value.paidOutUsersIds
          : paidOutUsersIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      moneyPool: moneyPool == freezed
          ? _value.moneyPool
          : moneyPool // ignore: cast_nullable_to_non_nullable
              as MoneyPool,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TransferStatus,
      payoutId: payoutId == freezed
          ? _value.payoutId
          : payoutId // ignore: cast_nullable_to_non_nullable
              as String,
      deleteMoneyPool: deleteMoneyPool == freezed
          ? _value.deleteMoneyPool
          : deleteMoneyPool // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_MoneyPoolPayout implements _MoneyPoolPayout {
  _$_MoneyPoolPayout(
      {required this.transfersDetails,
      required this.paidOutUsersIds,
      required this.moneyPool,
      this.createdAt = "",
      this.status = TransferStatus.Initialized,
      @JsonKey(name: "payoutId") this.payoutId = "placeholder",
      this.deleteMoneyPool = true});

  factory _$_MoneyPoolPayout.fromJson(Map<String, dynamic> json) =>
      _$_$_MoneyPoolPayoutFromJson(json);

  @override
  final List<TransferDetails> transfersDetails;
  @override
  final List<String> paidOutUsersIds;
  @override
  final MoneyPool moneyPool;
  @JsonKey(defaultValue: "")
  @override
  final dynamic createdAt;
  @JsonKey(defaultValue: TransferStatus.Initialized)
  @override
  final TransferStatus status;
  @override
  @JsonKey(name: "payoutId")
  final String payoutId;
  @JsonKey(defaultValue: true)
  @override
  final bool deleteMoneyPool;

  @override
  String toString() {
    return 'MoneyPoolPayout(transfersDetails: $transfersDetails, paidOutUsersIds: $paidOutUsersIds, moneyPool: $moneyPool, createdAt: $createdAt, status: $status, payoutId: $payoutId, deleteMoneyPool: $deleteMoneyPool)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MoneyPoolPayout &&
            (identical(other.transfersDetails, transfersDetails) ||
                const DeepCollectionEquality()
                    .equals(other.transfersDetails, transfersDetails)) &&
            (identical(other.paidOutUsersIds, paidOutUsersIds) ||
                const DeepCollectionEquality()
                    .equals(other.paidOutUsersIds, paidOutUsersIds)) &&
            (identical(other.moneyPool, moneyPool) ||
                const DeepCollectionEquality()
                    .equals(other.moneyPool, moneyPool)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.payoutId, payoutId) ||
                const DeepCollectionEquality()
                    .equals(other.payoutId, payoutId)) &&
            (identical(other.deleteMoneyPool, deleteMoneyPool) ||
                const DeepCollectionEquality()
                    .equals(other.deleteMoneyPool, deleteMoneyPool)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(transfersDetails) ^
      const DeepCollectionEquality().hash(paidOutUsersIds) ^
      const DeepCollectionEquality().hash(moneyPool) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(payoutId) ^
      const DeepCollectionEquality().hash(deleteMoneyPool);

  @JsonKey(ignore: true)
  @override
  _$MoneyPoolPayoutCopyWith<_MoneyPoolPayout> get copyWith =>
      __$MoneyPoolPayoutCopyWithImpl<_MoneyPoolPayout>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_MoneyPoolPayoutToJson(this);
  }
}

abstract class _MoneyPoolPayout implements MoneyPoolPayout {
  factory _MoneyPoolPayout(
      {required List<TransferDetails> transfersDetails,
      required List<String> paidOutUsersIds,
      required MoneyPool moneyPool,
      dynamic createdAt,
      TransferStatus status,
      @JsonKey(name: "payoutId") String payoutId,
      bool deleteMoneyPool}) = _$_MoneyPoolPayout;

  factory _MoneyPoolPayout.fromJson(Map<String, dynamic> json) =
      _$_MoneyPoolPayout.fromJson;

  @override
  List<TransferDetails> get transfersDetails =>
      throw _privateConstructorUsedError;
  @override
  List<String> get paidOutUsersIds => throw _privateConstructorUsedError;
  @override
  MoneyPool get moneyPool => throw _privateConstructorUsedError;
  @override
  dynamic get createdAt => throw _privateConstructorUsedError;
  @override
  TransferStatus get status => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "payoutId")
  String get payoutId => throw _privateConstructorUsedError;
  @override
  bool get deleteMoneyPool => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MoneyPoolPayoutCopyWith<_MoneyPoolPayout> get copyWith =>
      throw _privateConstructorUsedError;
}
