// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'user_statistics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserStatistics _$UserStatisticsFromJson(Map<String, dynamic> json) {
  return _UserStatistics.fromJson(json);
}

/// @nodoc
class _$UserStatisticsTearOff {
  const _$UserStatisticsTearOff();

  _UserStatistics call(
      {required num currentBalance,
      required MoneyTransferStatistics moneyTransferStatistics,
      required DonationStatistics donationStatistics}) {
    return _UserStatistics(
      currentBalance: currentBalance,
      moneyTransferStatistics: moneyTransferStatistics,
      donationStatistics: donationStatistics,
    );
  }

  UserStatistics fromJson(Map<String, Object> json) {
    return UserStatistics.fromJson(json);
  }
}

/// @nodoc
const $UserStatistics = _$UserStatisticsTearOff();

/// @nodoc
mixin _$UserStatistics {
  num get currentBalance => throw _privateConstructorUsedError;
  MoneyTransferStatistics get moneyTransferStatistics =>
      throw _privateConstructorUsedError;
  DonationStatistics get donationStatistics =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserStatisticsCopyWith<UserStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStatisticsCopyWith<$Res> {
  factory $UserStatisticsCopyWith(
          UserStatistics value, $Res Function(UserStatistics) then) =
      _$UserStatisticsCopyWithImpl<$Res>;
  $Res call(
      {num currentBalance,
      MoneyTransferStatistics moneyTransferStatistics,
      DonationStatistics donationStatistics});

  $MoneyTransferStatisticsCopyWith<$Res> get moneyTransferStatistics;
  $DonationStatisticsCopyWith<$Res> get donationStatistics;
}

/// @nodoc
class _$UserStatisticsCopyWithImpl<$Res>
    implements $UserStatisticsCopyWith<$Res> {
  _$UserStatisticsCopyWithImpl(this._value, this._then);

  final UserStatistics _value;
  // ignore: unused_field
  final $Res Function(UserStatistics) _then;

  @override
  $Res call({
    Object? currentBalance = freezed,
    Object? moneyTransferStatistics = freezed,
    Object? donationStatistics = freezed,
  }) {
    return _then(_value.copyWith(
      currentBalance: currentBalance == freezed
          ? _value.currentBalance
          : currentBalance // ignore: cast_nullable_to_non_nullable
              as num,
      moneyTransferStatistics: moneyTransferStatistics == freezed
          ? _value.moneyTransferStatistics
          : moneyTransferStatistics // ignore: cast_nullable_to_non_nullable
              as MoneyTransferStatistics,
      donationStatistics: donationStatistics == freezed
          ? _value.donationStatistics
          : donationStatistics // ignore: cast_nullable_to_non_nullable
              as DonationStatistics,
    ));
  }

  @override
  $MoneyTransferStatisticsCopyWith<$Res> get moneyTransferStatistics {
    return $MoneyTransferStatisticsCopyWith<$Res>(
        _value.moneyTransferStatistics, (value) {
      return _then(_value.copyWith(moneyTransferStatistics: value));
    });
  }

  @override
  $DonationStatisticsCopyWith<$Res> get donationStatistics {
    return $DonationStatisticsCopyWith<$Res>(_value.donationStatistics,
        (value) {
      return _then(_value.copyWith(donationStatistics: value));
    });
  }
}

/// @nodoc
abstract class _$UserStatisticsCopyWith<$Res>
    implements $UserStatisticsCopyWith<$Res> {
  factory _$UserStatisticsCopyWith(
          _UserStatistics value, $Res Function(_UserStatistics) then) =
      __$UserStatisticsCopyWithImpl<$Res>;
  @override
  $Res call(
      {num currentBalance,
      MoneyTransferStatistics moneyTransferStatistics,
      DonationStatistics donationStatistics});

  @override
  $MoneyTransferStatisticsCopyWith<$Res> get moneyTransferStatistics;
  @override
  $DonationStatisticsCopyWith<$Res> get donationStatistics;
}

/// @nodoc
class __$UserStatisticsCopyWithImpl<$Res>
    extends _$UserStatisticsCopyWithImpl<$Res>
    implements _$UserStatisticsCopyWith<$Res> {
  __$UserStatisticsCopyWithImpl(
      _UserStatistics _value, $Res Function(_UserStatistics) _then)
      : super(_value, (v) => _then(v as _UserStatistics));

  @override
  _UserStatistics get _value => super._value as _UserStatistics;

  @override
  $Res call({
    Object? currentBalance = freezed,
    Object? moneyTransferStatistics = freezed,
    Object? donationStatistics = freezed,
  }) {
    return _then(_UserStatistics(
      currentBalance: currentBalance == freezed
          ? _value.currentBalance
          : currentBalance // ignore: cast_nullable_to_non_nullable
              as num,
      moneyTransferStatistics: moneyTransferStatistics == freezed
          ? _value.moneyTransferStatistics
          : moneyTransferStatistics // ignore: cast_nullable_to_non_nullable
              as MoneyTransferStatistics,
      donationStatistics: donationStatistics == freezed
          ? _value.donationStatistics
          : donationStatistics // ignore: cast_nullable_to_non_nullable
              as DonationStatistics,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_UserStatistics implements _UserStatistics {
  _$_UserStatistics(
      {required this.currentBalance,
      required this.moneyTransferStatistics,
      required this.donationStatistics});

  factory _$_UserStatistics.fromJson(Map<String, dynamic> json) =>
      _$_$_UserStatisticsFromJson(json);

  @override
  final num currentBalance;
  @override
  final MoneyTransferStatistics moneyTransferStatistics;
  @override
  final DonationStatistics donationStatistics;

  @override
  String toString() {
    return 'UserStatistics(currentBalance: $currentBalance, moneyTransferStatistics: $moneyTransferStatistics, donationStatistics: $donationStatistics)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _UserStatistics &&
            (identical(other.currentBalance, currentBalance) ||
                const DeepCollectionEquality()
                    .equals(other.currentBalance, currentBalance)) &&
            (identical(
                    other.moneyTransferStatistics, moneyTransferStatistics) ||
                const DeepCollectionEquality().equals(
                    other.moneyTransferStatistics, moneyTransferStatistics)) &&
            (identical(other.donationStatistics, donationStatistics) ||
                const DeepCollectionEquality()
                    .equals(other.donationStatistics, donationStatistics)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(currentBalance) ^
      const DeepCollectionEquality().hash(moneyTransferStatistics) ^
      const DeepCollectionEquality().hash(donationStatistics);

  @JsonKey(ignore: true)
  @override
  _$UserStatisticsCopyWith<_UserStatistics> get copyWith =>
      __$UserStatisticsCopyWithImpl<_UserStatistics>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_UserStatisticsToJson(this);
  }
}

abstract class _UserStatistics implements UserStatistics {
  factory _UserStatistics(
      {required num currentBalance,
      required MoneyTransferStatistics moneyTransferStatistics,
      required DonationStatistics donationStatistics}) = _$_UserStatistics;

  factory _UserStatistics.fromJson(Map<String, dynamic> json) =
      _$_UserStatistics.fromJson;

  @override
  num get currentBalance => throw _privateConstructorUsedError;
  @override
  MoneyTransferStatistics get moneyTransferStatistics =>
      throw _privateConstructorUsedError;
  @override
  DonationStatistics get donationStatistics =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$UserStatisticsCopyWith<_UserStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}
