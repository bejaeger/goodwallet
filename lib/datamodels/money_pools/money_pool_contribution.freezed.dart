// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'money_pool_contribution.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MoneyPoolContributionModel _$MoneyPoolContributionModelFromJson(
    Map<String, dynamic> json) {
  return _MoneyPoolContributionModel.fromJson(json);
}

/// @nodoc
class _$MoneyPoolContributionModelTearOff {
  const _$MoneyPoolContributionModelTearOff();

  _MoneyPoolContributionModel call(
      {required String moneyPoolId,
      required String moneyPoolName,
      required String uid,
      required String userName,
      required num amount,
      required String currency,
      String? message,
      required dynamic createdAt,
      required String status,
      String? transactionId}) {
    return _MoneyPoolContributionModel(
      moneyPoolId: moneyPoolId,
      moneyPoolName: moneyPoolName,
      uid: uid,
      userName: userName,
      amount: amount,
      currency: currency,
      message: message,
      createdAt: createdAt,
      status: status,
      transactionId: transactionId,
    );
  }

  MoneyPoolContributionModel fromJson(Map<String, Object> json) {
    return MoneyPoolContributionModel.fromJson(json);
  }
}

/// @nodoc
const $MoneyPoolContributionModel = _$MoneyPoolContributionModelTearOff();

