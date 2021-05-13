// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'money_pool.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MoneyPool _$MoneyPoolFromJson(Map<String, dynamic> json) {
  return _MoneyPool.fromJson(json);
}

/// @nodoc
class _$MoneyPoolTearOff {
  const _$MoneyPoolTearOff();

  _MoneyPool call(
      {required num total,
      required String name,
      required String adminUID,
      required String adminName,
      required String currency,
      String? description,
      required MoneyPoolSettings moneyPoolSettings,
      required dynamic createdAt,
      required List<ContributingUser> contributingUsers,
      required List<PublicUserInfo> invitedUsers,
      required List<String> contributingUserIds,
      required List<String> invitedUserIds,
      @JsonKey(name: "moneyPoolId", toJson: MoneyPool._checkIfMoneyPoolIdIsSet)
          String moneyPoolId = "placeholder"}) {
    return _MoneyPool(
      total: total,
      name: name,
      adminUID: adminUID,
      adminName: adminName,
      currency: currency,
      description: description,
      moneyPoolSettings: moneyPoolSettings,
      createdAt: createdAt,
      contributingUsers: contributingUsers,
      invitedUsers: invitedUsers,
      contributingUserIds: contributingUserIds,
      invitedUserIds: invitedUserIds,
      moneyPoolId: moneyPoolId,
    );
  }

  MoneyPool fromJson(Map<String, Object> json) {
    return MoneyPool.fromJson(json);
  }
}

/// @nodoc
const $MoneyPool = _$MoneyPoolTearOff();

