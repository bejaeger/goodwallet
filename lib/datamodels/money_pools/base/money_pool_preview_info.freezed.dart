// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'money_pool_preview_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MoneyPoolPreviewInfo _$MoneyPoolPreviewInfoFromJson(Map<String, dynamic> json) {
  return _MoneyPoolPreviewInfo.fromJson(json);
}

/// @nodoc
class _$MoneyPoolPreviewInfoTearOff {
  const _$MoneyPoolPreviewInfoTearOff();

  _MoneyPoolPreviewInfo call(
      {required String total,
      required String name,
      required String moneyPoolId}) {
    return _MoneyPoolPreviewInfo(
      total: total,
      name: name,
      moneyPoolId: moneyPoolId,
    );
  }

  MoneyPoolPreviewInfo fromJson(Map<String, Object> json) {
    return MoneyPoolPreviewInfo.fromJson(json);
  }
}

/// @nodoc
const $MoneyPoolPreviewInfo = _$MoneyPoolPreviewInfoTearOff();

/// @nodoc
mixin _$MoneyPoolPreviewInfo {
  String get total => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get moneyPoolId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MoneyPoolPreviewInfoCopyWith<MoneyPoolPreviewInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoneyPoolPreviewInfoCopyWith<$Res> {
  factory $MoneyPoolPreviewInfoCopyWith(MoneyPoolPreviewInfo value,
          $Res Function(MoneyPoolPreviewInfo) then) =
      _$MoneyPoolPreviewInfoCopyWithImpl<$Res>;
  $Res call({String total, String name, String moneyPoolId});
}

/// @nodoc
class _$MoneyPoolPreviewInfoCopyWithImpl<$Res>
    implements $MoneyPoolPreviewInfoCopyWith<$Res> {
  _$MoneyPoolPreviewInfoCopyWithImpl(this._value, this._then);

  final MoneyPoolPreviewInfo _value;
  // ignore: unused_field
  final $Res Function(MoneyPoolPreviewInfo) _then;

  @override
  $Res call({
    Object? total = freezed,
    Object? name = freezed,
    Object? moneyPoolId = freezed,
  }) {
    return _then(_value.copyWith(
      total: total == freezed
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      moneyPoolId: moneyPoolId == freezed
          ? _value.moneyPoolId
          : moneyPoolId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$MoneyPoolPreviewInfoCopyWith<$Res>
    implements $MoneyPoolPreviewInfoCopyWith<$Res> {
  factory _$MoneyPoolPreviewInfoCopyWith(_MoneyPoolPreviewInfo value,
          $Res Function(_MoneyPoolPreviewInfo) then) =
      __$MoneyPoolPreviewInfoCopyWithImpl<$Res>;
  @override
  $Res call({String total, String name, String moneyPoolId});
}

/// @nodoc
class __$MoneyPoolPreviewInfoCopyWithImpl<$Res>
    extends _$MoneyPoolPreviewInfoCopyWithImpl<$Res>
    implements _$MoneyPoolPreviewInfoCopyWith<$Res> {
  __$MoneyPoolPreviewInfoCopyWithImpl(
      _MoneyPoolPreviewInfo _value, $Res Function(_MoneyPoolPreviewInfo) _then)
      : super(_value, (v) => _then(v as _MoneyPoolPreviewInfo));

  @override
  _MoneyPoolPreviewInfo get _value => super._value as _MoneyPoolPreviewInfo;

  @override
  $Res call({
    Object? total = freezed,
    Object? name = freezed,
    Object? moneyPoolId = freezed,
  }) {
    return _then(_MoneyPoolPreviewInfo(
      total: total == freezed
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      moneyPoolId: moneyPoolId == freezed
          ? _value.moneyPoolId
          : moneyPoolId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MoneyPoolPreviewInfo implements _MoneyPoolPreviewInfo {
  _$_MoneyPoolPreviewInfo(
      {required this.total, required this.name, required this.moneyPoolId});

  factory _$_MoneyPoolPreviewInfo.fromJson(Map<String, dynamic> json) =>
      _$_$_MoneyPoolPreviewInfoFromJson(json);

  @override
  final String total;
  @override
  final String name;
  @override
  final String moneyPoolId;

  @override
  String toString() {
    return 'MoneyPoolPreviewInfo(total: $total, name: $name, moneyPoolId: $moneyPoolId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MoneyPoolPreviewInfo &&
            (identical(other.total, total) ||
                const DeepCollectionEquality().equals(other.total, total)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.moneyPoolId, moneyPoolId) ||
                const DeepCollectionEquality()
                    .equals(other.moneyPoolId, moneyPoolId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(total) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(moneyPoolId);

  @JsonKey(ignore: true)
  @override
  _$MoneyPoolPreviewInfoCopyWith<_MoneyPoolPreviewInfo> get copyWith =>
      __$MoneyPoolPreviewInfoCopyWithImpl<_MoneyPoolPreviewInfo>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_MoneyPoolPreviewInfoToJson(this);
  }
}

abstract class _MoneyPoolPreviewInfo implements MoneyPoolPreviewInfo {
  factory _MoneyPoolPreviewInfo(
      {required String total,
      required String name,
      required String moneyPoolId}) = _$_MoneyPoolPreviewInfo;

  factory _MoneyPoolPreviewInfo.fromJson(Map<String, dynamic> json) =
      _$_MoneyPoolPreviewInfo.fromJson;

  @override
  String get total => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get moneyPoolId => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MoneyPoolPreviewInfoCopyWith<_MoneyPoolPreviewInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
