// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'donation_statistics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DonationStatistics _$DonationStatisticsFromJson(Map<String, dynamic> json) {
  return _DonationStatistics.fromJson(json);
}

/// @nodoc
class _$DonationStatisticsTearOff {
  const _$DonationStatisticsTearOff();

  _DonationStatistics call(
      {required num totalDonations,
      required List<ConciseProjectInfo> supportedProjects}) {
    return _DonationStatistics(
      totalDonations: totalDonations,
      supportedProjects: supportedProjects,
    );
  }

  DonationStatistics fromJson(Map<String, Object> json) {
    return DonationStatistics.fromJson(json);
  }
}

/// @nodoc
const $DonationStatistics = _$DonationStatisticsTearOff();

/// @nodoc
mixin _$DonationStatistics {
  num get totalDonations => throw _privateConstructorUsedError;
  List<ConciseProjectInfo> get supportedProjects =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DonationStatisticsCopyWith<DonationStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DonationStatisticsCopyWith<$Res> {
  factory $DonationStatisticsCopyWith(
          DonationStatistics value, $Res Function(DonationStatistics) then) =
      _$DonationStatisticsCopyWithImpl<$Res>;
  $Res call({num totalDonations, List<ConciseProjectInfo> supportedProjects});
}

/// @nodoc
class _$DonationStatisticsCopyWithImpl<$Res>
    implements $DonationStatisticsCopyWith<$Res> {
  _$DonationStatisticsCopyWithImpl(this._value, this._then);

  final DonationStatistics _value;
  // ignore: unused_field
  final $Res Function(DonationStatistics) _then;

  @override
  $Res call({
    Object? totalDonations = freezed,
    Object? supportedProjects = freezed,
  }) {
    return _then(_value.copyWith(
      totalDonations: totalDonations == freezed
          ? _value.totalDonations
          : totalDonations // ignore: cast_nullable_to_non_nullable
              as num,
      supportedProjects: supportedProjects == freezed
          ? _value.supportedProjects
          : supportedProjects // ignore: cast_nullable_to_non_nullable
              as List<ConciseProjectInfo>,
    ));
  }
}

/// @nodoc
abstract class _$DonationStatisticsCopyWith<$Res>
    implements $DonationStatisticsCopyWith<$Res> {
  factory _$DonationStatisticsCopyWith(
          _DonationStatistics value, $Res Function(_DonationStatistics) then) =
      __$DonationStatisticsCopyWithImpl<$Res>;
  @override
  $Res call({num totalDonations, List<ConciseProjectInfo> supportedProjects});
}

/// @nodoc
class __$DonationStatisticsCopyWithImpl<$Res>
    extends _$DonationStatisticsCopyWithImpl<$Res>
    implements _$DonationStatisticsCopyWith<$Res> {
  __$DonationStatisticsCopyWithImpl(
      _DonationStatistics _value, $Res Function(_DonationStatistics) _then)
      : super(_value, (v) => _then(v as _DonationStatistics));

  @override
  _DonationStatistics get _value => super._value as _DonationStatistics;

  @override
  $Res call({
    Object? totalDonations = freezed,
    Object? supportedProjects = freezed,
  }) {
    return _then(_DonationStatistics(
      totalDonations: totalDonations == freezed
          ? _value.totalDonations
          : totalDonations // ignore: cast_nullable_to_non_nullable
              as num,
      supportedProjects: supportedProjects == freezed
          ? _value.supportedProjects
          : supportedProjects // ignore: cast_nullable_to_non_nullable
              as List<ConciseProjectInfo>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_DonationStatistics implements _DonationStatistics {
  _$_DonationStatistics(
      {required this.totalDonations, required this.supportedProjects});

  factory _$_DonationStatistics.fromJson(Map<String, dynamic> json) =>
      _$_$_DonationStatisticsFromJson(json);

  @override
  final num totalDonations;
  @override
  final List<ConciseProjectInfo> supportedProjects;

  @override
  String toString() {
    return 'DonationStatistics(totalDonations: $totalDonations, supportedProjects: $supportedProjects)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DonationStatistics &&
            (identical(other.totalDonations, totalDonations) ||
                const DeepCollectionEquality()
                    .equals(other.totalDonations, totalDonations)) &&
            (identical(other.supportedProjects, supportedProjects) ||
                const DeepCollectionEquality()
                    .equals(other.supportedProjects, supportedProjects)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(totalDonations) ^
      const DeepCollectionEquality().hash(supportedProjects);

  @JsonKey(ignore: true)
  @override
  _$DonationStatisticsCopyWith<_DonationStatistics> get copyWith =>
      __$DonationStatisticsCopyWithImpl<_DonationStatistics>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_DonationStatisticsToJson(this);
  }
}

abstract class _DonationStatistics implements DonationStatistics {
  factory _DonationStatistics(
          {required num totalDonations,
          required List<ConciseProjectInfo> supportedProjects}) =
      _$_DonationStatistics;

  factory _DonationStatistics.fromJson(Map<String, dynamic> json) =
      _$_DonationStatistics.fromJson;

  @override
  num get totalDonations => throw _privateConstructorUsedError;
  @override
  List<ConciseProjectInfo> get supportedProjects =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$DonationStatisticsCopyWith<_DonationStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}
