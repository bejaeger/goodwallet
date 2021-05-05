// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'project_preview_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProjectPreviewDetails _$ProjectPreviewDetailsFromJson(
    Map<String, dynamic> json) {
  return _ProjectPreviewDetails.fromJson(json);
}

/// @nodoc
class _$ProjectPreviewDetailsTearOff {
  const _$ProjectPreviewDetailsTearOff();

  _ProjectPreviewDetails call({required String projectName}) {
    return _ProjectPreviewDetails(
      projectName: projectName,
    );
  }

  ProjectPreviewDetails fromJson(Map<String, Object> json) {
    return ProjectPreviewDetails.fromJson(json);
  }
}

/// @nodoc
const $ProjectPreviewDetails = _$ProjectPreviewDetailsTearOff();

/// @nodoc
mixin _$ProjectPreviewDetails {
  String get projectName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectPreviewDetailsCopyWith<ProjectPreviewDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectPreviewDetailsCopyWith<$Res> {
  factory $ProjectPreviewDetailsCopyWith(ProjectPreviewDetails value,
          $Res Function(ProjectPreviewDetails) then) =
      _$ProjectPreviewDetailsCopyWithImpl<$Res>;
  $Res call({String projectName});
}

/// @nodoc
class _$ProjectPreviewDetailsCopyWithImpl<$Res>
    implements $ProjectPreviewDetailsCopyWith<$Res> {
  _$ProjectPreviewDetailsCopyWithImpl(this._value, this._then);

  final ProjectPreviewDetails _value;
  // ignore: unused_field
  final $Res Function(ProjectPreviewDetails) _then;

  @override
  $Res call({
    Object? projectName = freezed,
  }) {
    return _then(_value.copyWith(
      projectName: projectName == freezed
          ? _value.projectName
          : projectName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$ProjectPreviewDetailsCopyWith<$Res>
    implements $ProjectPreviewDetailsCopyWith<$Res> {
  factory _$ProjectPreviewDetailsCopyWith(_ProjectPreviewDetails value,
          $Res Function(_ProjectPreviewDetails) then) =
      __$ProjectPreviewDetailsCopyWithImpl<$Res>;
  @override
  $Res call({String projectName});
}

/// @nodoc
class __$ProjectPreviewDetailsCopyWithImpl<$Res>
    extends _$ProjectPreviewDetailsCopyWithImpl<$Res>
    implements _$ProjectPreviewDetailsCopyWith<$Res> {
  __$ProjectPreviewDetailsCopyWithImpl(_ProjectPreviewDetails _value,
      $Res Function(_ProjectPreviewDetails) _then)
      : super(_value, (v) => _then(v as _ProjectPreviewDetails));

  @override
  _ProjectPreviewDetails get _value => super._value as _ProjectPreviewDetails;

  @override
  $Res call({
    Object? projectName = freezed,
  }) {
    return _then(_ProjectPreviewDetails(
      projectName: projectName == freezed
          ? _value.projectName
          : projectName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ProjectPreviewDetails implements _ProjectPreviewDetails {
  _$_ProjectPreviewDetails({required this.projectName});

  factory _$_ProjectPreviewDetails.fromJson(Map<String, dynamic> json) =>
      _$_$_ProjectPreviewDetailsFromJson(json);

  @override
  final String projectName;

  @override
  String toString() {
    return 'ProjectPreviewDetails(projectName: $projectName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ProjectPreviewDetails &&
            (identical(other.projectName, projectName) ||
                const DeepCollectionEquality()
                    .equals(other.projectName, projectName)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(projectName);

  @JsonKey(ignore: true)
  @override
  _$ProjectPreviewDetailsCopyWith<_ProjectPreviewDetails> get copyWith =>
      __$ProjectPreviewDetailsCopyWithImpl<_ProjectPreviewDetails>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ProjectPreviewDetailsToJson(this);
  }
}

abstract class _ProjectPreviewDetails implements ProjectPreviewDetails {
  factory _ProjectPreviewDetails({required String projectName}) =
      _$_ProjectPreviewDetails;

  factory _ProjectPreviewDetails.fromJson(Map<String, dynamic> json) =
      _$_ProjectPreviewDetails.fromJson;

  @override
  String get projectName => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ProjectPreviewDetailsCopyWith<_ProjectPreviewDetails> get copyWith =>
      throw _privateConstructorUsedError;
}
