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
      required dynamic createdAt,
      TransferType type = TransferType.MoneyPoolPayout,
      TransferStatus status = TransferStatus.Initialized,
      @JsonKey(name: "transferId", toJson: MoneyPoolPayout._checkIftransferIdIsSet)
          String transferId = "placeholder"}) {
    return _MoneyPoolPayout(
      transfersDetails: transfersDetails,
      paidOutUsersIds: paidOutUsersIds,
      moneyPool: moneyPool,
      createdAt: createdAt,
      type: type,
      status: status,
      transferId: transferId,
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
  TransferType get type => throw _privateConstructorUsedError;
  TransferStatus get status => throw _privateConstructorUsedError;
  @JsonKey(name: "transferId", toJson: MoneyPoolPayout._checkIftransferIdIsSet)
  String get transferId => throw _privateConstructorUsedError;

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
      TransferType type,
      TransferStatus status,
      @JsonKey(name: "transferId", toJson: MoneyPoolPayout._checkIftransferIdIsSet)
          String transferId});

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
    Object? type = freezed,
    Object? status = freezed,
    Object? transferId = freezed,
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
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TransferType,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TransferStatus,
      transferId: transferId == freezed
          ? _value.transferId
          : transferId // ignore: cast_nullable_to_non_nullable
              as String,
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
      TransferType type,
      TransferStatus status,
      @JsonKey(name: "transferId", toJson: MoneyPoolPayout._checkIftransferIdIsSet)
          String transferId});

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
    Object? type = freezed,
    Object? status = freezed,
    Object? transferId = freezed,
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
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TransferType,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TransferStatus,
      transferId: transferId == freezed
          ? _value.transferId
          : transferId // ignore: cast_nullable_to_non_nullable
              as String,
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
      required this.createdAt,
      this.type = TransferType.MoneyPoolPayout,
      this.status = TransferStatus.Initialized,
      @JsonKey(name: "transferId", toJson: MoneyPoolPayout._checkIftransferIdIsSet)
          this.transferId = "placeholder"});

  factory _$_MoneyPoolPayout.fromJson(Map<String, dynamic> json) =>
      _$_$_MoneyPoolPayoutFromJson(json);

  @override
  final List<TransferDetails> transfersDetails;
  @override
  final List<String> paidOutUsersIds;
  @override
  final MoneyPool moneyPool;
  @override
  final dynamic createdAt;
  @JsonKey(defaultValue: TransferType.MoneyPoolPayout)
  @override
  final TransferType type;
  @JsonKey(defaultValue: TransferStatus.Initialized)
  @override
  final TransferStatus status;
  @override
  @JsonKey(name: "transferId", toJson: MoneyPoolPayout._checkIftransferIdIsSet)
  final String transferId;

  @override
  String toString() {
    return 'MoneyPoolPayout(transfersDetails: $transfersDetails, paidOutUsersIds: $paidOutUsersIds, moneyPool: $moneyPool, createdAt: $createdAt, type: $type, status: $status, transferId: $transferId)';
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
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.transferId, transferId) ||
                const DeepCollectionEquality()
                    .equals(other.transferId, transferId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(transfersDetails) ^
      const DeepCollectionEquality().hash(paidOutUsersIds) ^
      const DeepCollectionEquality().hash(moneyPool) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(transferId);

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
      required dynamic createdAt,
      TransferType type,
      TransferStatus status,
      @JsonKey(name: "transferId", toJson: MoneyPoolPayout._checkIftransferIdIsSet)
          String transferId}) = _$_MoneyPoolPayout;

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
  TransferType get type => throw _privateConstructorUsedError;
  @override
  TransferStatus get status => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "transferId", toJson: MoneyPoolPayout._checkIftransferIdIsSet)
  String get transferId => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MoneyPoolPayoutCopyWith<_MoneyPoolPayout> get copyWith =>
      throw _privateConstructorUsedError;
}