/// @nodoc
mixin _$MoneyPoolContributionModel {
  String get moneyPoolId => throw _privateConstructorUsedError;
  String get moneyPoolName => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  num get amount => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  dynamic get createdAt => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get transactionId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MoneyPoolContributionModelCopyWith<MoneyPoolContributionModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoneyPoolContributionModelCopyWith<$Res> {
  factory $MoneyPoolContributionModelCopyWith(MoneyPoolContributionModel value,
          $Res Function(MoneyPoolContributionModel) then) =
      _$MoneyPoolContributionModelCopyWithImpl<$Res>;
  $Res call(
      {String moneyPoolId,
      String moneyPoolName,
      String uid,
      String userName,
      num amount,
      String currency,
      String? message,
      dynamic createdAt,
      String status,
      String? transactionId});
}

/// @nodoc
class _$MoneyPoolContributionModelCopyWithImpl<$Res>
    implements $MoneyPoolContributionModelCopyWith<$Res> {
  _$MoneyPoolContributionModelCopyWithImpl(this._value, this._then);

  final MoneyPoolContributionModel _value;
  // ignore: unused_field
  final $Res Function(MoneyPoolContributionModel) _then;

  @override
  $Res call({
    Object? moneyPoolId = freezed,
    Object? moneyPoolName = freezed,
    Object? uid = freezed,
    Object? userName = freezed,
    Object? amount = freezed,
    Object? currency = freezed,
    Object? message = freezed,
    Object? createdAt = freezed,
    Object? status = freezed,
    Object? transactionId = freezed,
  }) {
    return _then(_value.copyWith(
      moneyPoolId: moneyPoolId == freezed
          ? _value.moneyPoolId
          : moneyPoolId // ignore: cast_nullable_to_non_nullable
              as String,
      moneyPoolName: moneyPoolName == freezed
          ? _value.moneyPoolName
          : moneyPoolName // ignore: cast_nullable_to_non_nullable
              as String,
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as num,
      currency: currency == freezed
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      transactionId: transactionId == freezed
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$MoneyPoolContributionModelCopyWith<$Res>
    implements $MoneyPoolContributionModelCopyWith<$Res> {
  factory _$MoneyPoolContributionModelCopyWith(
          _MoneyPoolContributionModel value,
          $Res Function(_MoneyPoolContributionModel) then) =
      __$MoneyPoolContributionModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String moneyPoolId,
      String moneyPoolName,
      String uid,
      String userName,
      num amount,
      String currency,
      String? message,
      dynamic createdAt,
      String status,
      String? transactionId});
}

/// @nodoc
class __$MoneyPoolContributionModelCopyWithImpl<$Res>
    extends _$MoneyPoolContributionModelCopyWithImpl<$Res>
    implements _$MoneyPoolContributionModelCopyWith<$Res> {
  __$MoneyPoolContributionModelCopyWithImpl(_MoneyPoolContributionModel _value,
      $Res Function(_MoneyPoolContributionModel) _then)
      : super(_value, (v) => _then(v as _MoneyPoolContributionModel));

  @override
  _MoneyPoolContributionModel get _value =>
      super._value as _MoneyPoolContributionModel;

  @override
  $Res call({
    Object? moneyPoolId = freezed,
    Object? moneyPoolName = freezed,
    Object? uid = freezed,
    Object? userName = freezed,
    Object? amount = freezed,
    Object? currency = freezed,
    Object? message = freezed,
    Object? createdAt = freezed,
    Object? status = freezed,
    Object? transactionId = freezed,
  }) {
    return _then(_MoneyPoolContributionModel(
      moneyPoolId: moneyPoolId == freezed
          ? _value.moneyPoolId
          : moneyPoolId // ignore: cast_nullable_to_non_nullable
              as String,
      moneyPoolName: moneyPoolName == freezed
          ? _value.moneyPoolName
          : moneyPoolName // ignore: cast_nullable_to_non_nullable
              as String,
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as num,
      currency: currency == freezed
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      transactionId: transactionId == freezed
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MoneyPoolContributionModel implements _MoneyPoolContributionModel {
  _$_MoneyPoolContributionModel(
      {required this.moneyPoolId,
      required this.moneyPoolName,
      required this.uid,
      required this.userName,
      required this.amount,
      required this.currency,
      this.message,
      required this.createdAt,
      required this.status,
      this.transactionId});

  factory _$_MoneyPoolContributionModel.fromJson(Map<String, dynamic> json) =>
      _$_$_MoneyPoolContributionModelFromJson(json);

  @override
  final String moneyPoolId;
  @override
  final String moneyPoolName;
  @override
  final String uid;
  @override
  final String userName;
  @override
  final num amount;
  @override
  final String currency;
  @override
  final String? message;
  @override
  final dynamic createdAt;
  @override
  final String status;
  @override
  final String? transactionId;

  @override
  String toString() {
    return 'MoneyPoolContributionModel(moneyPoolId: $moneyPoolId, moneyPoolName: $moneyPoolName, uid: $uid, userName: $userName, amount: $amount, currency: $currency, message: $message, createdAt: $createdAt, status: $status, transactionId: $transactionId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MoneyPoolContributionModel &&
            (identical(other.moneyPoolId, moneyPoolId) ||
                const DeepCollectionEquality()
                    .equals(other.moneyPoolId, moneyPoolId)) &&
            (identical(other.moneyPoolName, moneyPoolName) ||
                const DeepCollectionEquality()
                    .equals(other.moneyPoolName, moneyPoolName)) &&
            (identical(other.uid, uid) ||
                const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.userName, userName) ||
                const DeepCollectionEquality()
                    .equals(other.userName, userName)) &&
            (identical(other.amount, amount) ||
                const DeepCollectionEquality().equals(other.amount, amount)) &&
            (identical(other.currency, currency) ||
                const DeepCollectionEquality()
                    .equals(other.currency, currency)) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality()
                    .equals(other.message, message)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.transactionId, transactionId) ||
                const DeepCollectionEquality()
                    .equals(other.transactionId, transactionId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(moneyPoolId) ^
      const DeepCollectionEquality().hash(moneyPoolName) ^
      const DeepCollectionEquality().hash(uid) ^
      const DeepCollectionEquality().hash(userName) ^
      const DeepCollectionEquality().hash(amount) ^
      const DeepCollectionEquality().hash(currency) ^
      const DeepCollectionEquality().hash(message) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(transactionId);

  @JsonKey(ignore: true)
  @override
  _$MoneyPoolContributionModelCopyWith<_MoneyPoolContributionModel>
      get copyWith => __$MoneyPoolContributionModelCopyWithImpl<
          _MoneyPoolContributionModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_MoneyPoolContributionModelToJson(this);
  }
}

abstract class _MoneyPoolContributionModel
    implements MoneyPoolContributionModel {
  factory _MoneyPoolContributionModel(
      {required String moneyPoolId,
      required String moneyPoolName,
      required String uid,
      required String userName,
      required num amount,
      required String currency,
      String? message,
      required dynamic createdAt,
      required String status,
      String? transactionId}) = _$_MoneyPoolContributionModel;

  factory _MoneyPoolContributionModel.fromJson(Map<String, dynamic> json) =
      _$_MoneyPoolContributionModel.fromJson;

  @override
  String get moneyPoolId => throw _privateConstructorUsedError;
  @override
  String get moneyPoolName => throw _privateConstructorUsedError;
  @override
  String get uid => throw _privateConstructorUsedError;
  @override
  String get userName => throw _privateConstructorUsedError;
  @override
  num get amount => throw _privateConstructorUsedError;
  @override
  String get currency => throw _privateConstructorUsedError;
  @override
  String? get message => throw _privateConstructorUsedError;
  @override
  dynamic get createdAt => throw _privateConstructorUsedError;
  @override
  String get status => throw _privateConstructorUsedError;
  @override
  String? get transactionId => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MoneyPoolContributionModelCopyWith<_MoneyPoolContributionModel>
      get copyWith => throw _privateConstructorUsedError;
}
