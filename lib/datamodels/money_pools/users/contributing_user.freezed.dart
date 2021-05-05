// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'contributing_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ContributingUser _$ContributingUserFromJson(Map<String, dynamic> json) {
  return _ContributingUser.fromJson(json);
}

/// @nodoc
class _$ContributingUserTearOff {
  const _$ContributingUserTearOff();

  _ContributingUser call(
      {required String name, required String uid, num contribution = 0}) {
    return _ContributingUser(
      name: name,
      uid: uid,
      contribution: contribution,
    );
  }

  ContributingUser fromJson(Map<String, Object> json) {
    return ContributingUser.fromJson(json);
  }
}

/// @nodoc
const $ContributingUser = _$ContributingUserTearOff();

/// @nodoc
mixin _$ContributingUser {
  String get name => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  num get contribution => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ContributingUserCopyWith<ContributingUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContributingUserCopyWith<$Res> {
  factory $ContributingUserCopyWith(
          ContributingUser value, $Res Function(ContributingUser) then) =
      _$ContributingUserCopyWithImpl<$Res>;
  $Res call({String name, String uid, num contribution});
}

/// @nodoc
class _$ContributingUserCopyWithImpl<$Res>
    implements $ContributingUserCopyWith<$Res> {
  _$ContributingUserCopyWithImpl(this._value, this._then);

  final ContributingUser _value;
  // ignore: unused_field
  final $Res Function(ContributingUser) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? uid = freezed,
    Object? contribution = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      contribution: contribution == freezed
          ? _value.contribution
          : contribution // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc
abstract class _$ContributingUserCopyWith<$Res>
    implements $ContributingUserCopyWith<$Res> {
  factory _$ContributingUserCopyWith(
          _ContributingUser value, $Res Function(_ContributingUser) then) =
      __$ContributingUserCopyWithImpl<$Res>;
  @override
  $Res call({String name, String uid, num contribution});
}

/// @nodoc
class __$ContributingUserCopyWithImpl<$Res>
    extends _$ContributingUserCopyWithImpl<$Res>
    implements _$ContributingUserCopyWith<$Res> {
  __$ContributingUserCopyWithImpl(
      _ContributingUser _value, $Res Function(_ContributingUser) _then)
      : super(_value, (v) => _then(v as _ContributingUser));

  @override
  _ContributingUser get _value => super._value as _ContributingUser;

  @override
  $Res call({
    Object? name = freezed,
    Object? uid = freezed,
    Object? contribution = freezed,
  }) {
    return _then(_ContributingUser(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      contribution: contribution == freezed
          ? _value.contribution
          : contribution // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ContributingUser implements _ContributingUser {
  _$_ContributingUser(
      {required this.name, required this.uid, this.contribution = 0});

  factory _$_ContributingUser.fromJson(Map<String, dynamic> json) =>
      _$_$_ContributingUserFromJson(json);

  @override
  final String name;
  @override
  final String uid;
  @JsonKey(defaultValue: 0)
  @override
  final num contribution;

  @override
  String toString() {
    return 'ContributingUser(name: $name, uid: $uid, contribution: $contribution)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ContributingUser &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.uid, uid) ||
                const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.contribution, contribution) ||
                const DeepCollectionEquality()
                    .equals(other.contribution, contribution)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(uid) ^
      const DeepCollectionEquality().hash(contribution);

  @JsonKey(ignore: true)
  @override
  _$ContributingUserCopyWith<_ContributingUser> get copyWith =>
      __$ContributingUserCopyWithImpl<_ContributingUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ContributingUserToJson(this);
  }
}

abstract class _ContributingUser implements ContributingUser {
  factory _ContributingUser(
      {required String name,
      required String uid,
      num contribution}) = _$_ContributingUser;

  factory _ContributingUser.fromJson(Map<String, dynamic> json) =
      _$_ContributingUser.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get uid => throw _privateConstructorUsedError;
  @override
  num get contribution => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ContributingUserCopyWith<_ContributingUser> get copyWith =>
      throw _privateConstructorUsedError;
}
