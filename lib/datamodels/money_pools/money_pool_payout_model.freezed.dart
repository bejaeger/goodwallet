// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'money_pool_payout_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MoneyPoolPayoutModel _$MoneyPoolPayoutModelFromJson(Map<String, dynamic> json) {
  return _MoneyPoolPayoutModel.fromJson(json);
}

/// @nodoc
class _$MoneyPoolPayoutModelTearOff {
  const _$MoneyPoolPayoutModelTearOff();

  _MoneyPoolPayoutModel call(
      {required MoneyPoolModel moneyPool,
      required List<PaidOutUser> paidOutUsers,
      required List<String> paidOutUsersIds,
      String? payoutId,
      String? status,
      bool? keepMoneyPoolAlive}) {
    return _MoneyPoolPayoutModel(
      moneyPool: moneyPool,
      paidOutUsers: paidOutUsers,
      paidOutUsersIds: paidOutUsersIds,
      payoutId: payoutId,
      status: status,
      keepMoneyPoolAlive: keepMoneyPoolAlive,
    );
  }

  MoneyPoolPayoutModel fromJson(Map<String, Object> json) {
    return MoneyPoolPayoutModel.fromJson(json);
  }
}

/// @nodoc
const $MoneyPoolPayoutModel = _$MoneyPoolPayoutModelTearOff();

