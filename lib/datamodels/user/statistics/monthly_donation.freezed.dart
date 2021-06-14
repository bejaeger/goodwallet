// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'monthly_donation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MonthlyDonation _$MonthlyDonationFromJson(Map<String, dynamic> json) {
  return _MonthlyDonation.fromJson(json);
}

/// @nodoc
class _$MonthlyDonationTearOff {
  const _$MonthlyDonationTearOff();

  _MonthlyDonation call(
      {required DateTime month, required num totalDonations}) {
    return _MonthlyDonation(
      month: month,
      totalDonations: totalDonations,
    );
  }

  MonthlyDonation fromJson(Map<String, Object> json) {
    return MonthlyDonation.fromJson(json);
  }
}

/// @nodoc
const $MonthlyDonation = _$MonthlyDonationTearOff();

/// @nodoc
mixin _$MonthlyDonation {
  DateTime get month => throw _privateConstructorUsedError;
  num get totalDonations => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MonthlyDonationCopyWith<MonthlyDonation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonthlyDonationCopyWith<$Res> {
  factory $MonthlyDonationCopyWith(
          MonthlyDonation value, $Res Function(MonthlyDonation) then) =
      _$MonthlyDonationCopyWithImpl<$Res>;
  $Res call({DateTime month, num totalDonations});
}

/// @nodoc
class _$MonthlyDonationCopyWithImpl<$Res>
    implements $MonthlyDonationCopyWith<$Res> {
  _$MonthlyDonationCopyWithImpl(this._value, this._then);

  final MonthlyDonation _value;
  // ignore: unused_field
  final $Res Function(MonthlyDonation) _then;

  @override
  $Res call({
    Object? month = freezed,
    Object? totalDonations = freezed,
  }) {
    return _then(_value.copyWith(
      month: month == freezed
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalDonations: totalDonations == freezed
          ? _value.totalDonations
          : totalDonations // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc
abstract class _$MonthlyDonationCopyWith<$Res>
    implements $MonthlyDonationCopyWith<$Res> {
  factory _$MonthlyDonationCopyWith(
          _MonthlyDonation value, $Res Function(_MonthlyDonation) then) =
      __$MonthlyDonationCopyWithImpl<$Res>;
  @override
  $Res call({DateTime month, num totalDonations});
}

/// @nodoc
class __$MonthlyDonationCopyWithImpl<$Res>
    extends _$MonthlyDonationCopyWithImpl<$Res>
    implements _$MonthlyDonationCopyWith<$Res> {
  __$MonthlyDonationCopyWithImpl(
      _MonthlyDonation _value, $Res Function(_MonthlyDonation) _then)
      : super(_value, (v) => _then(v as _MonthlyDonation));

  @override
  _MonthlyDonation get _value => super._value as _MonthlyDonation;

  @override
  $Res call({
    Object? month = freezed,
    Object? totalDonations = freezed,
  }) {
    return _then(_MonthlyDonation(
      month: month == freezed
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalDonations: totalDonations == freezed
          ? _value.totalDonations
          : totalDonations // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MonthlyDonation implements _MonthlyDonation {
  _$_MonthlyDonation({required this.month, required this.totalDonations});

  factory _$_MonthlyDonation.fromJson(Map<String, dynamic> json) =>
      _$_$_MonthlyDonationFromJson(json);

  @override
  final DateTime month;
  @override
  final num totalDonations;

  @override
  String toString() {
    return 'MonthlyDonation(month: $month, totalDonations: $totalDonations)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MonthlyDonation &&
            (identical(other.month, month) ||
                const DeepCollectionEquality().equals(other.month, month)) &&
            (identical(other.totalDonations, totalDonations) ||
                const DeepCollectionEquality()
                    .equals(other.totalDonations, totalDonations)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(month) ^
      const DeepCollectionEquality().hash(totalDonations);

  @JsonKey(ignore: true)
  @override
  _$MonthlyDonationCopyWith<_MonthlyDonation> get copyWith =>
      __$MonthlyDonationCopyWithImpl<_MonthlyDonation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_MonthlyDonationToJson(this);
  }
}

abstract class _MonthlyDonation implements MonthlyDonation {
  factory _MonthlyDonation(
      {required DateTime month,
      required num totalDonations}) = _$_MonthlyDonation;

  factory _MonthlyDonation.fromJson(Map<String, dynamic> json) =
      _$_MonthlyDonation.fromJson;

  @override
  DateTime get month => throw _privateConstructorUsedError;
  @override
  num get totalDonations => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MonthlyDonationCopyWith<_MonthlyDonation> get copyWith =>
      throw _privateConstructorUsedError;
}
