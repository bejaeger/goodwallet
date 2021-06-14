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
      required UserSettings userSettings,
      @JsonKey(toJson: User._checkIfKeywordsAreSet)
          List<String>? searchKeywords}) {
    return _User(
      uid: uid,
      fullName: fullName,
      email: email,
      userSettings: userSettings,
      searchKeywords: searchKeywords,
    );
  }

  _EmptyUser empty(
      {String uid = "",
      String fullName = "",
      String email = "",
      UserSettings? userSettings,
      List<String>? searchKeywords}) {
    return _EmptyUser(
      uid: uid,
      fullName: fullName,
      email: email,
      userSettings: userSettings,
      searchKeywords: searchKeywords,
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
  @JsonKey(toJson: User._checkIfKeywordsAreSet)
  List<String>? get searchKeywords => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String uid,
            String fullName,
            String email,
            UserSettings userSettings,
            @JsonKey(toJson: User._checkIfKeywordsAreSet)
                List<String>? searchKeywords)
        $default, {
    required TResult Function(String uid, String fullName, String email,
            UserSettings? userSettings, List<String>? searchKeywords)
        empty,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String uid,
            String fullName,
            String email,
            UserSettings userSettings,
            @JsonKey(toJson: User._checkIfKeywordsAreSet)
                List<String>? searchKeywords)?
        $default, {
    TResult Function(String uid, String fullName, String email,
            UserSettings? userSettings, List<String>? searchKeywords)?
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
  $Res call(
      {String uid,
      String fullName,
      String email,
      @JsonKey(toJson: User._checkIfKeywordsAreSet)
          List<String>? searchKeywords});
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
    Object? searchKeywords = freezed,
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
      searchKeywords: searchKeywords == freezed
          ? _value.searchKeywords
          : searchKeywords // ignore: cast_nullable_to_non_nullable
              as List<String>?,
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
      UserSettings userSettings,
      @JsonKey(toJson: User._checkIfKeywordsAreSet)
          List<String>? searchKeywords});

  $UserSettingsCopyWith<$Res> get userSettings;
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
    Object? userSettings = freezed,
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
      userSettings: userSettings == freezed
          ? _value.userSettings
          : userSettings // ignore: cast_nullable_to_non_nullable
              as UserSettings,
      searchKeywords: searchKeywords == freezed
          ? _value.searchKeywords
          : searchKeywords // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }

  @override
  $UserSettingsCopyWith<$Res> get userSettings {
    return $UserSettingsCopyWith<$Res>(_value.userSettings, (value) {
      return _then(_value.copyWith(userSettings: value));
    });
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_User implements _User {
  _$_User(
      {required this.uid,
      required this.fullName,
      required this.email,
      required this.userSettings,
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
  final UserSettings userSettings;
  @override
  @JsonKey(toJson: User._checkIfKeywordsAreSet)
  final List<String>? searchKeywords;

  @override
  String toString() {
    return 'User(uid: $uid, fullName: $fullName, email: $email, userSettings: $userSettings, searchKeywords: $searchKeywords)';
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
            (identical(other.userSettings, userSettings) ||
                const DeepCollectionEquality()
                    .equals(other.userSettings, userSettings)) &&
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
      const DeepCollectionEquality().hash(userSettings) ^
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
            UserSettings userSettings,
            @JsonKey(toJson: User._checkIfKeywordsAreSet)
                List<String>? searchKeywords)
        $default, {
    required TResult Function(String uid, String fullName, String email,
            UserSettings? userSettings, List<String>? searchKeywords)
        empty,
  }) {
    return $default(uid, fullName, email, userSettings, searchKeywords);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String uid,
            String fullName,
            String email,
            UserSettings userSettings,
            @JsonKey(toJson: User._checkIfKeywordsAreSet)
                List<String>? searchKeywords)?
        $default, {
    TResult Function(String uid, String fullName, String email,
            UserSettings? userSettings, List<String>? searchKeywords)?
        empty,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(uid, fullName, email, userSettings, searchKeywords);
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
      required UserSettings userSettings,
      @JsonKey(toJson: User._checkIfKeywordsAreSet)
          List<String>? searchKeywords}) = _$_User;

  factory _User.fromJson(Map<String, dynamic> json) = _$_User.fromJson;

  @override
  String get uid => throw _privateConstructorUsedError;
  @override
  String get fullName => throw _privateConstructorUsedError;
  @override
  String get email => throw _privateConstructorUsedError;
  UserSettings get userSettings => throw _privateConstructorUsedError;
  @override
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
      {String uid,
      String fullName,
      String email,
      UserSettings? userSettings,
      List<String>? searchKeywords});

  $UserSettingsCopyWith<$Res>? get userSettings;
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
    Object? userSettings = freezed,
    Object? searchKeywords = freezed,
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
      userSettings: userSettings == freezed
          ? _value.userSettings
          : userSettings // ignore: cast_nullable_to_non_nullable
              as UserSettings?,
      searchKeywords: searchKeywords == freezed
          ? _value.searchKeywords
          : searchKeywords // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }

  @override
  $UserSettingsCopyWith<$Res>? get userSettings {
    if (_value.userSettings == null) {
      return null;
    }

    return $UserSettingsCopyWith<$Res>(_value.userSettings!, (value) {
      return _then(_value.copyWith(userSettings: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$_EmptyUser implements _EmptyUser {
  _$_EmptyUser(
      {this.uid = "",
      this.fullName = "",
      this.email = "",
      this.userSettings,
      this.searchKeywords});

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
  final UserSettings? userSettings;
  @override
  final List<String>? searchKeywords;

  @override
  String toString() {
    return 'User.empty(uid: $uid, fullName: $fullName, email: $email, userSettings: $userSettings, searchKeywords: $searchKeywords)';
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
            (identical(other.userSettings, userSettings) ||
                const DeepCollectionEquality()
                    .equals(other.userSettings, userSettings)) &&
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
      const DeepCollectionEquality().hash(userSettings) ^
      const DeepCollectionEquality().hash(searchKeywords);

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
            UserSettings userSettings,
            @JsonKey(toJson: User._checkIfKeywordsAreSet)
                List<String>? searchKeywords)
        $default, {
    required TResult Function(String uid, String fullName, String email,
            UserSettings? userSettings, List<String>? searchKeywords)
        empty,
  }) {
    return empty(uid, fullName, email, userSettings, searchKeywords);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String uid,
            String fullName,
            String email,
            UserSettings userSettings,
            @JsonKey(toJson: User._checkIfKeywordsAreSet)
                List<String>? searchKeywords)?
        $default, {
    TResult Function(String uid, String fullName, String email,
            UserSettings? userSettings, List<String>? searchKeywords)?
        empty,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(uid, fullName, email, userSettings, searchKeywords);
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
      UserSettings? userSettings,
      List<String>? searchKeywords}) = _$_EmptyUser;

  factory _EmptyUser.fromJson(Map<String, dynamic> json) =
      _$_EmptyUser.fromJson;

  @override
  String get uid => throw _privateConstructorUsedError;
  @override
  String get fullName => throw _privateConstructorUsedError;
  @override
  String get email => throw _privateConstructorUsedError;
  UserSettings? get userSettings => throw _privateConstructorUsedError;
  @override
  List<String>? get searchKeywords => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$EmptyUserCopyWith<_EmptyUser> get copyWith =>
      throw _privateConstructorUsedError;
}
