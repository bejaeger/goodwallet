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
  switch (json['runtimeType'] as String) {
    case 'default':
      return _MoneyTransferStatistics.fromJson(json);
    case 'empty':
      return _EmptyMoneyTransferStatistics.fromJson(json);

    default:
      throw FallThroughError();
  }
}

/// @nodoc
class _$MoneyTransferStatisticsTearOff {
  const _$MoneyTransferStatisticsTearOff();

  _MoneyTransferStatistics call(
      {required num totalSentToPeers,
      required num totalRaised,
      required num totalRaisedViaMoneyPool,
      required num totalRaisedViaPeer2Peer,
      required num totalRaisedViaSubsidiaryApp}) {
    return _MoneyTransferStatistics(
      totalSentToPeers: totalSentToPeers,
      totalRaised: totalRaised,
      totalRaisedViaMoneyPool: totalRaisedViaMoneyPool,
      totalRaisedViaPeer2Peer: totalRaisedViaPeer2Peer,
      totalRaisedViaSubsidiaryApp: totalRaisedViaSubsidiaryApp,
    );
  }

  _EmptyMoneyTransferStatistics empty(
      {num totalSentToPeers = 0, num totalRaised = 0}) {
    return _EmptyMoneyTransferStatistics(
      totalSentToPeers: totalSentToPeers,
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
  num get totalSentToPeers => throw _privateConstructorUsedError;
  num get totalRaised => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            num totalSentToPeers,
            num totalRaised,
            num totalRaisedViaMoneyPool,
            num totalRaisedViaPeer2Peer,
            num totalRaisedViaSubsidiaryApp)
        $default, {
    required TResult Function(num totalSentToPeers, num totalRaised) empty,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            num totalSentToPeers,
            num totalRaised,
            num totalRaisedViaMoneyPool,
            num totalRaisedViaPeer2Peer,
            num totalRaisedViaSubsidiaryApp)?
        $default, {
    TResult Function(num totalSentToPeers, num totalRaised)? empty,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_MoneyTransferStatistics value) $default, {
    required TResult Function(_EmptyMoneyTransferStatistics value) empty,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_MoneyTransferStatistics value)? $default, {
    TResult Function(_EmptyMoneyTransferStatistics value)? empty,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
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
  $Res call({num totalSentToPeers, num totalRaised});
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
    Object? totalSentToPeers = freezed,
    Object? totalRaised = freezed,
  }) {
    return _then(_value.copyWith(
      totalSentToPeers: totalSentToPeers == freezed
          ? _value.totalSentToPeers
          : totalSentToPeers // ignore: cast_nullable_to_non_nullable
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
  $Res call(
      {num totalSentToPeers,
      num totalRaised,
      num totalRaisedViaMoneyPool,
      num totalRaisedViaPeer2Peer,
      num totalRaisedViaSubsidiaryApp});
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
    Object? totalSentToPeers = freezed,
    Object? totalRaised = freezed,
    Object? totalRaisedViaMoneyPool = freezed,
    Object? totalRaisedViaPeer2Peer = freezed,
    Object? totalRaisedViaSubsidiaryApp = freezed,
  }) {
    return _then(_MoneyTransferStatistics(
      totalSentToPeers: totalSentToPeers == freezed
          ? _value.totalSentToPeers
          : totalSentToPeers // ignore: cast_nullable_to_non_nullable
              as num,
      totalRaised: totalRaised == freezed
          ? _value.totalRaised
          : totalRaised // ignore: cast_nullable_to_non_nullable
              as num,
      totalRaisedViaMoneyPool: totalRaisedViaMoneyPool == freezed
          ? _value.totalRaisedViaMoneyPool
          : totalRaisedViaMoneyPool // ignore: cast_nullable_to_non_nullable
              as num,
      totalRaisedViaPeer2Peer: totalRaisedViaPeer2Peer == freezed
          ? _value.totalRaisedViaPeer2Peer
          : totalRaisedViaPeer2Peer // ignore: cast_nullable_to_non_nullable
              as num,
      totalRaisedViaSubsidiaryApp: totalRaisedViaSubsidiaryApp == freezed
          ? _value.totalRaisedViaSubsidiaryApp
          : totalRaisedViaSubsidiaryApp // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MoneyTransferStatistics implements _MoneyTransferStatistics {
  _$_MoneyTransferStatistics(
      {required this.totalSentToPeers,
      required this.totalRaised,
      required this.totalRaisedViaMoneyPool,
      required this.totalRaisedViaPeer2Peer,
      required this.totalRaisedViaSubsidiaryApp});

  factory _$_MoneyTransferStatistics.fromJson(Map<String, dynamic> json) =>
      _$_$_MoneyTransferStatisticsFromJson(json);

  @override
  final num totalSentToPeers;
  @override
  final num totalRaised;
  @override
  final num totalRaisedViaMoneyPool;
  @override
  final num totalRaisedViaPeer2Peer;
  @override
  final num totalRaisedViaSubsidiaryApp;

  @override
  String toString() {
    return 'MoneyTransferStatistics(totalSentToPeers: $totalSentToPeers, totalRaised: $totalRaised, totalRaisedViaMoneyPool: $totalRaisedViaMoneyPool, totalRaisedViaPeer2Peer: $totalRaisedViaPeer2Peer, totalRaisedViaSubsidiaryApp: $totalRaisedViaSubsidiaryApp)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MoneyTransferStatistics &&
            (identical(other.totalSentToPeers, totalSentToPeers) ||
                const DeepCollectionEquality()
                    .equals(other.totalSentToPeers, totalSentToPeers)) &&
            (identical(other.totalRaised, totalRaised) ||
                const DeepCollectionEquality()
                    .equals(other.totalRaised, totalRaised)) &&
            (identical(
                    other.totalRaisedViaMoneyPool, totalRaisedViaMoneyPool) ||
                const DeepCollectionEquality().equals(
                    other.totalRaisedViaMoneyPool, totalRaisedViaMoneyPool)) &&
            (identical(
                    other.totalRaisedViaPeer2Peer, totalRaisedViaPeer2Peer) ||
                const DeepCollectionEquality().equals(
                    other.totalRaisedViaPeer2Peer, totalRaisedViaPeer2Peer)) &&
            (identical(other.totalRaisedViaSubsidiaryApp,
                    totalRaisedViaSubsidiaryApp) ||
                const DeepCollectionEquality().equals(
                    other.totalRaisedViaSubsidiaryApp,
                    totalRaisedViaSubsidiaryApp)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(totalSentToPeers) ^
      const DeepCollectionEquality().hash(totalRaised) ^
      const DeepCollectionEquality().hash(totalRaisedViaMoneyPool) ^
      const DeepCollectionEquality().hash(totalRaisedViaPeer2Peer) ^
      const DeepCollectionEquality().hash(totalRaisedViaSubsidiaryApp);

  @JsonKey(ignore: true)
  @override
  _$MoneyTransferStatisticsCopyWith<_MoneyTransferStatistics> get copyWith =>
      __$MoneyTransferStatisticsCopyWithImpl<_MoneyTransferStatistics>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            num totalSentToPeers,
            num totalRaised,
            num totalRaisedViaMoneyPool,
            num totalRaisedViaPeer2Peer,
            num totalRaisedViaSubsidiaryApp)
        $default, {
    required TResult Function(num totalSentToPeers, num totalRaised) empty,
  }) {
    return $default(totalSentToPeers, totalRaised, totalRaisedViaMoneyPool,
        totalRaisedViaPeer2Peer, totalRaisedViaSubsidiaryApp);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            num totalSentToPeers,
            num totalRaised,
            num totalRaisedViaMoneyPool,
            num totalRaisedViaPeer2Peer,
            num totalRaisedViaSubsidiaryApp)?
        $default, {
    TResult Function(num totalSentToPeers, num totalRaised)? empty,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(totalSentToPeers, totalRaised, totalRaisedViaMoneyPool,
          totalRaisedViaPeer2Peer, totalRaisedViaSubsidiaryApp);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_MoneyTransferStatistics value) $default, {
    required TResult Function(_EmptyMoneyTransferStatistics value) empty,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_MoneyTransferStatistics value)? $default, {
    TResult Function(_EmptyMoneyTransferStatistics value)? empty,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$_MoneyTransferStatisticsToJson(this)
      ..['runtimeType'] = 'default';
  }
}

abstract class _MoneyTransferStatistics implements MoneyTransferStatistics {
  factory _MoneyTransferStatistics(
      {required num totalSentToPeers,
      required num totalRaised,
      required num totalRaisedViaMoneyPool,
      required num totalRaisedViaPeer2Peer,
      required num totalRaisedViaSubsidiaryApp}) = _$_MoneyTransferStatistics;

  factory _MoneyTransferStatistics.fromJson(Map<String, dynamic> json) =
      _$_MoneyTransferStatistics.fromJson;

  @override
  num get totalSentToPeers => throw _privateConstructorUsedError;
  @override
  num get totalRaised => throw _privateConstructorUsedError;
  num get totalRaisedViaMoneyPool => throw _privateConstructorUsedError;
  num get totalRaisedViaPeer2Peer => throw _privateConstructorUsedError;
  num get totalRaisedViaSubsidiaryApp => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MoneyTransferStatisticsCopyWith<_MoneyTransferStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$EmptyMoneyTransferStatisticsCopyWith<$Res>
    implements $MoneyTransferStatisticsCopyWith<$Res> {
  factory _$EmptyMoneyTransferStatisticsCopyWith(
          _EmptyMoneyTransferStatistics value,
          $Res Function(_EmptyMoneyTransferStatistics) then) =
      __$EmptyMoneyTransferStatisticsCopyWithImpl<$Res>;
  @override
  $Res call({num totalSentToPeers, num totalRaised});
}

/// @nodoc
class __$EmptyMoneyTransferStatisticsCopyWithImpl<$Res>
    extends _$MoneyTransferStatisticsCopyWithImpl<$Res>
    implements _$EmptyMoneyTransferStatisticsCopyWith<$Res> {
  __$EmptyMoneyTransferStatisticsCopyWithImpl(
      _EmptyMoneyTransferStatistics _value,
      $Res Function(_EmptyMoneyTransferStatistics) _then)
      : super(_value, (v) => _then(v as _EmptyMoneyTransferStatistics));

  @override
  _EmptyMoneyTransferStatistics get _value =>
      super._value as _EmptyMoneyTransferStatistics;

  @override
  $Res call({
    Object? totalSentToPeers = freezed,
    Object? totalRaised = freezed,
  }) {
    return _then(_EmptyMoneyTransferStatistics(
      totalSentToPeers: totalSentToPeers == freezed
          ? _value.totalSentToPeers
          : totalSentToPeers // ignore: cast_nullable_to_non_nullable
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
class _$_EmptyMoneyTransferStatistics implements _EmptyMoneyTransferStatistics {
  const _$_EmptyMoneyTransferStatistics(
      {this.totalSentToPeers = 0, this.totalRaised = 0});

  factory _$_EmptyMoneyTransferStatistics.fromJson(Map<String, dynamic> json) =>
      _$_$_EmptyMoneyTransferStatisticsFromJson(json);

  @JsonKey(defaultValue: 0)
  @override
  final num totalSentToPeers;
  @JsonKey(defaultValue: 0)
  @override
  final num totalRaised;

  @override
  String toString() {
    return 'MoneyTransferStatistics.empty(totalSentToPeers: $totalSentToPeers, totalRaised: $totalRaised)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _EmptyMoneyTransferStatistics &&
            (identical(other.totalSentToPeers, totalSentToPeers) ||
                const DeepCollectionEquality()
                    .equals(other.totalSentToPeers, totalSentToPeers)) &&
            (identical(other.totalRaised, totalRaised) ||
                const DeepCollectionEquality()
                    .equals(other.totalRaised, totalRaised)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(totalSentToPeers) ^
      const DeepCollectionEquality().hash(totalRaised);

  @JsonKey(ignore: true)
  @override
  _$EmptyMoneyTransferStatisticsCopyWith<_EmptyMoneyTransferStatistics>
      get copyWith => __$EmptyMoneyTransferStatisticsCopyWithImpl<
          _EmptyMoneyTransferStatistics>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            num totalSentToPeers,
            num totalRaised,
            num totalRaisedViaMoneyPool,
            num totalRaisedViaPeer2Peer,
            num totalRaisedViaSubsidiaryApp)
        $default, {
    required TResult Function(num totalSentToPeers, num totalRaised) empty,
  }) {
    return empty(totalSentToPeers, totalRaised);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            num totalSentToPeers,
            num totalRaised,
            num totalRaisedViaMoneyPool,
            num totalRaisedViaPeer2Peer,
            num totalRaisedViaSubsidiaryApp)?
        $default, {
    TResult Function(num totalSentToPeers, num totalRaised)? empty,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(totalSentToPeers, totalRaised);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_MoneyTransferStatistics value) $default, {
    required TResult Function(_EmptyMoneyTransferStatistics value) empty,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_MoneyTransferStatistics value)? $default, {
    TResult Function(_EmptyMoneyTransferStatistics value)? empty,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$_EmptyMoneyTransferStatisticsToJson(this)
      ..['runtimeType'] = 'empty';
  }
}

abstract class _EmptyMoneyTransferStatistics
    implements MoneyTransferStatistics {
  const factory _EmptyMoneyTransferStatistics(
      {num totalSentToPeers,
      num totalRaised}) = _$_EmptyMoneyTransferStatistics;

  factory _EmptyMoneyTransferStatistics.fromJson(Map<String, dynamic> json) =
      _$_EmptyMoneyTransferStatistics.fromJson;

  @override
  num get totalSentToPeers => throw _privateConstructorUsedError;
  @override
  num get totalRaised => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$EmptyMoneyTransferStatisticsCopyWith<_EmptyMoneyTransferStatistics>
      get copyWith => throw _privateConstructorUsedError;
}