/// @nodoc
mixin _$MoneyPoolPayoutModel {
// Money pool information
  MoneyPoolModel get moneyPool =>
      throw _privateConstructorUsedError; // List of users and payout amount
  List<PaidOutUser> get paidOutUsers =>
      throw _privateConstructorUsedError; // List of user Ids that receive money
  List<String> get paidOutUsersIds =>
      throw _privateConstructorUsedError; // Id of the document in firestore
//
// Must be set before setting data!
  String? get payoutId =>
      throw _privateConstructorUsedError; // NOT IMPLEMENTED YET
  String? get status =>
      throw _privateConstructorUsedError; // NOT IMPLEMENTED YET
  bool? get keepMoneyPoolAlive => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MoneyPoolPayoutModelCopyWith<MoneyPoolPayoutModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoneyPoolPayoutModelCopyWith<$Res> {
  factory $MoneyPoolPayoutModelCopyWith(MoneyPoolPayoutModel value,
          $Res Function(MoneyPoolPayoutModel) then) =
      _$MoneyPoolPayoutModelCopyWithImpl<$Res>;
  $Res call(
      {MoneyPoolModel moneyPool,
      List<PaidOutUser> paidOutUsers,
      List<String> paidOutUsersIds,
      String? payoutId,
      String? status,
      bool? keepMoneyPoolAlive});
}

/// @nodoc
class _$MoneyPoolPayoutModelCopyWithImpl<$Res>
    implements $MoneyPoolPayoutModelCopyWith<$Res> {
  _$MoneyPoolPayoutModelCopyWithImpl(this._value, this._then);

  final MoneyPoolPayoutModel _value;
  // ignore: unused_field
  final $Res Function(MoneyPoolPayoutModel) _then;

  @override
  $Res call({
    Object? moneyPool = freezed,
    Object? paidOutUsers = freezed,
    Object? paidOutUsersIds = freezed,
    Object? payoutId = freezed,
    Object? status = freezed,
    Object? keepMoneyPoolAlive = freezed,
  }) {
    return _then(_value.copyWith(
      moneyPool: moneyPool == freezed
          ? _value.moneyPool
          : moneyPool // ignore: cast_nullable_to_non_nullable
              as MoneyPoolModel,
      paidOutUsers: paidOutUsers == freezed
          ? _value.paidOutUsers
          : paidOutUsers // ignore: cast_nullable_to_non_nullable
              as List<PaidOutUser>,
      paidOutUsersIds: paidOutUsersIds == freezed
          ? _value.paidOutUsersIds
          : paidOutUsersIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      payoutId: payoutId == freezed
          ? _value.payoutId
          : payoutId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      keepMoneyPoolAlive: keepMoneyPoolAlive == freezed
          ? _value.keepMoneyPoolAlive
          : keepMoneyPoolAlive // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
abstract class _$MoneyPoolPayoutModelCopyWith<$Res>
    implements $MoneyPoolPayoutModelCopyWith<$Res> {
  factory _$MoneyPoolPayoutModelCopyWith(_MoneyPoolPayoutModel value,
          $Res Function(_MoneyPoolPayoutModel) then) =
      __$MoneyPoolPayoutModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {MoneyPoolModel moneyPool,
      List<PaidOutUser> paidOutUsers,
      List<String> paidOutUsersIds,
      String? payoutId,
      String? status,
      bool? keepMoneyPoolAlive});
}

/// @nodoc
class __$MoneyPoolPayoutModelCopyWithImpl<$Res>
    extends _$MoneyPoolPayoutModelCopyWithImpl<$Res>
    implements _$MoneyPoolPayoutModelCopyWith<$Res> {
  __$MoneyPoolPayoutModelCopyWithImpl(
      _MoneyPoolPayoutModel _value, $Res Function(_MoneyPoolPayoutModel) _then)
      : super(_value, (v) => _then(v as _MoneyPoolPayoutModel));

  @override
  _MoneyPoolPayoutModel get _value => super._value as _MoneyPoolPayoutModel;

  @override
  $Res call({
    Object? moneyPool = freezed,
    Object? paidOutUsers = freezed,
    Object? paidOutUsersIds = freezed,
    Object? payoutId = freezed,
    Object? status = freezed,
    Object? keepMoneyPoolAlive = freezed,
  }) {
    return _then(_MoneyPoolPayoutModel(
      moneyPool: moneyPool == freezed
          ? _value.moneyPool
          : moneyPool // ignore: cast_nullable_to_non_nullable
              as MoneyPoolModel,
      paidOutUsers: paidOutUsers == freezed
          ? _value.paidOutUsers
          : paidOutUsers // ignore: cast_nullable_to_non_nullable
              as List<PaidOutUser>,
      paidOutUsersIds: paidOutUsersIds == freezed
          ? _value.paidOutUsersIds
          : paidOutUsersIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      payoutId: payoutId == freezed
          ? _value.payoutId
          : payoutId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      keepMoneyPoolAlive: keepMoneyPoolAlive == freezed
          ? _value.keepMoneyPoolAlive
          : keepMoneyPoolAlive // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_MoneyPoolPayoutModel implements _MoneyPoolPayoutModel {
  _$_MoneyPoolPayoutModel(
      {required this.moneyPool,
      required this.paidOutUsers,
      required this.paidOutUsersIds,
      this.payoutId,
      this.status,
      this.keepMoneyPoolAlive});

  factory _$_MoneyPoolPayoutModel.fromJson(Map<String, dynamic> json) =>
      _$_$_MoneyPoolPayoutModelFromJson(json);

  @override // Money pool information
  final MoneyPoolModel moneyPool;
  @override // List of users and payout amount
  final List<PaidOutUser> paidOutUsers;
  @override // List of user Ids that receive money
  final List<String> paidOutUsersIds;
  @override // Id of the document in firestore
//
// Must be set before setting data!
  final String? payoutId;
  @override // NOT IMPLEMENTED YET
  final String? status;
  @override // NOT IMPLEMENTED YET
  final bool? keepMoneyPoolAlive;

  @override
  String toString() {
    return 'MoneyPoolPayoutModel(moneyPool: $moneyPool, paidOutUsers: $paidOutUsers, paidOutUsersIds: $paidOutUsersIds, payoutId: $payoutId, status: $status, keepMoneyPoolAlive: $keepMoneyPoolAlive)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MoneyPoolPayoutModel &&
            (identical(other.moneyPool, moneyPool) ||
                const DeepCollectionEquality()
                    .equals(other.moneyPool, moneyPool)) &&
            (identical(other.paidOutUsers, paidOutUsers) ||
                const DeepCollectionEquality()
                    .equals(other.paidOutUsers, paidOutUsers)) &&
            (identical(other.paidOutUsersIds, paidOutUsersIds) ||
                const DeepCollectionEquality()
                    .equals(other.paidOutUsersIds, paidOutUsersIds)) &&
            (identical(other.payoutId, payoutId) ||
                const DeepCollectionEquality()
                    .equals(other.payoutId, payoutId)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.keepMoneyPoolAlive, keepMoneyPoolAlive) ||
                const DeepCollectionEquality()
                    .equals(other.keepMoneyPoolAlive, keepMoneyPoolAlive)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(moneyPool) ^
      const DeepCollectionEquality().hash(paidOutUsers) ^
      const DeepCollectionEquality().hash(paidOutUsersIds) ^
      const DeepCollectionEquality().hash(payoutId) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(keepMoneyPoolAlive);

  @JsonKey(ignore: true)
  @override
  _$MoneyPoolPayoutModelCopyWith<_MoneyPoolPayoutModel> get copyWith =>
      __$MoneyPoolPayoutModelCopyWithImpl<_MoneyPoolPayoutModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_MoneyPoolPayoutModelToJson(this);
  }
}

abstract class _MoneyPoolPayoutModel implements MoneyPoolPayoutModel {
  factory _MoneyPoolPayoutModel(
      {required MoneyPoolModel moneyPool,
      required List<PaidOutUser> paidOutUsers,
      required List<String> paidOutUsersIds,
      String? payoutId,
      String? status,
      bool? keepMoneyPoolAlive}) = _$_MoneyPoolPayoutModel;

  factory _MoneyPoolPayoutModel.fromJson(Map<String, dynamic> json) =
      _$_MoneyPoolPayoutModel.fromJson;

  @override // Money pool information
  MoneyPoolModel get moneyPool => throw _privateConstructorUsedError;
  @override // List of users and payout amount
  List<PaidOutUser> get paidOutUsers => throw _privateConstructorUsedError;
  @override // List of user Ids that receive money
  List<String> get paidOutUsersIds => throw _privateConstructorUsedError;
  @override // Id of the document in firestore
//
// Must be set before setting data!
  String? get payoutId => throw _privateConstructorUsedError;
  @override // NOT IMPLEMENTED YET
  String? get status => throw _privateConstructorUsedError;
  @override // NOT IMPLEMENTED YET
  bool? get keepMoneyPoolAlive => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MoneyPoolPayoutModelCopyWith<_MoneyPoolPayoutModel> get copyWith =>
      throw _privateConstructorUsedError;
}
