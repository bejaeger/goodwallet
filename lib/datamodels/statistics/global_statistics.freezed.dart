// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'global_statistics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GlobalStatistics _$GlobalStatisticsFromJson(Map<String, dynamic> json) {
  return _GlobalStatistics.fromJson(json);
}

/// @nodoc
class _$GlobalStatisticsTearOff {
  const _$GlobalStatisticsTearOff();

  _GlobalStatistics call(
      {required num totalDonations,
      required List<SupportedProjectStatistics> supportedProjects,
      required List<String> projectTopPicksIds}) {
    return _GlobalStatistics(
      totalDonations: totalDonations,
      supportedProjects: supportedProjects,
      projectTopPicksIds: projectTopPicksIds,
    );
  }

  GlobalStatistics fromJson(Map<String, Object> json) {
    return GlobalStatistics.fromJson(json);
  }
}

/// @nodoc
const $GlobalStatistics = _$GlobalStatisticsTearOff();

/// @nodoc
mixin _$GlobalStatistics {
  num get totalDonations => throw _privateConstructorUsedError;
  List<SupportedProjectStatistics> get supportedProjects =>
      throw _privateConstructorUsedError;
  List<String> get projectTopPicksIds => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GlobalStatisticsCopyWith<GlobalStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GlobalStatisticsCopyWith<$Res> {
  factory $GlobalStatisticsCopyWith(
          GlobalStatistics value, $Res Function(GlobalStatistics) then) =
      _$GlobalStatisticsCopyWithImpl<$Res>;
  $Res call(
      {num totalDonations,
      List<SupportedProjectStatistics> supportedProjects,
      List<String> projectTopPicksIds});
}

/// @nodoc
class _$GlobalStatisticsCopyWithImpl<$Res>
    implements $GlobalStatisticsCopyWith<$Res> {
  _$GlobalStatisticsCopyWithImpl(this._value, this._then);

  final GlobalStatistics _value;
  // ignore: unused_field
  final $Res Function(GlobalStatistics) _then;

  @override
  $Res call({
    Object? totalDonations = freezed,
    Object? supportedProjects = freezed,
    Object? projectTopPicksIds = freezed,
  }) {
    return _then(_value.copyWith(
      totalDonations: totalDonations == freezed
          ? _value.totalDonations
          : totalDonations // ignore: cast_nullable_to_non_nullable
              as num,
      supportedProjects: supportedProjects == freezed
          ? _value.supportedProjects
          : supportedProjects // ignore: cast_nullable_to_non_nullable
              as List<SupportedProjectStatistics>,
      projectTopPicksIds: projectTopPicksIds == freezed
          ? _value.projectTopPicksIds
          : projectTopPicksIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
abstract class _$GlobalStatisticsCopyWith<$Res>
    implements $GlobalStatisticsCopyWith<$Res> {
  factory _$GlobalStatisticsCopyWith(
          _GlobalStatistics value, $Res Function(_GlobalStatistics) then) =
      __$GlobalStatisticsCopyWithImpl<$Res>;
  @override
  $Res call(
      {num totalDonations,
      List<SupportedProjectStatistics> supportedProjects,
      List<String> projectTopPicksIds});
}

/// @nodoc
class __$GlobalStatisticsCopyWithImpl<$Res>
    extends _$GlobalStatisticsCopyWithImpl<$Res>
    implements _$GlobalStatisticsCopyWith<$Res> {
  __$GlobalStatisticsCopyWithImpl(
      _GlobalStatistics _value, $Res Function(_GlobalStatistics) _then)
      : super(_value, (v) => _then(v as _GlobalStatistics));

  @override
  _GlobalStatistics get _value => super._value as _GlobalStatistics;

  @override
  $Res call({
    Object? totalDonations = freezed,
    Object? supportedProjects = freezed,
    Object? projectTopPicksIds = freezed,
  }) {
    return _then(_GlobalStatistics(
      totalDonations: totalDonations == freezed
          ? _value.totalDonations
          : totalDonations // ignore: cast_nullable_to_non_nullable
              as num,
      supportedProjects: supportedProjects == freezed
          ? _value.supportedProjects
          : supportedProjects // ignore: cast_nullable_to_non_nullable
              as List<SupportedProjectStatistics>,
      projectTopPicksIds: projectTopPicksIds == freezed
          ? _value.projectTopPicksIds
          : projectTopPicksIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_GlobalStatistics implements _GlobalStatistics {
  _$_GlobalStatistics(
      {required this.totalDonations,
      required this.supportedProjects,
      required this.projectTopPicksIds});

  factory _$_GlobalStatistics.fromJson(Map<String, dynamic> json) =>
      _$_$_GlobalStatisticsFromJson(json);

  @override
  final num totalDonations;
  @override
  final List<SupportedProjectStatistics> supportedProjects;
  @override
  final List<String> projectTopPicksIds;

  @override
  String toString() {
    return 'GlobalStatistics(totalDonations: $totalDonations, supportedProjects: $supportedProjects, projectTopPicksIds: $projectTopPicksIds)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _GlobalStatistics &&
            (identical(other.totalDonations, totalDonations) ||
                const DeepCollectionEquality()
                    .equals(other.totalDonations, totalDonations)) &&
            (identical(other.supportedProjects, supportedProjects) ||
                const DeepCollectionEquality()
                    .equals(other.supportedProjects, supportedProjects)) &&
            (identical(other.projectTopPicksIds, projectTopPicksIds) ||
                const DeepCollectionEquality()
                    .equals(other.projectTopPicksIds, projectTopPicksIds)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(totalDonations) ^
      const DeepCollectionEquality().hash(supportedProjects) ^
      const DeepCollectionEquality().hash(projectTopPicksIds);

  @JsonKey(ignore: true)
  @override
  _$GlobalStatisticsCopyWith<_GlobalStatistics> get copyWith =>
      __$GlobalStatisticsCopyWithImpl<_GlobalStatistics>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_GlobalStatisticsToJson(this);
  }
}

abstract class _GlobalStatistics implements GlobalStatistics {
  factory _GlobalStatistics(
      {required num totalDonations,
      required List<SupportedProjectStatistics> supportedProjects,
      required List<String> projectTopPicksIds}) = _$_GlobalStatistics;

  factory _GlobalStatistics.fromJson(Map<String, dynamic> json) =
      _$_GlobalStatistics.fromJson;

  @override
  num get totalDonations => throw _privateConstructorUsedError;
  @override
  List<SupportedProjectStatistics> get supportedProjects =>
      throw _privateConstructorUsedError;
  @override
  List<String> get projectTopPicksIds => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$GlobalStatisticsCopyWith<_GlobalStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}
