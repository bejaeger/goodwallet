// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'user_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserSettings _$UserSettingsFromJson(Map<String, dynamic> json) {
  return _UserSettings.fromJson(json);
}

/// @nodoc
class _$UserSettingsTearOff {
  const _$UserSettingsTearOff();

  _UserSettings call(
      {List<String>? favoriteProjectIds,
      List<String>? friendsIds,
      bool showEmail = true,
      bool showSummaryStatistics = true,
      bool showDetailedStatistics = true}) {
    return _UserSettings(
      favoriteProjectIds: favoriteProjectIds,
      friendsIds: friendsIds,
      showEmail: showEmail,
      showSummaryStatistics: showSummaryStatistics,
      showDetailedStatistics: showDetailedStatistics,
    );
  }

  UserSettings fromJson(Map<String, Object> json) {
    return UserSettings.fromJson(json);
  }
}

/// @nodoc
const $UserSettings = _$UserSettingsTearOff();

/// @nodoc
mixin _$UserSettings {
  List<String>? get favoriteProjectIds => throw _privateConstructorUsedError;
  List<String>? get friendsIds => throw _privateConstructorUsedError;
  bool get showEmail => throw _privateConstructorUsedError;
  bool get showSummaryStatistics => throw _privateConstructorUsedError;
  bool get showDetailedStatistics => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserSettingsCopyWith<UserSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSettingsCopyWith<$Res> {
  factory $UserSettingsCopyWith(
          UserSettings value, $Res Function(UserSettings) then) =
      _$UserSettingsCopyWithImpl<$Res>;
  $Res call(
      {List<String>? favoriteProjectIds,
      List<String>? friendsIds,
      bool showEmail,
      bool showSummaryStatistics,
      bool showDetailedStatistics});
}

/// @nodoc
class _$UserSettingsCopyWithImpl<$Res> implements $UserSettingsCopyWith<$Res> {
  _$UserSettingsCopyWithImpl(this._value, this._then);

  final UserSettings _value;
  // ignore: unused_field
  final $Res Function(UserSettings) _then;

  @override
  $Res call({
    Object? favoriteProjectIds = freezed,
    Object? friendsIds = freezed,
    Object? showEmail = freezed,
    Object? showSummaryStatistics = freezed,
    Object? showDetailedStatistics = freezed,
  }) {
    return _then(_value.copyWith(
      favoriteProjectIds: favoriteProjectIds == freezed
          ? _value.favoriteProjectIds
          : favoriteProjectIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      friendsIds: friendsIds == freezed
          ? _value.friendsIds
          : friendsIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      showEmail: showEmail == freezed
          ? _value.showEmail
          : showEmail // ignore: cast_nullable_to_non_nullable
              as bool,
      showSummaryStatistics: showSummaryStatistics == freezed
          ? _value.showSummaryStatistics
          : showSummaryStatistics // ignore: cast_nullable_to_non_nullable
              as bool,
      showDetailedStatistics: showDetailedStatistics == freezed
          ? _value.showDetailedStatistics
          : showDetailedStatistics // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$UserSettingsCopyWith<$Res>
    implements $UserSettingsCopyWith<$Res> {
  factory _$UserSettingsCopyWith(
          _UserSettings value, $Res Function(_UserSettings) then) =
      __$UserSettingsCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<String>? favoriteProjectIds,
      List<String>? friendsIds,
      bool showEmail,
      bool showSummaryStatistics,
      bool showDetailedStatistics});
}

/// @nodoc
class __$UserSettingsCopyWithImpl<$Res> extends _$UserSettingsCopyWithImpl<$Res>
    implements _$UserSettingsCopyWith<$Res> {
  __$UserSettingsCopyWithImpl(
      _UserSettings _value, $Res Function(_UserSettings) _then)
      : super(_value, (v) => _then(v as _UserSettings));

  @override
  _UserSettings get _value => super._value as _UserSettings;

  @override
  $Res call({
    Object? favoriteProjectIds = freezed,
    Object? friendsIds = freezed,
    Object? showEmail = freezed,
    Object? showSummaryStatistics = freezed,
    Object? showDetailedStatistics = freezed,
  }) {
    return _then(_UserSettings(
      favoriteProjectIds: favoriteProjectIds == freezed
          ? _value.favoriteProjectIds
          : favoriteProjectIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      friendsIds: friendsIds == freezed
          ? _value.friendsIds
          : friendsIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      showEmail: showEmail == freezed
          ? _value.showEmail
          : showEmail // ignore: cast_nullable_to_non_nullable
              as bool,
      showSummaryStatistics: showSummaryStatistics == freezed
          ? _value.showSummaryStatistics
          : showSummaryStatistics // ignore: cast_nullable_to_non_nullable
              as bool,
      showDetailedStatistics: showDetailedStatistics == freezed
          ? _value.showDetailedStatistics
          : showDetailedStatistics // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserSettings implements _UserSettings {
  _$_UserSettings(
      {this.favoriteProjectIds,
      this.friendsIds,
      this.showEmail = true,
      this.showSummaryStatistics = true,
      this.showDetailedStatistics = true});

  factory _$_UserSettings.fromJson(Map<String, dynamic> json) =>
      _$_$_UserSettingsFromJson(json);

  @override
  final List<String>? favoriteProjectIds;
  @override
  final List<String>? friendsIds;
  @JsonKey(defaultValue: true)
  @override
  final bool showEmail;
  @JsonKey(defaultValue: true)
  @override
  final bool showSummaryStatistics;
  @JsonKey(defaultValue: true)
  @override
  final bool showDetailedStatistics;

  @override
  String toString() {
    return 'UserSettings(favoriteProjectIds: $favoriteProjectIds, friendsIds: $friendsIds, showEmail: $showEmail, showSummaryStatistics: $showSummaryStatistics, showDetailedStatistics: $showDetailedStatistics)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _UserSettings &&
            (identical(other.favoriteProjectIds, favoriteProjectIds) ||
                const DeepCollectionEquality()
                    .equals(other.favoriteProjectIds, favoriteProjectIds)) &&
            (identical(other.friendsIds, friendsIds) ||
                const DeepCollectionEquality()
                    .equals(other.friendsIds, friendsIds)) &&
            (identical(other.showEmail, showEmail) ||
                const DeepCollectionEquality()
                    .equals(other.showEmail, showEmail)) &&
            (identical(other.showSummaryStatistics, showSummaryStatistics) ||
                const DeepCollectionEquality().equals(
                    other.showSummaryStatistics, showSummaryStatistics)) &&
            (identical(other.showDetailedStatistics, showDetailedStatistics) ||
                const DeepCollectionEquality().equals(
                    other.showDetailedStatistics, showDetailedStatistics)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(favoriteProjectIds) ^
      const DeepCollectionEquality().hash(friendsIds) ^
      const DeepCollectionEquality().hash(showEmail) ^
      const DeepCollectionEquality().hash(showSummaryStatistics) ^
      const DeepCollectionEquality().hash(showDetailedStatistics);

  @JsonKey(ignore: true)
  @override
  _$UserSettingsCopyWith<_UserSettings> get copyWith =>
      __$UserSettingsCopyWithImpl<_UserSettings>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_UserSettingsToJson(this);
  }
}

abstract class _UserSettings implements UserSettings {
  factory _UserSettings(
      {List<String>? favoriteProjectIds,
      List<String>? friendsIds,
      bool showEmail,
      bool showSummaryStatistics,
      bool showDetailedStatistics}) = _$_UserSettings;

  factory _UserSettings.fromJson(Map<String, dynamic> json) =
      _$_UserSettings.fromJson;

  @override
  List<String>? get favoriteProjectIds => throw _privateConstructorUsedError;
  @override
  List<String>? get friendsIds => throw _privateConstructorUsedError;
  @override
  bool get showEmail => throw _privateConstructorUsedError;
  @override
  bool get showSummaryStatistics => throw _privateConstructorUsedError;
  @override
  bool get showDetailedStatistics => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$UserSettingsCopyWith<_UserSettings> get copyWith =>
      throw _privateConstructorUsedError;
}
