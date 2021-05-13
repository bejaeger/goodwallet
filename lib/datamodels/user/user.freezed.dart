// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

User _$UserFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType'] as String) {
    case 'default':
      return _User.fromJson(json);
    case 'empty':
      return _EmptyUser.fromJson(json);

    default:
      throw FallThroughError();
  }
}

/// @nodoc
class _$UserTearOff {
  const _$UserTearOff();

  _User call(
      {required String uid,
      required String fullName,
      required String email,
      @JsonKey(toJson: User._checkIfKeywordsAreSet)
          List<String>? searchKeywords}) {
    return _User(
      uid: uid,
      fullName: fullName,
      email: email,
      searchKeywords: searchKeywords,
    );
  }

  _EmptyUser empty(
      {String uid = "",
      String fullName = "",
      String email = "",
      List<String>? keywordList}) {
    return _EmptyUser(
      uid: uid,
      fullName: fullName,
      email: email,
      keywordList: keywordList,
    );
  }

  User fromJson(Map<String, Object> json) {
    return User.fromJson(json);
  }
}

/// @nodoc
const $User = _$UserTearOff();

/// @nodoc
mixin _$User {
  String get uid => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String uid,
            String fullName,
            String email,
            @JsonKey(toJson: User._checkIfKeywordsAreSet)
                List<String>? searchKeywords)
        $default, {
    required TResult Function(String uid, String fullName, String email,
            List<String>? keywordList)
        empty,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String uid,
            String fullName,
            String email,
            @JsonKey(toJson: User._checkIfKeywordsAreSet)
                List<String>? searchKeywords)?
        $default, {
    TResult Function(String uid, String fullName, String email,
            List<String>? keywordList)?
        empty,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_User value) $default, {
    required TResult Function(_EmptyUser value) empty,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_User value)? $default, {
    TResult Function(_EmptyUser value)? empty,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res>;
  $Res call({String uid, String fullName, String email});
}

/// @nodoc
class _$UserCopyWithImpl<$Res> implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  final User _value;
  // ignore: unused_field
  final $Res Function(User) _then;

  @override
  $Res call({
    Object? uid = freezed,
    Object? fullName = freezed,
    Object? email = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) then) =
      __$UserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String uid,
      String fullName,
      String email,
      @JsonKey(toJson: User._checkIfKeywordsAreSet)
          List<String>? searchKeywords});
}

/// @nodoc
class __$UserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(_User _value, $Res Function(_User) _then)
      : super(_value, (v) => _then(v as _User));

  @override
  _User get _value => super._value as _User;

  @override
  $Res call({
    Object? uid = freezed,
    Object? fullName = freezed,
    Object? email = freezed,
    Object? searchKeywords = freezed,
  }) {
    return _then(_User(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      searchKeywords: searchKeywords == freezed
          ? _value.searchKeywords
          : searchKeywords // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_User implements _User {
  _$_User(
      {required this.uid,
      required this.fullName,
      required this.email,
      @JsonKey(toJson: User._checkIfKeywordsAreSet) this.searchKeywords});

  factory _$_User.fromJson(Map<String, dynamic> json) =>
      _$_$_UserFromJson(json);

  @override
  final String uid;
  @override
  final String fullName;
  @override
  final String email;
  @override
  @JsonKey(toJson: User._checkIfKeywordsAreSet)
  final List<String>? searchKeywords;

  @override
  String toString() {
    return 'User(uid: $uid, fullName: $fullName, email: $email, searchKeywords: $searchKeywords)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _User &&
            (identical(other.uid, uid) ||
                const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.fullName, fullName) ||
                const DeepCollectionEquality()
                    .equals(other.fullName, fullName)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.searchKeywords, searchKeywords) ||
                const DeepCollectionEquality()
                    .equals(other.searchKeywords, searchKeywords)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(uid) ^
      const DeepCollectionEquality().hash(fullName) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(searchKeywords);

  @JsonKey(ignore: true)
  @override
  _$UserCopyWith<_User> get copyWith =>
      __$UserCopyWithImpl<_User>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String uid,
            String fullName,
            String email,
            @JsonKey(toJson: User._checkIfKeywordsAreSet)
                List<String>? searchKeywords)
        $default, {
    required TResult Function(String uid, String fullName, String email,
            List<String>? keywordList)
        empty,
  }) {
    return $default(uid, fullName, email, searchKeywords);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String uid,
            String fullName,
            String email,
            @JsonKey(toJson: User._checkIfKeywordsAreSet)
                List<String>? searchKeywords)?
        $default, {
    TResult Function(String uid, String fullName, String email,
            List<String>? keywordList)?
        empty,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(uid, fullName, email, searchKeywords);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_User value) $default, {
    required TResult Function(_EmptyUser value) empty,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_User value)? $default, {
    TResult Function(_EmptyUser value)? empty,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$_UserToJson(this)..['runtimeType'] = 'default';
  }
}