/// @nodoc
mixin _$MoneyPool {
  num get total => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get adminUID => throw _privateConstructorUsedError;
  String get adminName => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  MoneyPoolSettings get moneyPoolSettings => throw _privateConstructorUsedError;
  dynamic get createdAt => throw _privateConstructorUsedError;
  List<ContributingUser> get contributingUsers =>
      throw _privateConstructorUsedError;
  List<PublicUserInfo> get invitedUsers =>
      throw _privateConstructorUsedError; // for querying purposes
  List<String> get contributingUserIds => throw _privateConstructorUsedError;
  List<String> get invitedUserIds => throw _privateConstructorUsedError;
  @JsonKey(name: "moneyPoolId", toJson: MoneyPool._checkIfMoneyPoolIdIsSet)
  String get moneyPoolId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MoneyPoolCopyWith<MoneyPool> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoneyPoolCopyWith<$Res> {
  factory $MoneyPoolCopyWith(MoneyPool value, $Res Function(MoneyPool) then) =
      _$MoneyPoolCopyWithImpl<$Res>;
  $Res call(
      {num total,
      String name,
      String adminUID,
      String adminName,
      String currency,
      String? description,
      MoneyPoolSettings moneyPoolSettings,
      dynamic createdAt,
      List<ContributingUser> contributingUsers,
      List<PublicUserInfo> invitedUsers,
      List<String> contributingUserIds,
      List<String> invitedUserIds,
      @JsonKey(name: "moneyPoolId", toJson: MoneyPool._checkIfMoneyPoolIdIsSet)
          String moneyPoolId});

  $MoneyPoolSettingsCopyWith<$Res> get moneyPoolSettings;
}

/// @nodoc
class _$MoneyPoolCopyWithImpl<$Res> implements $MoneyPoolCopyWith<$Res> {
  _$MoneyPoolCopyWithImpl(this._value, this._then);

  final MoneyPool _value;
  // ignore: unused_field
  final $Res Function(MoneyPool) _then;

  @override
  $Res call({
    Object? total = freezed,
    Object? name = freezed,
    Object? adminUID = freezed,
    Object? adminName = freezed,
    Object? currency = freezed,
    Object? description = freezed,
    Object? moneyPoolSettings = freezed,
    Object? createdAt = freezed,
    Object? contributingUsers = freezed,
    Object? invitedUsers = freezed,
    Object? contributingUserIds = freezed,
    Object? invitedUserIds = freezed,
    Object? moneyPoolId = freezed,
  }) {
    return _then(_value.copyWith(
      total: total == freezed
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as num,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      adminUID: adminUID == freezed
          ? _value.adminUID
          : adminUID // ignore: cast_nullable_to_non_nullable
              as String,
      adminName: adminName == freezed
          ? _value.adminName
          : adminName // ignore: cast_nullable_to_non_nullable
              as String,
      currency: currency == freezed
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      moneyPoolSettings: moneyPoolSettings == freezed
          ? _value.moneyPoolSettings
          : moneyPoolSettings // ignore: cast_nullable_to_non_nullable
              as MoneyPoolSettings,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      contributingUsers: contributingUsers == freezed
          ? _value.contributingUsers
          : contributingUsers // ignore: cast_nullable_to_non_nullable
              as List<ContributingUser>,
      invitedUsers: invitedUsers == freezed
          ? _value.invitedUsers
          : invitedUsers // ignore: cast_nullable_to_non_nullable
              as List<PublicUserInfo>,
      contributingUserIds: contributingUserIds == freezed
          ? _value.contributingUserIds
          : contributingUserIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      invitedUserIds: invitedUserIds == freezed
          ? _value.invitedUserIds
          : invitedUserIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      moneyPoolId: moneyPoolId == freezed
          ? _value.moneyPoolId
          : moneyPoolId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  $MoneyPoolSettingsCopyWith<$Res> get moneyPoolSettings {
    return $MoneyPoolSettingsCopyWith<$Res>(_value.moneyPoolSettings, (value) {
      return _then(_value.copyWith(moneyPoolSettings: value));
    });
  }
}

/// @nodoc
abstract class _$MoneyPoolCopyWith<$Res> implements $MoneyPoolCopyWith<$Res> {
  factory _$MoneyPoolCopyWith(
          _MoneyPool value, $Res Function(_MoneyPool) then) =
      __$MoneyPoolCopyWithImpl<$Res>;
  @override
  $Res call(
      {num total,
      String name,
      String adminUID,
      String adminName,
      String currency,
      String? description,
      MoneyPoolSettings moneyPoolSettings,
      dynamic createdAt,
      List<ContributingUser> contributingUsers,
      List<PublicUserInfo> invitedUsers,
      List<String> contributingUserIds,
      List<String> invitedUserIds,
      @JsonKey(name: "moneyPoolId", toJson: MoneyPool._checkIfMoneyPoolIdIsSet)
          String moneyPoolId});

  @override
  $MoneyPoolSettingsCopyWith<$Res> get moneyPoolSettings;
}

/// @nodoc
class __$MoneyPoolCopyWithImpl<$Res> extends _$MoneyPoolCopyWithImpl<$Res>
    implements _$MoneyPoolCopyWith<$Res> {
  __$MoneyPoolCopyWithImpl(_MoneyPool _value, $Res Function(_MoneyPool) _then)
      : super(_value, (v) => _then(v as _MoneyPool));

  @override
  _MoneyPool get _value => super._value as _MoneyPool;

  @override
  $Res call({
    Object? total = freezed,
    Object? name = freezed,
    Object? adminUID = freezed,
    Object? adminName = freezed,
    Object? currency = freezed,
    Object? description = freezed,
    Object? moneyPoolSettings = freezed,
    Object? createdAt = freezed,
    Object? contributingUsers = freezed,
    Object? invitedUsers = freezed,
    Object? contributingUserIds = freezed,
    Object? invitedUserIds = freezed,
    Object? moneyPoolId = freezed,
  }) {
    return _then(_MoneyPool(
      total: total == freezed
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as num,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      adminUID: adminUID == freezed
          ? _value.adminUID
          : adminUID // ignore: cast_nullable_to_non_nullable
              as String,
      adminName: adminName == freezed
          ? _value.adminName
          : adminName // ignore: cast_nullable_to_non_nullable
              as String,
      currency: currency == freezed
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      moneyPoolSettings: moneyPoolSettings == freezed
          ? _value.moneyPoolSettings
          : moneyPoolSettings // ignore: cast_nullable_to_non_nullable
              as MoneyPoolSettings,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      contributingUsers: contributingUsers == freezed
          ? _value.contributingUsers
          : contributingUsers // ignore: cast_nullable_to_non_nullable
              as List<ContributingUser>,
      invitedUsers: invitedUsers == freezed
          ? _value.invitedUsers
          : invitedUsers // ignore: cast_nullable_to_non_nullable
              as List<PublicUserInfo>,
      contributingUserIds: contributingUserIds == freezed
          ? _value.contributingUserIds
          : contributingUserIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      invitedUserIds: invitedUserIds == freezed
          ? _value.invitedUserIds
          : invitedUserIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      moneyPoolId: moneyPoolId == freezed
          ? _value.moneyPoolId
          : moneyPoolId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_MoneyPool implements _MoneyPool {
  _$_MoneyPool(
      {required this.total,
      required this.name,
      required this.adminUID,
      required this.adminName,
      required this.currency,
      this.description,
      required this.moneyPoolSettings,
      required this.createdAt,
      required this.contributingUsers,
      required this.invitedUsers,
      required this.contributingUserIds,
      required this.invitedUserIds,
      @JsonKey(name: "moneyPoolId", toJson: MoneyPool._checkIfMoneyPoolIdIsSet)
          this.moneyPoolId = "placeholder"});

  factory _$_MoneyPool.fromJson(Map<String, dynamic> json) =>
      _$_$_MoneyPoolFromJson(json);

  @override
  final num total;
  @override
  final String name;
  @override
  final String adminUID;
  @override
  final String adminName;
  @override
  final String currency;
  @override
  final String? description;
  @override
  final MoneyPoolSettings moneyPoolSettings;
  @override
  final dynamic createdAt;
  @override
  final List<ContributingUser> contributingUsers;
  @override
  final List<PublicUserInfo> invitedUsers;
  @override // for querying purposes
  final List<String> contributingUserIds;
  @override
  final List<String> invitedUserIds;
  @override
  @JsonKey(name: "moneyPoolId", toJson: MoneyPool._checkIfMoneyPoolIdIsSet)
  final String moneyPoolId;

  @override
  String toString() {
    return 'MoneyPool(total: $total, name: $name, adminUID: $adminUID, adminName: $adminName, currency: $currency, description: $description, moneyPoolSettings: $moneyPoolSettings, createdAt: $createdAt, contributingUsers: $contributingUsers, invitedUsers: $invitedUsers, contributingUserIds: $contributingUserIds, invitedUserIds: $invitedUserIds, moneyPoolId: $moneyPoolId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MoneyPool &&
            (identical(other.total, total) ||
                const DeepCollectionEquality().equals(other.total, total)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.adminUID, adminUID) ||
                const DeepCollectionEquality()
                    .equals(other.adminUID, adminUID)) &&
            (identical(other.adminName, adminName) ||
                const DeepCollectionEquality()
                    .equals(other.adminName, adminName)) &&
            (identical(other.currency, currency) ||
                const DeepCollectionEquality()
                    .equals(other.currency, currency)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.moneyPoolSettings, moneyPoolSettings) ||
                const DeepCollectionEquality()
                    .equals(other.moneyPoolSettings, moneyPoolSettings)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.contributingUsers, contributingUsers) ||
                const DeepCollectionEquality()
                    .equals(other.contributingUsers, contributingUsers)) &&
            (identical(other.invitedUsers, invitedUsers) ||
                const DeepCollectionEquality()
                    .equals(other.invitedUsers, invitedUsers)) &&
            (identical(other.contributingUserIds, contributingUserIds) ||
                const DeepCollectionEquality()
                    .equals(other.contributingUserIds, contributingUserIds)) &&
            (identical(other.invitedUserIds, invitedUserIds) ||
                const DeepCollectionEquality()
                    .equals(other.invitedUserIds, invitedUserIds)) &&
            (identical(other.moneyPoolId, moneyPoolId) ||
                const DeepCollectionEquality()
                    .equals(other.moneyPoolId, moneyPoolId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(total) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(adminUID) ^
      const DeepCollectionEquality().hash(adminName) ^
      const DeepCollectionEquality().hash(currency) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(moneyPoolSettings) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(contributingUsers) ^
      const DeepCollectionEquality().hash(invitedUsers) ^
      const DeepCollectionEquality().hash(contributingUserIds) ^
      const DeepCollectionEquality().hash(invitedUserIds) ^
      const DeepCollectionEquality().hash(moneyPoolId);

  @JsonKey(ignore: true)
  @override
  _$MoneyPoolCopyWith<_MoneyPool> get copyWith =>
      __$MoneyPoolCopyWithImpl<_MoneyPool>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_MoneyPoolToJson(this);
  }
}

abstract class _MoneyPool implements MoneyPool {
  factory _MoneyPool(
      {required num total,
      required String name,
      required String adminUID,
      required String adminName,
      required String currency,
      String? description,
      required MoneyPoolSettings moneyPoolSettings,
      required dynamic createdAt,
      required List<ContributingUser> contributingUsers,
      required List<PublicUserInfo> invitedUsers,
      required List<String> contributingUserIds,
      required List<String> invitedUserIds,
      @JsonKey(name: "moneyPoolId", toJson: MoneyPool._checkIfMoneyPoolIdIsSet)
          String moneyPoolId}) = _$_MoneyPool;

  factory _MoneyPool.fromJson(Map<String, dynamic> json) =
      _$_MoneyPool.fromJson;

  @override
  num get total => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get adminUID => throw _privateConstructorUsedError;
  @override
  String get adminName => throw _privateConstructorUsedError;
  @override
  String get currency => throw _privateConstructorUsedError;
  @override
  String? get description => throw _privateConstructorUsedError;
  @override
  MoneyPoolSettings get moneyPoolSettings => throw _privateConstructorUsedError;
  @override
  dynamic get createdAt => throw _privateConstructorUsedError;
  @override
  List<ContributingUser> get contributingUsers =>
      throw _privateConstructorUsedError;
  @override
  List<PublicUserInfo> get invitedUsers => throw _privateConstructorUsedError;
  @override // for querying purposes
  List<String> get contributingUserIds => throw _privateConstructorUsedError;
  @override
  List<String> get invitedUserIds => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "moneyPoolId", toJson: MoneyPool._checkIfMoneyPoolIdIsSet)
  String get moneyPoolId => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MoneyPoolCopyWith<_MoneyPool> get copyWith =>
      throw _privateConstructorUsedError;
}
