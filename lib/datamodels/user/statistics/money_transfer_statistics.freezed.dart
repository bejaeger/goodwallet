// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'money_transfer_statistics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MoneyTransferStatistics _$MoneyTransferStatisticsFromJson(
    Map<String, dynamic> json) {
  return _MoneyTransferStatistics.fromJson(json);
}

/// @nodoc
class _$MoneyTransferStatisticsTearOff {
  const _$MoneyTransferStatisticsTearOff();

  _MoneyTransferStatistics call(
      {required num totalTransferredToPeers, required num totalRaised}) {
    return _MoneyTransferStatistics(
      totalTransferredToPeers: totalTransferredToPeers,
      totalRaised: totalRaised,
    );
  }

  MoneyTransferStatistics fromJson(Map<String, Object> json) {
    return MoneyTransferStatistics.fromJson(json);
  }
}

/// @nodoc
const $MoneyTransferStatistics = _$MoneyTransferStatisticsTearOff();

/// @nodoc
mixin _$MoneyTransferStatistics {
  num get totalTransferredToPeers => throw _privateConstructorUsedError;
  num get totalRaised => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MoneyTransferStatisticsCopyWith<MoneyTransferStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoneyTransferStatisticsCopyWith<$Res> {
  factory $MoneyTransferStatisticsCopyWith(MoneyTransferStatistics value,
          $Res Function(MoneyTransferStatistics) then) =
      _$MoneyTransferStatisticsCopyWithImpl<$Res>;
  $Res call({num totalTransferredToPeers, num totalRaised});
}

/// @nodoc
class _$MoneyTransferStatisticsCopyWithImpl<$Res>
    implements $MoneyTransferStatisticsCopyWith<$Res> {
  _$MoneyTransferStatisticsCopyWithImpl(this._value, this._then);

  final MoneyTransferStatistics _value;
  // ignore: unused_field
  final $Res Function(MoneyTransferStatistics) _then;

  @override
  $Res call({
    Object? totalTransferredToPeers = freezed,
    Object? totalRaised = freezed,
  }) {
    return _then(_value.copyWith(
      totalTransferredToPeers: totalTransferredToPeers == freezed
          ? _value.totalTransferredToPeers
          : totalTransferredToPeers // ignore: cast_nullable_to_non_nullable
              as num,
      totalRaised: totalRaised == freezed
          ? _value.totalRaised
          : totalRaised // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc
abstract class _$MoneyTransferStatisticsCopyWith<$Res>
    implements $MoneyTransferStatisticsCopyWith<$Res> {
  factory _$MoneyTransferStatisticsCopyWith(_MoneyTransferStatistics value,
          $Res Function(_MoneyTransferStatistics) then) =
      __$MoneyTransferStatisticsCopyWithImpl<$Res>;
  @override
  $Res call({num totalTransferredToPeers, num totalRaised});
}

/// @nodoc
class __$MoneyTransferStatisticsCopyWithImpl<$Res>
    extends _$MoneyTransferStatisticsCopyWithImpl<$Res>
    implements _$MoneyTransferStatisticsCopyWith<$Res> {
  __$MoneyTransferStatisticsCopyWithImpl(_MoneyTransferStatistics _value,
      $Res Function(_MoneyTransferStatistics) _then)
      : super(_value, (v) => _then(v as _MoneyTransferStatistics));

  @override
  _MoneyTransferStatistics get _value =>
      super._value as _MoneyTransferStatistics;

  @override
  $Res call({
    Object? totalTransferredToPeers = freezed,
    Object? totalRaised = freezed,
  }) {
    return _then(_MoneyTransferStatistics(
      totalTransferredToPeers: totalTransferredToPeers == freezed
          ? _value.totalTransferredToPeers
          : totalTransferredToPeers // ignore: cast_nullable_to_non_nullable
              as num,
      totalRaised: totalRaised == freezed
          ? _value.totalRaised
          : totalRaised // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MoneyTransferStatistics implements _MoneyTransferStatistics {
  _$_MoneyTransferStatistics(
      {required this.totalTransferredToPeers, required this.totalRaised});

  factory _$_MoneyTransferStatistics.fromJson(Map<String, dynamic> json) =>
      _$_$_MoneyTransferStatisticsFromJson(json);

  @override
  final num totalTransferredToPeers;
  @override
  final num totalRaised;

  @override
  String toString() {
    return 'MoneyTransferStatistics(totalTransferredToPeers: $totalTransferredToPeers, totalRaised: $totalRaised)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MoneyTransferStatistics &&
            (identical(
                    other.totalTransferredToPeers, totalTransferredToPeers) ||
                const DeepCollectionEquality().equals(
                    other.totalTransferredToPeers, totalTransferredToPeers)) &&
            (identical(other.totalRaised, totalRaised) ||
                const DeepCollectionEquality()
                    .equals(other.totalRaised, totalRaised)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(totalTransferredToPeers) ^
      const DeepCollectionEquality().hash(totalRaised);

  @JsonKey(ignore: true)
  @override
  _$MoneyTransferStatisticsCopyWith<_MoneyTransferStatistics> get copyWith =>
      __$MoneyTransferStatisticsCopyWithImpl<_MoneyTransferStatistics>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_MoneyTransferStatisticsToJson(this);
  }
}

abstract class _MoneyTransferStatistics implements MoneyTransferStatistics {
  factory _MoneyTransferStatistics(
      {required num totalTransferredToPeers,
      required num totalRaised}) = _$_MoneyTransferStatistics;

  factory _MoneyTransferStatistics.fromJson(Map<String, dynamic> json) =
      _$_MoneyTransferStatistics.fromJson;

  @override
  num get totalTransferredToPeers => throw _privateConstructorUsedError;
  @override
  num get totalRaised => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MoneyTransferStatisticsCopyWith<_MoneyTransferStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}
