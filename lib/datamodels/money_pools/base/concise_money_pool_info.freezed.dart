// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'concise_money_pool_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ConciseMoneyPoolInfo _$ConciseMoneyPoolInfoFromJson(Map<String, dynamic> json) {
  return _MoneyPoolPreviewInfo.fromJson(json);
}

/// @nodoc
class _$ConciseMoneyPoolInfoTearOff {
  const _$ConciseMoneyPoolInfoTearOff();

  _MoneyPoolPreviewInfo call(
      {required num total, required String name, required String moneyPoolId}) {
    return _MoneyPoolPreviewInfo(
      total: total,
      name: name,
      moneyPoolId: moneyPoolId,
    );
  }

  ConciseMoneyPoolInfo fromJson(Map<String, Object> json) {
    return ConciseMoneyPoolInfo.fromJson(json);
  }
}

/// @nodoc
const $ConciseMoneyPoolInfo = _$ConciseMoneyPoolInfoTearOff();

/// @nodoc
mixin _$ConciseMoneyPoolInfo {
  num get total => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get moneyPoolId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConciseMoneyPoolInfoCopyWith<ConciseMoneyPoolInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConciseMoneyPoolInfoCopyWith<$Res> {
  factory $ConciseMoneyPoolInfoCopyWith(ConciseMoneyPoolInfo value,
          $Res Function(ConciseMoneyPoolInfo) then) =
      _$ConciseMoneyPoolInfoCopyWithImpl<$Res>;
  $Res call({num total, String name, String moneyPoolId});
}

/// @nodoc
class _$ConciseMoneyPoolInfoCopyWithImpl<$Res>
    implements $ConciseMoneyPoolInfoCopyWith<$Res> {
  _$ConciseMoneyPoolInfoCopyWithImpl(this._value, this._then);

  final ConciseMoneyPoolInfo _value;
  // ignore: unused_field
  final $Res Function(ConciseMoneyPoolInfo) _then;

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
              as num,
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
    implements $ConciseMoneyPoolInfoCopyWith<$Res> {
  factory _$MoneyPoolPreviewInfoCopyWith(_MoneyPoolPreviewInfo value,
          $Res Function(_MoneyPoolPreviewInfo) then) =
      __$MoneyPoolPreviewInfoCopyWithImpl<$Res>;
  @override
  $Res call({num total, String name, String moneyPoolId});
}

/// @nodoc
class __$MoneyPoolPreviewInfoCopyWithImpl<$Res>
    extends _$ConciseMoneyPoolInfoCopyWithImpl<$Res>
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
              as num,
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
  final num total;
  @override
  final String name;
  @override
  final String moneyPoolId;

  @override
  String toString() {
    return 'ConciseMoneyPoolInfo(total: $total, name: $name, moneyPoolId: $moneyPoolId)';
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

abstract class _MoneyPoolPreviewInfo implements ConciseMoneyPoolInfo {
  factory _MoneyPoolPreviewInfo(
      {required num total,
      required String name,
      required String moneyPoolId}) = _$_MoneyPoolPreviewInfo;

  factory _MoneyPoolPreviewInfo.fromJson(Map<String, dynamic> json) =
      _$_MoneyPoolPreviewInfo.fromJson;

  @override
  num get total => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get moneyPoolId => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MoneyPoolPreviewInfoCopyWith<_MoneyPoolPreviewInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
