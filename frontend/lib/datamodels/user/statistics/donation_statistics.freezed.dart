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
  switch (json['runtimeType'] as String) {
    case 'default':
      return _DonationStatistics.fromJson(json);
    case 'empty':
      return _EmptyDonationStatistics.fromJson(json);

    default:
      throw FallThroughError();
  }
}

/// @nodoc
class _$DonationStatisticsTearOff {
  const _$DonationStatisticsTearOff();

  _DonationStatistics call(
      {required num totalDonations,
      required List<SupportedProjectStatistics> supportedProjects,
      required List<MonthlyDonation> monthlyDonations}) {
    return _DonationStatistics(
      totalDonations: totalDonations,
      supportedProjects: supportedProjects,
      monthlyDonations: monthlyDonations,
    );
  }

  _EmptyDonationStatistics empty(
      {num totalDonations = 0,
      List<SupportedProjectStatistics>? supportedProjects,
      List<MonthlyDonation>? monthlyDonations}) {
    return _EmptyDonationStatistics(
      totalDonations: totalDonations,
      supportedProjects: supportedProjects,
      monthlyDonations: monthlyDonations,
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            num totalDonations,
            List<SupportedProjectStatistics> supportedProjects,
            List<MonthlyDonation> monthlyDonations)
        $default, {
    required TResult Function(
            num totalDonations,
            List<SupportedProjectStatistics>? supportedProjects,
            List<MonthlyDonation>? monthlyDonations)
        empty,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            num totalDonations,
            List<SupportedProjectStatistics> supportedProjects,
            List<MonthlyDonation> monthlyDonations)?
        $default, {
    TResult Function(
            num totalDonations,
            List<SupportedProjectStatistics>? supportedProjects,
            List<MonthlyDonation>? monthlyDonations)?
        empty,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_DonationStatistics value) $default, {
    required TResult Function(_EmptyDonationStatistics value) empty,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_DonationStatistics value)? $default, {
    TResult Function(_EmptyDonationStatistics value)? empty,
    required TResult orElse(),
  }) =>
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
  $Res call({num totalDonations});
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
  }) {
    return _then(_value.copyWith(
      totalDonations: totalDonations == freezed
          ? _value.totalDonations
          : totalDonations // ignore: cast_nullable_to_non_nullable
              as num,
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
  $Res call(
      {num totalDonations,
      List<SupportedProjectStatistics> supportedProjects,
      List<MonthlyDonation> monthlyDonations});
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
    Object? monthlyDonations = freezed,
  }) {
    return _then(_DonationStatistics(
      totalDonations: totalDonations == freezed
          ? _value.totalDonations
          : totalDonations // ignore: cast_nullable_to_non_nullable
              as num,
      supportedProjects: supportedProjects == freezed
          ? _value.supportedProjects
          : supportedProjects // ignore: cast_nullable_to_non_nullable
              as List<SupportedProjectStatistics>,
      monthlyDonations: monthlyDonations == freezed
          ? _value.monthlyDonations
          : monthlyDonations // ignore: cast_nullable_to_non_nullable
              as List<MonthlyDonation>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_DonationStatistics implements _DonationStatistics {
  _$_DonationStatistics(
      {required this.totalDonations,
      required this.supportedProjects,
      required this.monthlyDonations});

  factory _$_DonationStatistics.fromJson(Map<String, dynamic> json) =>
      _$_$_DonationStatisticsFromJson(json);

  @override
  final num totalDonations;
  @override
  final List<SupportedProjectStatistics> supportedProjects;
  @override
  final List<MonthlyDonation> monthlyDonations;

  @override
  String toString() {
    return 'DonationStatistics(totalDonations: $totalDonations, supportedProjects: $supportedProjects, monthlyDonations: $monthlyDonations)';
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
                    .equals(other.supportedProjects, supportedProjects)) &&
            (identical(other.monthlyDonations, monthlyDonations) ||
                const DeepCollectionEquality()
                    .equals(other.monthlyDonations, monthlyDonations)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(totalDonations) ^
      const DeepCollectionEquality().hash(supportedProjects) ^
      const DeepCollectionEquality().hash(monthlyDonations);

  @JsonKey(ignore: true)
  @override
  _$DonationStatisticsCopyWith<_DonationStatistics> get copyWith =>
      __$DonationStatisticsCopyWithImpl<_DonationStatistics>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            num totalDonations,
            List<SupportedProjectStatistics> supportedProjects,
            List<MonthlyDonation> monthlyDonations)
        $default, {
    required TResult Function(
            num totalDonations,
            List<SupportedProjectStatistics>? supportedProjects,
            List<MonthlyDonation>? monthlyDonations)
        empty,
  }) {
    return $default(totalDonations, supportedProjects, monthlyDonations);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            num totalDonations,
            List<SupportedProjectStatistics> supportedProjects,
            List<MonthlyDonation> monthlyDonations)?
        $default, {
    TResult Function(
            num totalDonations,
            List<SupportedProjectStatistics>? supportedProjects,
            List<MonthlyDonation>? monthlyDonations)?
        empty,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(totalDonations, supportedProjects, monthlyDonations);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_DonationStatistics value) $default, {
    required TResult Function(_EmptyDonationStatistics value) empty,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_DonationStatistics value)? $default, {
    TResult Function(_EmptyDonationStatistics value)? empty,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$_DonationStatisticsToJson(this)..['runtimeType'] = 'default';
  }
}

abstract class _DonationStatistics implements DonationStatistics {
  factory _DonationStatistics(
      {required num totalDonations,
      required List<SupportedProjectStatistics> supportedProjects,
      required List<MonthlyDonation> monthlyDonations}) = _$_DonationStatistics;

  factory _DonationStatistics.fromJson(Map<String, dynamic> json) =
      _$_DonationStatistics.fromJson;

  @override
  num get totalDonations => throw _privateConstructorUsedError;
  List<SupportedProjectStatistics> get supportedProjects =>
      throw _privateConstructorUsedError;
  List<MonthlyDonation> get monthlyDonations =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$DonationStatisticsCopyWith<_DonationStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$EmptyDonationStatisticsCopyWith<$Res>
    implements $DonationStatisticsCopyWith<$Res> {
  factory _$EmptyDonationStatisticsCopyWith(_EmptyDonationStatistics value,
          $Res Function(_EmptyDonationStatistics) then) =
      __$EmptyDonationStatisticsCopyWithImpl<$Res>;
  @override
  $Res call(
      {num totalDonations,
      List<SupportedProjectStatistics>? supportedProjects,
      List<MonthlyDonation>? monthlyDonations});
}

/// @nodoc
class __$EmptyDonationStatisticsCopyWithImpl<$Res>
    extends _$DonationStatisticsCopyWithImpl<$Res>
    implements _$EmptyDonationStatisticsCopyWith<$Res> {
  __$EmptyDonationStatisticsCopyWithImpl(_EmptyDonationStatistics _value,
      $Res Function(_EmptyDonationStatistics) _then)
      : super(_value, (v) => _then(v as _EmptyDonationStatistics));

  @override
  _EmptyDonationStatistics get _value =>
      super._value as _EmptyDonationStatistics;

  @override
  $Res call({
    Object? totalDonations = freezed,
    Object? supportedProjects = freezed,
    Object? monthlyDonations = freezed,
  }) {
    return _then(_EmptyDonationStatistics(
      totalDonations: totalDonations == freezed
          ? _value.totalDonations
          : totalDonations // ignore: cast_nullable_to_non_nullable
              as num,
      supportedProjects: supportedProjects == freezed
          ? _value.supportedProjects
          : supportedProjects // ignore: cast_nullable_to_non_nullable
              as List<SupportedProjectStatistics>?,
      monthlyDonations: monthlyDonations == freezed
          ? _value.monthlyDonations
          : monthlyDonations // ignore: cast_nullable_to_non_nullable
              as List<MonthlyDonation>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_EmptyDonationStatistics implements _EmptyDonationStatistics {
  const _$_EmptyDonationStatistics(
      {this.totalDonations = 0, this.supportedProjects, this.monthlyDonations});

  factory _$_EmptyDonationStatistics.fromJson(Map<String, dynamic> json) =>
      _$_$_EmptyDonationStatisticsFromJson(json);

  @JsonKey(defaultValue: 0)
  @override
  final num totalDonations;
  @override
  final List<SupportedProjectStatistics>? supportedProjects;
  @override
  final List<MonthlyDonation>? monthlyDonations;

  @override
  String toString() {
    return 'DonationStatistics.empty(totalDonations: $totalDonations, supportedProjects: $supportedProjects, monthlyDonations: $monthlyDonations)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _EmptyDonationStatistics &&
            (identical(other.totalDonations, totalDonations) ||
                const DeepCollectionEquality()
                    .equals(other.totalDonations, totalDonations)) &&
            (identical(other.supportedProjects, supportedProjects) ||
                const DeepCollectionEquality()
                    .equals(other.supportedProjects, supportedProjects)) &&
            (identical(other.monthlyDonations, monthlyDonations) ||
                const DeepCollectionEquality()
                    .equals(other.monthlyDonations, monthlyDonations)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(totalDonations) ^
      const DeepCollectionEquality().hash(supportedProjects) ^
      const DeepCollectionEquality().hash(monthlyDonations);

  @JsonKey(ignore: true)
  @override
  _$EmptyDonationStatisticsCopyWith<_EmptyDonationStatistics> get copyWith =>
      __$EmptyDonationStatisticsCopyWithImpl<_EmptyDonationStatistics>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            num totalDonations,
            List<SupportedProjectStatistics> supportedProjects,
            List<MonthlyDonation> monthlyDonations)
        $default, {
    required TResult Function(
            num totalDonations,
            List<SupportedProjectStatistics>? supportedProjects,
            List<MonthlyDonation>? monthlyDonations)
        empty,
  }) {
    return empty(totalDonations, supportedProjects, monthlyDonations);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            num totalDonations,
            List<SupportedProjectStatistics> supportedProjects,
            List<MonthlyDonation> monthlyDonations)?
        $default, {
    TResult Function(
            num totalDonations,
            List<SupportedProjectStatistics>? supportedProjects,
            List<MonthlyDonation>? monthlyDonations)?
        empty,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(totalDonations, supportedProjects, monthlyDonations);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_DonationStatistics value) $default, {
    required TResult Function(_EmptyDonationStatistics value) empty,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_DonationStatistics value)? $default, {
    TResult Function(_EmptyDonationStatistics value)? empty,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$_EmptyDonationStatisticsToJson(this)..['runtimeType'] = 'empty';
  }
}

abstract class _EmptyDonationStatistics implements DonationStatistics {
  const factory _EmptyDonationStatistics(
      {num totalDonations,
      List<SupportedProjectStatistics>? supportedProjects,
      List<MonthlyDonation>? monthlyDonations}) = _$_EmptyDonationStatistics;

  factory _EmptyDonationStatistics.fromJson(Map<String, dynamic> json) =
      _$_EmptyDonationStatistics.fromJson;

  @override
  num get totalDonations => throw _privateConstructorUsedError;
  List<SupportedProjectStatistics>? get supportedProjects =>
      throw _privateConstructorUsedError;
  List<MonthlyDonation>? get monthlyDonations =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$EmptyDonationStatisticsCopyWith<_EmptyDonationStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}
