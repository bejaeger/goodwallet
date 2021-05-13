// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'recipient_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RecipientInfo _$RecipientInfoFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType'] as String) {
    case 'user':
      return UserRecipientInfo.fromJson(json);
    case 'moneyPool':
      return MoneyPoolRecipientInfo.fromJson(json);
    case 'donation':
      return DonationRecipientInfo.fromJson(json);

    default:
      throw FallThroughError();
  }
}

/// @nodoc
class _$RecipientInfoTearOff {
  const _$RecipientInfoTearOff();

  UserRecipientInfo user(
      {required String name, required String id, String? email}) {
    return UserRecipientInfo(
      name: name,
      id: id,
      email: email,
    );
  }

  MoneyPoolRecipientInfo moneyPool(
      {required String name,
      required String id,
      required ConciseMoneyPoolInfo moneyPoolInfo}) {
    return MoneyPoolRecipientInfo(
      name: name,
      id: id,
      moneyPoolInfo: moneyPoolInfo,
    );
  }

  DonationRecipientInfo donation(
      {required String name,
      required String id,
      required ConciseProjectInfo projectInfo}) {
    return DonationRecipientInfo(
      name: name,
      id: id,
      projectInfo: projectInfo,
    );
  }

  RecipientInfo fromJson(Map<String, Object> json) {
    return RecipientInfo.fromJson(json);
  }
}

/// @nodoc
const $RecipientInfo = _$RecipientInfoTearOff();

/// @nodoc
mixin _$RecipientInfo {
  String get name => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, String id, String? email) user,
    required TResult Function(
            String name, String id, ConciseMoneyPoolInfo moneyPoolInfo)
        moneyPool,
    required TResult Function(
            String name, String id, ConciseProjectInfo projectInfo)
        donation,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, String id, String? email)? user,
    TResult Function(
            String name, String id, ConciseMoneyPoolInfo moneyPoolInfo)?
        moneyPool,
    TResult Function(String name, String id, ConciseProjectInfo projectInfo)?
        donation,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserRecipientInfo value) user,
    required TResult Function(MoneyPoolRecipientInfo value) moneyPool,
    required TResult Function(DonationRecipientInfo value) donation,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserRecipientInfo value)? user,
    TResult Function(MoneyPoolRecipientInfo value)? moneyPool,
    TResult Function(DonationRecipientInfo value)? donation,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecipientInfoCopyWith<RecipientInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipientInfoCopyWith<$Res> {
  factory $RecipientInfoCopyWith(
          RecipientInfo value, $Res Function(RecipientInfo) then) =
      _$RecipientInfoCopyWithImpl<$Res>;
  $Res call({String name, String id});
}