abstract class _User implements User {
  factory _User(
      {required String uid,
      required String fullName,
      required String email,
      @JsonKey(toJson: User._checkIfKeywordsAreSet)
          List<String>? searchKeywords}) = _$_User;

  factory _User.fromJson(Map<String, dynamic> json) = _$_User.fromJson;

  @override
  String get uid => throw _privateConstructorUsedError;
  @override
  String get fullName => throw _privateConstructorUsedError;
  @override
  String get email => throw _privateConstructorUsedError;
  @JsonKey(toJson: User._checkIfKeywordsAreSet)
  List<String>? get searchKeywords => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$UserCopyWith<_User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$EmptyUserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$EmptyUserCopyWith(
          _EmptyUser value, $Res Function(_EmptyUser) then) =
      __$EmptyUserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String uid, String fullName, String email, List<String>? keywordList});
}

/// @nodoc
class __$EmptyUserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res>
    implements _$EmptyUserCopyWith<$Res> {
  __$EmptyUserCopyWithImpl(_EmptyUser _value, $Res Function(_EmptyUser) _then)
      : super(_value, (v) => _then(v as _EmptyUser));

  @override
  _EmptyUser get _value => super._value as _EmptyUser;

  @override
  $Res call({
    Object? uid = freezed,
    Object? fullName = freezed,
    Object? email = freezed,
    Object? keywordList = freezed,
  }) {
    return _then(_EmptyUser(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      keywordList: keywordList == freezed
          ? _value.keywordList
          : keywordList // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_EmptyUser implements _EmptyUser {
  _$_EmptyUser(
      {this.uid = "", this.fullName = "", this.email = "", this.keywordList});

  factory _$_EmptyUser.fromJson(Map<String, dynamic> json) =>
      _$_$_EmptyUserFromJson(json);

  @JsonKey(defaultValue: "")
  @override
  final String uid;
  @JsonKey(defaultValue: "")
  @override
  final String fullName;
  @JsonKey(defaultValue: "")
  @override
  final String email;
  @override
  final List<String>? keywordList;

  @override
  String toString() {
    return 'User.empty(uid: $uid, fullName: $fullName, email: $email, keywordList: $keywordList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _EmptyUser &&
            (identical(other.uid, uid) ||
                const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.fullName, fullName) ||
                const DeepCollectionEquality()
                    .equals(other.fullName, fullName)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.keywordList, keywordList) ||
                const DeepCollectionEquality()
                    .equals(other.keywordList, keywordList)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(uid) ^
      const DeepCollectionEquality().hash(fullName) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(keywordList);

  @JsonKey(ignore: true)
  @override
  _$EmptyUserCopyWith<_EmptyUser> get copyWith =>
      __$EmptyUserCopyWithImpl<_EmptyUser>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String uid,
            String fullName,
            String email,
            @JsonKey(toJson: User._checkIfKeywordsAreSet)
                List<String>? searchKeywords)
        $default, {
    required TResult Function(String uid, String fullName, String email,
            List<String>? keywordList)
        empty,
  }) {
    return empty(uid, fullName, email, keywordList);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String uid,
            String fullName,
            String email,
            @JsonKey(toJson: User._checkIfKeywordsAreSet)
                List<String>? searchKeywords)?
        $default, {
    TResult Function(String uid, String fullName, String email,
            List<String>? keywordList)?
        empty,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(uid, fullName, email, keywordList);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_User value) $default, {
    required TResult Function(_EmptyUser value) empty,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_User value)? $default, {
    TResult Function(_EmptyUser value)? empty,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$_EmptyUserToJson(this)..['runtimeType'] = 'empty';
  }
}

abstract class _EmptyUser implements User {
  factory _EmptyUser(
      {String uid,
      String fullName,
      String email,
      List<String>? keywordList}) = _$_EmptyUser;

  factory _EmptyUser.fromJson(Map<String, dynamic> json) =
      _$_EmptyUser.fromJson;

  @override
  String get uid => throw _privateConstructorUsedError;
  @override
  String get fullName => throw _privateConstructorUsedError;
  @override
  String get email => throw _privateConstructorUsedError;
  List<String>? get keywordList => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$EmptyUserCopyWith<_EmptyUser> get copyWith =>
      throw _privateConstructorUsedError;
}
