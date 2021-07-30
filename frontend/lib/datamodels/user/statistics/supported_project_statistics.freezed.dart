// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'supported_project_statistics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SupportedProjectStatistics _$SupportedProjectStatisticsFromJson(
    Map<String, dynamic> json) {
  return _SupportedProjectStatistics.fromJson(json);
}

/// @nodoc
class _$SupportedProjectStatisticsTearOff {
  const _$SupportedProjectStatisticsTearOff();

  _SupportedProjectStatistics call(
      {required ConciseProjectInfo projectInfo, required num totalDonations}) {
    return _SupportedProjectStatistics(
      projectInfo: projectInfo,
      totalDonations: totalDonations,
    );
  }

  SupportedProjectStatistics fromJson(Map<String, Object> json) {
    return SupportedProjectStatistics.fromJson(json);
  }
}

/// @nodoc
const $SupportedProjectStatistics = _$SupportedProjectStatisticsTearOff();

/// @nodoc
mixin _$SupportedProjectStatistics {
  ConciseProjectInfo get projectInfo => throw _privateConstructorUsedError;
  num get totalDonations => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SupportedProjectStatisticsCopyWith<SupportedProjectStatistics>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SupportedProjectStatisticsCopyWith<$Res> {
  factory $SupportedProjectStatisticsCopyWith(SupportedProjectStatistics value,
          $Res Function(SupportedProjectStatistics) then) =
      _$SupportedProjectStatisticsCopyWithImpl<$Res>;
  $Res call({ConciseProjectInfo projectInfo, num totalDonations});

  $ConciseProjectInfoCopyWith<$Res> get projectInfo;
}

/// @nodoc
class _$SupportedProjectStatisticsCopyWithImpl<$Res>
    implements $SupportedProjectStatisticsCopyWith<$Res> {
  _$SupportedProjectStatisticsCopyWithImpl(this._value, this._then);

  final SupportedProjectStatistics _value;
  // ignore: unused_field
  final $Res Function(SupportedProjectStatistics) _then;

  @override
  $Res call({
    Object? projectInfo = freezed,
    Object? totalDonations = freezed,
  }) {
    return _then(_value.copyWith(
      projectInfo: projectInfo == freezed
          ? _value.projectInfo
          : projectInfo // ignore: cast_nullable_to_non_nullable
              as ConciseProjectInfo,
      totalDonations: totalDonations == freezed
          ? _value.totalDonations
          : totalDonations // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }

  @override
  $ConciseProjectInfoCopyWith<$Res> get projectInfo {
    return $ConciseProjectInfoCopyWith<$Res>(_value.projectInfo, (value) {
      return _then(_value.copyWith(projectInfo: value));
    });
  }
}

/// @nodoc
abstract class _$SupportedProjectStatisticsCopyWith<$Res>
    implements $SupportedProjectStatisticsCopyWith<$Res> {
  factory _$SupportedProjectStatisticsCopyWith(
          _SupportedProjectStatistics value,
          $Res Function(_SupportedProjectStatistics) then) =
      __$SupportedProjectStatisticsCopyWithImpl<$Res>;
  @override
  $Res call({ConciseProjectInfo projectInfo, num totalDonations});

  @override
  $ConciseProjectInfoCopyWith<$Res> get projectInfo;
}

/// @nodoc
class __$SupportedProjectStatisticsCopyWithImpl<$Res>
    extends _$SupportedProjectStatisticsCopyWithImpl<$Res>
    implements _$SupportedProjectStatisticsCopyWith<$Res> {
  __$SupportedProjectStatisticsCopyWithImpl(_SupportedProjectStatistics _value,
      $Res Function(_SupportedProjectStatistics) _then)
      : super(_value, (v) => _then(v as _SupportedProjectStatistics));

  @override
  _SupportedProjectStatistics get _value =>
      super._value as _SupportedProjectStatistics;

  @override
  $Res call({
    Object? projectInfo = freezed,
    Object? totalDonations = freezed,
  }) {
    return _then(_SupportedProjectStatistics(
      projectInfo: projectInfo == freezed
          ? _value.projectInfo
          : projectInfo // ignore: cast_nullable_to_non_nullable
              as ConciseProjectInfo,
      totalDonations: totalDonations == freezed
          ? _value.totalDonations
          : totalDonations // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_SupportedProjectStatistics implements _SupportedProjectStatistics {
  _$_SupportedProjectStatistics(
      {required this.projectInfo, required this.totalDonations});

  factory _$_SupportedProjectStatistics.fromJson(Map<String, dynamic> json) =>
      _$_$_SupportedProjectStatisticsFromJson(json);

  @override
  final ConciseProjectInfo projectInfo;
  @override
  final num totalDonations;

  @override
  String toString() {
    return 'SupportedProjectStatistics(projectInfo: $projectInfo, totalDonations: $totalDonations)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SupportedProjectStatistics &&
            (identical(other.projectInfo, projectInfo) ||
                const DeepCollectionEquality()
                    .equals(other.projectInfo, projectInfo)) &&
            (identical(other.totalDonations, totalDonations) ||
                const DeepCollectionEquality()
                    .equals(other.totalDonations, totalDonations)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(projectInfo) ^
      const DeepCollectionEquality().hash(totalDonations);

  @JsonKey(ignore: true)
  @override
  _$SupportedProjectStatisticsCopyWith<_SupportedProjectStatistics>
      get copyWith => __$SupportedProjectStatisticsCopyWithImpl<
          _SupportedProjectStatistics>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_SupportedProjectStatisticsToJson(this);
  }
}

abstract class _SupportedProjectStatistics
    implements SupportedProjectStatistics {
  factory _SupportedProjectStatistics(
      {required ConciseProjectInfo projectInfo,
      required num totalDonations}) = _$_SupportedProjectStatistics;

  factory _SupportedProjectStatistics.fromJson(Map<String, dynamic> json) =
      _$_SupportedProjectStatistics.fromJson;

  @override
  ConciseProjectInfo get projectInfo => throw _privateConstructorUsedError;
  @override
  num get totalDonations => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$SupportedProjectStatisticsCopyWith<_SupportedProjectStatistics>
      get copyWith => throw _privateConstructorUsedError;
}