/// @nodoc
class _$RecipientInfoCopyWithImpl<$Res>
    implements $RecipientInfoCopyWith<$Res> {
  _$RecipientInfoCopyWithImpl(this._value, this._then);

  final RecipientInfo _value;
  // ignore: unused_field
  final $Res Function(RecipientInfo) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class $UserRecipientInfoCopyWith<$Res>
    implements $RecipientInfoCopyWith<$Res> {
  factory $UserRecipientInfoCopyWith(
          UserRecipientInfo value, $Res Function(UserRecipientInfo) then) =
      _$UserRecipientInfoCopyWithImpl<$Res>;
  @override
  $Res call({String name, String id, String? email});
}

/// @nodoc
class _$UserRecipientInfoCopyWithImpl<$Res>
    extends _$RecipientInfoCopyWithImpl<$Res>
    implements $UserRecipientInfoCopyWith<$Res> {
  _$UserRecipientInfoCopyWithImpl(
      UserRecipientInfo _value, $Res Function(UserRecipientInfo) _then)
      : super(_value, (v) => _then(v as UserRecipientInfo));

  @override
  UserRecipientInfo get _value => super._value as UserRecipientInfo;

  @override
  $Res call({
    Object? name = freezed,
    Object? id = freezed,
    Object? email = freezed,
  }) {
    return _then(UserRecipientInfo(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$UserRecipientInfo implements UserRecipientInfo {
  _$UserRecipientInfo({required this.name, required this.id, this.email});

  factory _$UserRecipientInfo.fromJson(Map<String, dynamic> json) =>
      _$_$UserRecipientInfoFromJson(json);

  @override
  final String name;
  @override
  final String id;
  @override
  final String? email;

  @override
  String toString() {
    return 'RecipientInfo.user(name: $name, id: $id, email: $email)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserRecipientInfo &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(email);

  @JsonKey(ignore: true)
  @override
  $UserRecipientInfoCopyWith<UserRecipientInfo> get copyWith =>
      _$UserRecipientInfoCopyWithImpl<UserRecipientInfo>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, String id, String? email) user,
    required TResult Function(
            String name, String id, ConciseMoneyPoolInfo moneyPoolInfo)
        moneyPool,
    required TResult Function(
            String name, String id, ConciseProjectInfo projectInfo)
        donation,
  }) {
    return user(name, id, email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, String id, String? email)? user,
    TResult Function(
            String name, String id, ConciseMoneyPoolInfo moneyPoolInfo)?
        moneyPool,
    TResult Function(String name, String id, ConciseProjectInfo projectInfo)?
        donation,
    required TResult orElse(),
  }) {
    if (user != null) {
      return user(name, id, email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserRecipientInfo value) user,
    required TResult Function(MoneyPoolRecipientInfo value) moneyPool,
    required TResult Function(DonationRecipientInfo value) donation,
  }) {
    return user(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserRecipientInfo value)? user,
    TResult Function(MoneyPoolRecipientInfo value)? moneyPool,
    TResult Function(DonationRecipientInfo value)? donation,
    required TResult orElse(),
  }) {
    if (user != null) {
      return user(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$UserRecipientInfoToJson(this)..['runtimeType'] = 'user';
  }
}

abstract class UserRecipientInfo implements RecipientInfo {
  factory UserRecipientInfo(
      {required String name,
      required String id,
      String? email}) = _$UserRecipientInfo;

  factory UserRecipientInfo.fromJson(Map<String, dynamic> json) =
      _$UserRecipientInfo.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get id => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $UserRecipientInfoCopyWith<UserRecipientInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoneyPoolRecipientInfoCopyWith<$Res>
    implements $RecipientInfoCopyWith<$Res> {
  factory $MoneyPoolRecipientInfoCopyWith(MoneyPoolRecipientInfo value,
          $Res Function(MoneyPoolRecipientInfo) then) =
      _$MoneyPoolRecipientInfoCopyWithImpl<$Res>;
  @override
  $Res call({String name, String id, ConciseMoneyPoolInfo moneyPoolInfo});

  $ConciseMoneyPoolInfoCopyWith<$Res> get moneyPoolInfo;
}

/// @nodoc
class _$MoneyPoolRecipientInfoCopyWithImpl<$Res>
    extends _$RecipientInfoCopyWithImpl<$Res>
    implements $MoneyPoolRecipientInfoCopyWith<$Res> {
  _$MoneyPoolRecipientInfoCopyWithImpl(MoneyPoolRecipientInfo _value,
      $Res Function(MoneyPoolRecipientInfo) _then)
      : super(_value, (v) => _then(v as MoneyPoolRecipientInfo));

  @override
  MoneyPoolRecipientInfo get _value => super._value as MoneyPoolRecipientInfo;

  @override
  $Res call({
    Object? name = freezed,
    Object? id = freezed,
    Object? moneyPoolInfo = freezed,
  }) {
    return _then(MoneyPoolRecipientInfo(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      moneyPoolInfo: moneyPoolInfo == freezed
          ? _value.moneyPoolInfo
          : moneyPoolInfo // ignore: cast_nullable_to_non_nullable
              as ConciseMoneyPoolInfo,
    ));
  }

  @override
  $ConciseMoneyPoolInfoCopyWith<$Res> get moneyPoolInfo {
    return $ConciseMoneyPoolInfoCopyWith<$Res>(_value.moneyPoolInfo, (value) {
      return _then(_value.copyWith(moneyPoolInfo: value));
    });
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$MoneyPoolRecipientInfo implements MoneyPoolRecipientInfo {
  _$MoneyPoolRecipientInfo(
      {required this.name, required this.id, required this.moneyPoolInfo});

  factory _$MoneyPoolRecipientInfo.fromJson(Map<String, dynamic> json) =>
      _$_$MoneyPoolRecipientInfoFromJson(json);

  @override
  final String name;
  @override
  final String id;
  @override
  final ConciseMoneyPoolInfo moneyPoolInfo;

  @override
  String toString() {
    return 'RecipientInfo.moneyPool(name: $name, id: $id, moneyPoolInfo: $moneyPoolInfo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is MoneyPoolRecipientInfo &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.moneyPoolInfo, moneyPoolInfo) ||
                const DeepCollectionEquality()
                    .equals(other.moneyPoolInfo, moneyPoolInfo)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(moneyPoolInfo);

  @JsonKey(ignore: true)
  @override
  $MoneyPoolRecipientInfoCopyWith<MoneyPoolRecipientInfo> get copyWith =>
      _$MoneyPoolRecipientInfoCopyWithImpl<MoneyPoolRecipientInfo>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, String id, String? email) user,
    required TResult Function(
            String name, String id, ConciseMoneyPoolInfo moneyPoolInfo)
        moneyPool,
    required TResult Function(
            String name, String id, ConciseProjectInfo projectInfo)
        donation,
  }) {
    return moneyPool(name, id, moneyPoolInfo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, String id, String? email)? user,
    TResult Function(
            String name, String id, ConciseMoneyPoolInfo moneyPoolInfo)?
        moneyPool,
    TResult Function(String name, String id, ConciseProjectInfo projectInfo)?
        donation,
    required TResult orElse(),
  }) {
    if (moneyPool != null) {
      return moneyPool(name, id, moneyPoolInfo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserRecipientInfo value) user,
    required TResult Function(MoneyPoolRecipientInfo value) moneyPool,
    required TResult Function(DonationRecipientInfo value) donation,
  }) {
    return moneyPool(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserRecipientInfo value)? user,
    TResult Function(MoneyPoolRecipientInfo value)? moneyPool,
    TResult Function(DonationRecipientInfo value)? donation,
    required TResult orElse(),
  }) {
    if (moneyPool != null) {
      return moneyPool(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$MoneyPoolRecipientInfoToJson(this)
      ..['runtimeType'] = 'moneyPool';
  }
}

abstract class MoneyPoolRecipientInfo implements RecipientInfo {
  factory MoneyPoolRecipientInfo(
      {required String name,
      required String id,
      required ConciseMoneyPoolInfo moneyPoolInfo}) = _$MoneyPoolRecipientInfo;

  factory MoneyPoolRecipientInfo.fromJson(Map<String, dynamic> json) =
      _$MoneyPoolRecipientInfo.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get id => throw _privateConstructorUsedError;
  ConciseMoneyPoolInfo get moneyPoolInfo => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $MoneyPoolRecipientInfoCopyWith<MoneyPoolRecipientInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DonationRecipientInfoCopyWith<$Res>
    implements $RecipientInfoCopyWith<$Res> {
  factory $DonationRecipientInfoCopyWith(DonationRecipientInfo value,
          $Res Function(DonationRecipientInfo) then) =
      _$DonationRecipientInfoCopyWithImpl<$Res>;
  @override
  $Res call({String name, String id, ConciseProjectInfo projectInfo});

  $ConciseProjectInfoCopyWith<$Res> get projectInfo;
}

/// @nodoc
class _$DonationRecipientInfoCopyWithImpl<$Res>
    extends _$RecipientInfoCopyWithImpl<$Res>
    implements $DonationRecipientInfoCopyWith<$Res> {
  _$DonationRecipientInfoCopyWithImpl(
      DonationRecipientInfo _value, $Res Function(DonationRecipientInfo) _then)
      : super(_value, (v) => _then(v as DonationRecipientInfo));

  @override
  DonationRecipientInfo get _value => super._value as DonationRecipientInfo;

  @override
  $Res call({
    Object? name = freezed,
    Object? id = freezed,
    Object? projectInfo = freezed,
  }) {
    return _then(DonationRecipientInfo(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      projectInfo: projectInfo == freezed
          ? _value.projectInfo
          : projectInfo // ignore: cast_nullable_to_non_nullable
              as ConciseProjectInfo,
    ));
  }

  @override
  $ConciseProjectInfoCopyWith<$Res> get projectInfo {
    return $ConciseProjectInfoCopyWith<$Res>(_value.projectInfo, (value) {
      return _then(_value.copyWith(projectInfo: value));
    });
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$DonationRecipientInfo implements DonationRecipientInfo {
  _$DonationRecipientInfo(
      {required this.name, required this.id, required this.projectInfo});

  factory _$DonationRecipientInfo.fromJson(Map<String, dynamic> json) =>
      _$_$DonationRecipientInfoFromJson(json);

  @override
  final String name;
  @override
  final String id;
  @override
  final ConciseProjectInfo projectInfo;

  @override
  String toString() {
    return 'RecipientInfo.donation(name: $name, id: $id, projectInfo: $projectInfo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DonationRecipientInfo &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.projectInfo, projectInfo) ||
                const DeepCollectionEquality()
                    .equals(other.projectInfo, projectInfo)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(projectInfo);

  @JsonKey(ignore: true)
  @override
  $DonationRecipientInfoCopyWith<DonationRecipientInfo> get copyWith =>
      _$DonationRecipientInfoCopyWithImpl<DonationRecipientInfo>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, String id, String? email) user,
    required TResult Function(
            String name, String id, ConciseMoneyPoolInfo moneyPoolInfo)
        moneyPool,
    required TResult Function(
            String name, String id, ConciseProjectInfo projectInfo)
        donation,
  }) {
    return donation(name, id, projectInfo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, String id, String? email)? user,
    TResult Function(
            String name, String id, ConciseMoneyPoolInfo moneyPoolInfo)?
        moneyPool,
    TResult Function(String name, String id, ConciseProjectInfo projectInfo)?
        donation,
    required TResult orElse(),
  }) {
    if (donation != null) {
      return donation(name, id, projectInfo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserRecipientInfo value) user,
    required TResult Function(MoneyPoolRecipientInfo value) moneyPool,
    required TResult Function(DonationRecipientInfo value) donation,
  }) {
    return donation(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserRecipientInfo value)? user,
    TResult Function(MoneyPoolRecipientInfo value)? moneyPool,
    TResult Function(DonationRecipientInfo value)? donation,
    required TResult orElse(),
  }) {
    if (donation != null) {
      return donation(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$DonationRecipientInfoToJson(this)..['runtimeType'] = 'donation';
  }
}

abstract class DonationRecipientInfo implements RecipientInfo {
  factory DonationRecipientInfo(
      {required String name,
      required String id,
      required ConciseProjectInfo projectInfo}) = _$DonationRecipientInfo;

  factory DonationRecipientInfo.fromJson(Map<String, dynamic> json) =
      _$DonationRecipientInfo.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get id => throw _privateConstructorUsedError;
  ConciseProjectInfo get projectInfo => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $DonationRecipientInfoCopyWith<DonationRecipientInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
