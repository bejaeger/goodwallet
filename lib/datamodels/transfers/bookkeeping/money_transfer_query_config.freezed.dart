// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'money_transfer_query_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MoneyTransferQueryConfig _$MoneyTransferQueryConfigFromJson(
    Map<String, dynamic> json) {
  return _MoneyTransferQueryConfig.fromJson(json);
}

/// @nodoc
class _$MoneyTransferQueryConfigTearOff {
  const _$MoneyTransferQueryConfigTearOff();

  _MoneyTransferQueryConfig call(
      {required TransferType type,
      Map<String, String>? isEqualToFilter,
      int? maxNumberReturns,
      bool? makeUniqueRecipient}) {
    return _MoneyTransferQueryConfig(
      type: type,
      isEqualToFilter: isEqualToFilter,
      maxNumberReturns: maxNumberReturns,
      makeUniqueRecipient: makeUniqueRecipient,
    );
  }

  MoneyTransferQueryConfig fromJson(Map<String, Object> json) {
    return MoneyTransferQueryConfig.fromJson(json);
  }
}

/// @nodoc
const $MoneyTransferQueryConfig = _$MoneyTransferQueryConfigTearOff();

/// @nodoc
mixin _$MoneyTransferQueryConfig {
  TransferType get type => throw _privateConstructorUsedError;
  Map<String, String>? get isEqualToFilter =>
      throw _privateConstructorUsedError; // e.g. {"moneyPoolInfo.moneyPoolId": moneyPool.moneyPoolId},
  int? get maxNumberReturns => throw _privateConstructorUsedError;
  bool? get makeUniqueRecipient => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MoneyTransferQueryConfigCopyWith<MoneyTransferQueryConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoneyTransferQueryConfigCopyWith<$Res> {
  factory $MoneyTransferQueryConfigCopyWith(MoneyTransferQueryConfig value,
          $Res Function(MoneyTransferQueryConfig) then) =
      _$MoneyTransferQueryConfigCopyWithImpl<$Res>;
  $Res call(
      {TransferType type,
      Map<String, String>? isEqualToFilter,
      int? maxNumberReturns,
      bool? makeUniqueRecipient});
}

/// @nodoc
class _$MoneyTransferQueryConfigCopyWithImpl<$Res>
    implements $MoneyTransferQueryConfigCopyWith<$Res> {
  _$MoneyTransferQueryConfigCopyWithImpl(this._value, this._then);

  final MoneyTransferQueryConfig _value;
  // ignore: unused_field
  final $Res Function(MoneyTransferQueryConfig) _then;

  @override
  $Res call({
    Object? type = freezed,
    Object? isEqualToFilter = freezed,
    Object? maxNumberReturns = freezed,
    Object? makeUniqueRecipient = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TransferType,
      isEqualToFilter: isEqualToFilter == freezed
          ? _value.isEqualToFilter
          : isEqualToFilter // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      maxNumberReturns: maxNumberReturns == freezed
          ? _value.maxNumberReturns
          : maxNumberReturns // ignore: cast_nullable_to_non_nullable
              as int?,
      makeUniqueRecipient: makeUniqueRecipient == freezed
          ? _value.makeUniqueRecipient
          : makeUniqueRecipient // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
abstract class _$MoneyTransferQueryConfigCopyWith<$Res>
    implements $MoneyTransferQueryConfigCopyWith<$Res> {
  factory _$MoneyTransferQueryConfigCopyWith(_MoneyTransferQueryConfig value,
          $Res Function(_MoneyTransferQueryConfig) then) =
      __$MoneyTransferQueryConfigCopyWithImpl<$Res>;
  @override
  $Res call(
      {TransferType type,
      Map<String, String>? isEqualToFilter,
      int? maxNumberReturns,
      bool? makeUniqueRecipient});
}

/// @nodoc
class __$MoneyTransferQueryConfigCopyWithImpl<$Res>
    extends _$MoneyTransferQueryConfigCopyWithImpl<$Res>
    implements _$MoneyTransferQueryConfigCopyWith<$Res> {
  __$MoneyTransferQueryConfigCopyWithImpl(_MoneyTransferQueryConfig _value,
      $Res Function(_MoneyTransferQueryConfig) _then)
      : super(_value, (v) => _then(v as _MoneyTransferQueryConfig));

  @override
  _MoneyTransferQueryConfig get _value =>
      super._value as _MoneyTransferQueryConfig;

  @override
  $Res call({
    Object? type = freezed,
    Object? isEqualToFilter = freezed,
    Object? maxNumberReturns = freezed,
    Object? makeUniqueRecipient = freezed,
  }) {
    return _then(_MoneyTransferQueryConfig(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TransferType,
      isEqualToFilter: isEqualToFilter == freezed
          ? _value.isEqualToFilter
          : isEqualToFilter // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      maxNumberReturns: maxNumberReturns == freezed
          ? _value.maxNumberReturns
          : maxNumberReturns // ignore: cast_nullable_to_non_nullable
              as int?,
      makeUniqueRecipient: makeUniqueRecipient == freezed
          ? _value.makeUniqueRecipient
          : makeUniqueRecipient // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MoneyTransferQueryConfig implements _MoneyTransferQueryConfig {
  const _$_MoneyTransferQueryConfig(
      {required this.type,
      this.isEqualToFilter,
      this.maxNumberReturns,
      this.makeUniqueRecipient});

  factory _$_MoneyTransferQueryConfig.fromJson(Map<String, dynamic> json) =>
      _$_$_MoneyTransferQueryConfigFromJson(json);

  @override
  final TransferType type;
  @override
  final Map<String, String>? isEqualToFilter;
  @override // e.g. {"moneyPoolInfo.moneyPoolId": moneyPool.moneyPoolId},
  final int? maxNumberReturns;
  @override
  final bool? makeUniqueRecipient;

  @override
  String toString() {
    return 'MoneyTransferQueryConfig(type: $type, isEqualToFilter: $isEqualToFilter, maxNumberReturns: $maxNumberReturns, makeUniqueRecipient: $makeUniqueRecipient)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MoneyTransferQueryConfig &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.isEqualToFilter, isEqualToFilter) ||
                const DeepCollectionEquality()
                    .equals(other.isEqualToFilter, isEqualToFilter)) &&
            (identical(other.maxNumberReturns, maxNumberReturns) ||
                const DeepCollectionEquality()
                    .equals(other.maxNumberReturns, maxNumberReturns)) &&
            (identical(other.makeUniqueRecipient, makeUniqueRecipient) ||
                const DeepCollectionEquality()
                    .equals(other.makeUniqueRecipient, makeUniqueRecipient)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(isEqualToFilter) ^
      const DeepCollectionEquality().hash(maxNumberReturns) ^
      const DeepCollectionEquality().hash(makeUniqueRecipient);

  @JsonKey(ignore: true)
  @override
  _$MoneyTransferQueryConfigCopyWith<_MoneyTransferQueryConfig> get copyWith =>
      __$MoneyTransferQueryConfigCopyWithImpl<_MoneyTransferQueryConfig>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_MoneyTransferQueryConfigToJson(this);
  }
}

abstract class _MoneyTransferQueryConfig implements MoneyTransferQueryConfig {
  const factory _MoneyTransferQueryConfig(
      {required TransferType type,
      Map<String, String>? isEqualToFilter,
      int? maxNumberReturns,
      bool? makeUniqueRecipient}) = _$_MoneyTransferQueryConfig;

  factory _MoneyTransferQueryConfig.fromJson(Map<String, dynamic> json) =
      _$_MoneyTransferQueryConfig.fromJson;

  @override
  TransferType get type => throw _privateConstructorUsedError;
  @override
  Map<String, String>? get isEqualToFilter =>
      throw _privateConstructorUsedError;
  @override // e.g. {"moneyPoolInfo.moneyPoolId": moneyPool.moneyPoolId},
  int? get maxNumberReturns => throw _privateConstructorUsedError;
  @override
  bool? get makeUniqueRecipient => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MoneyTransferQueryConfigCopyWith<_MoneyTransferQueryConfig> get copyWith =>
      throw _privateConstructorUsedError;
}
