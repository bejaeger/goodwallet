// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'money_pool_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MoneyPoolSettings _$MoneyPoolSettingsFromJson(Map<String, dynamic> json) {
  return _MoneyPoolSettings.fromJson(json);
}

/// @nodoc
class _$MoneyPoolSettingsTearOff {
  const _$MoneyPoolSettingsTearOff();

  _MoneyPoolSettings call({required bool showTotal}) {
    return _MoneyPoolSettings(
      showTotal: showTotal,
    );
  }

  MoneyPoolSettings fromJson(Map<String, Object> json) {
    return MoneyPoolSettings.fromJson(json);
  }
}

/// @nodoc
const $MoneyPoolSettings = _$MoneyPoolSettingsTearOff();

/// @nodoc
mixin _$MoneyPoolSettings {
  bool get showTotal => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MoneyPoolSettingsCopyWith<MoneyPoolSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoneyPoolSettingsCopyWith<$Res> {
  factory $MoneyPoolSettingsCopyWith(
          MoneyPoolSettings value, $Res Function(MoneyPoolSettings) then) =
      _$MoneyPoolSettingsCopyWithImpl<$Res>;
  $Res call({bool showTotal});
}

/// @nodoc
class _$MoneyPoolSettingsCopyWithImpl<$Res>
    implements $MoneyPoolSettingsCopyWith<$Res> {
  _$MoneyPoolSettingsCopyWithImpl(this._value, this._then);

  final MoneyPoolSettings _value;
  // ignore: unused_field
  final $Res Function(MoneyPoolSettings) _then;

  @override
  $Res call({
    Object? showTotal = freezed,
  }) {
    return _then(_value.copyWith(
      showTotal: showTotal == freezed
          ? _value.showTotal
          : showTotal // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$MoneyPoolSettingsCopyWith<$Res>
    implements $MoneyPoolSettingsCopyWith<$Res> {
  factory _$MoneyPoolSettingsCopyWith(
          _MoneyPoolSettings value, $Res Function(_MoneyPoolSettings) then) =
      __$MoneyPoolSettingsCopyWithImpl<$Res>;
  @override
  $Res call({bool showTotal});
}

/// @nodoc
class __$MoneyPoolSettingsCopyWithImpl<$Res>
    extends _$MoneyPoolSettingsCopyWithImpl<$Res>
    implements _$MoneyPoolSettingsCopyWith<$Res> {
  __$MoneyPoolSettingsCopyWithImpl(
      _MoneyPoolSettings _value, $Res Function(_MoneyPoolSettings) _then)
      : super(_value, (v) => _then(v as _MoneyPoolSettings));

  @override
  _MoneyPoolSettings get _value => super._value as _MoneyPoolSettings;

  @override
  $Res call({
    Object? showTotal = freezed,
  }) {
    return _then(_MoneyPoolSettings(
      showTotal: showTotal == freezed
          ? _value.showTotal
          : showTotal // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MoneyPoolSettings implements _MoneyPoolSettings {
  _$_MoneyPoolSettings({required this.showTotal});

  factory _$_MoneyPoolSettings.fromJson(Map<String, dynamic> json) =>
      _$_$_MoneyPoolSettingsFromJson(json);

  @override
  final bool showTotal;

  @override
  String toString() {
    return 'MoneyPoolSettings(showTotal: $showTotal)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MoneyPoolSettings &&
            (identical(other.showTotal, showTotal) ||
                const DeepCollectionEquality()
                    .equals(other.showTotal, showTotal)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(showTotal);

  @JsonKey(ignore: true)
  @override
  _$MoneyPoolSettingsCopyWith<_MoneyPoolSettings> get copyWith =>
      __$MoneyPoolSettingsCopyWithImpl<_MoneyPoolSettings>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_MoneyPoolSettingsToJson(this);
  }
}

abstract class _MoneyPoolSettings implements MoneyPoolSettings {
  factory _MoneyPoolSettings({required bool showTotal}) = _$_MoneyPoolSettings;

  factory _MoneyPoolSettings.fromJson(Map<String, dynamic> json) =
      _$_MoneyPoolSettings.fromJson;

  @override
  bool get showTotal => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MoneyPoolSettingsCopyWith<_MoneyPoolSettings> get copyWith =>
      throw _privateConstructorUsedError;
}
