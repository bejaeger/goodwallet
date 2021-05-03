// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'paid_out_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PaidOutUser _$PaidOutUserFromJson(Map<String, dynamic> json) {
  return _PaidOutUser.fromJson(json);
}

/// @nodoc
class _$PaidOutUserTearOff {
  const _$PaidOutUserTearOff();

  _PaidOutUser call(
      {required String uid, required String name, required num amount}) {
    return _PaidOutUser(
      uid: uid,
      name: name,
      amount: amount,
    );
  }

  PaidOutUser fromJson(Map<String, Object> json) {
    return PaidOutUser.fromJson(json);
  }
}

/// @nodoc
const $PaidOutUser = _$PaidOutUserTearOff();

/// @nodoc
mixin _$PaidOutUser {
  String get uid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  num get amount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaidOutUserCopyWith<PaidOutUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaidOutUserCopyWith<$Res> {
  factory $PaidOutUserCopyWith(
          PaidOutUser value, $Res Function(PaidOutUser) then) =
      _$PaidOutUserCopyWithImpl<$Res>;
  $Res call({String uid, String name, num amount});
}

/// @nodoc
class _$PaidOutUserCopyWithImpl<$Res> implements $PaidOutUserCopyWith<$Res> {
  _$PaidOutUserCopyWithImpl(this._value, this._then);

  final PaidOutUser _value;
  // ignore: unused_field
  final $Res Function(PaidOutUser) _then;

  @override
  $Res call({
    Object? uid = freezed,
    Object? name = freezed,
    Object? amount = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc
abstract class _$PaidOutUserCopyWith<$Res>
    implements $PaidOutUserCopyWith<$Res> {
  factory _$PaidOutUserCopyWith(
          _PaidOutUser value, $Res Function(_PaidOutUser) then) =
      __$PaidOutUserCopyWithImpl<$Res>;
  @override
  $Res call({String uid, String name, num amount});
}

/// @nodoc
class __$PaidOutUserCopyWithImpl<$Res> extends _$PaidOutUserCopyWithImpl<$Res>
    implements _$PaidOutUserCopyWith<$Res> {
  __$PaidOutUserCopyWithImpl(
      _PaidOutUser _value, $Res Function(_PaidOutUser) _then)
      : super(_value, (v) => _then(v as _PaidOutUser));

  @override
  _PaidOutUser get _value => super._value as _PaidOutUser;

  @override
  $Res call({
    Object? uid = freezed,
    Object? name = freezed,
    Object? amount = freezed,
  }) {
    return _then(_PaidOutUser(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PaidOutUser implements _PaidOutUser {
  _$_PaidOutUser({required this.uid, required this.name, required this.amount});

  factory _$_PaidOutUser.fromJson(Map<String, dynamic> json) =>
      _$_$_PaidOutUserFromJson(json);

  @override
  final String uid;
  @override
  final String name;
  @override
  final num amount;

  @override
  String toString() {
    return 'PaidOutUser(uid: $uid, name: $name, amount: $amount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PaidOutUser &&
            (identical(other.uid, uid) ||
                const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.amount, amount) ||
                const DeepCollectionEquality().equals(other.amount, amount)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(uid) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(amount);

  @JsonKey(ignore: true)
  @override
  _$PaidOutUserCopyWith<_PaidOutUser> get copyWith =>
      __$PaidOutUserCopyWithImpl<_PaidOutUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_PaidOutUserToJson(this);
  }
}

abstract class _PaidOutUser implements PaidOutUser {
  factory _PaidOutUser(
      {required String uid,
      required String name,
      required num amount}) = _$_PaidOutUser;

  factory _PaidOutUser.fromJson(Map<String, dynamic> json) =
      _$_PaidOutUser.fromJson;

  @override
  String get uid => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  num get amount => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$PaidOutUserCopyWith<_PaidOutUser> get copyWith =>
      throw _privateConstructorUsedError;
}
