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
      {required List<SupportedProjectStatistics> supportedProjects}) {
    return _GlobalStatistics(
      supportedProjects: supportedProjects,
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
  List<SupportedProjectStatistics> get supportedProjects =>
      throw _privateConstructorUsedError;

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
  $Res call({List<SupportedProjectStatistics> supportedProjects});
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
    Object? supportedProjects = freezed,
  }) {
    return _then(_value.copyWith(
      supportedProjects: supportedProjects == freezed
          ? _value.supportedProjects
          : supportedProjects // ignore: cast_nullable_to_non_nullable
              as List<SupportedProjectStatistics>,
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
  $Res call({List<SupportedProjectStatistics> supportedProjects});
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
    Object? supportedProjects = freezed,
  }) {
    return _then(_GlobalStatistics(
      supportedProjects: supportedProjects == freezed
          ? _value.supportedProjects
          : supportedProjects // ignore: cast_nullable_to_non_nullable
              as List<SupportedProjectStatistics>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_GlobalStatistics implements _GlobalStatistics {
  _$_GlobalStatistics({required this.supportedProjects});

  factory _$_GlobalStatistics.fromJson(Map<String, dynamic> json) =>
      _$_$_GlobalStatisticsFromJson(json);

  @override
  final List<SupportedProjectStatistics> supportedProjects;

  @override
  String toString() {
    return 'GlobalStatistics(supportedProjects: $supportedProjects)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _GlobalStatistics &&
            (identical(other.supportedProjects, supportedProjects) ||
                const DeepCollectionEquality()
                    .equals(other.supportedProjects, supportedProjects)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(supportedProjects);

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
          {required List<SupportedProjectStatistics> supportedProjects}) =
      _$_GlobalStatistics;

  factory _GlobalStatistics.fromJson(Map<String, dynamic> json) =
      _$_GlobalStatistics.fromJson;

  @override
  List<SupportedProjectStatistics> get supportedProjects =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$GlobalStatisticsCopyWith<_GlobalStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}
