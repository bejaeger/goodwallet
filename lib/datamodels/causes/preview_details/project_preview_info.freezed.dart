// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'project_preview_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProjectPreviewInfo _$ProjectPreviewInfoFromJson(Map<String, dynamic> json) {
  return _ProjectPreviewInfo.fromJson(json);
}

/// @nodoc
class _$ProjectPreviewInfoTearOff {
  const _$ProjectPreviewInfoTearOff();

  _ProjectPreviewInfo call({required String projectName}) {
    return _ProjectPreviewInfo(
      projectName: projectName,
    );
  }

  ProjectPreviewInfo fromJson(Map<String, Object> json) {
    return ProjectPreviewInfo.fromJson(json);
  }
}

/// @nodoc
const $ProjectPreviewInfo = _$ProjectPreviewInfoTearOff();

/// @nodoc
mixin _$ProjectPreviewInfo {
  String get projectName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectPreviewInfoCopyWith<ProjectPreviewInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectPreviewInfoCopyWith<$Res> {
  factory $ProjectPreviewInfoCopyWith(
          ProjectPreviewInfo value, $Res Function(ProjectPreviewInfo) then) =
      _$ProjectPreviewInfoCopyWithImpl<$Res>;
  $Res call({String projectName});
}

/// @nodoc
class _$ProjectPreviewInfoCopyWithImpl<$Res>
    implements $ProjectPreviewInfoCopyWith<$Res> {
  _$ProjectPreviewInfoCopyWithImpl(this._value, this._then);

  final ProjectPreviewInfo _value;
  // ignore: unused_field
  final $Res Function(ProjectPreviewInfo) _then;

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
abstract class _$ProjectPreviewInfoCopyWith<$Res>
    implements $ProjectPreviewInfoCopyWith<$Res> {
  factory _$ProjectPreviewInfoCopyWith(
          _ProjectPreviewInfo value, $Res Function(_ProjectPreviewInfo) then) =
      __$ProjectPreviewInfoCopyWithImpl<$Res>;
  @override
  $Res call({String projectName});
}

/// @nodoc
class __$ProjectPreviewInfoCopyWithImpl<$Res>
    extends _$ProjectPreviewInfoCopyWithImpl<$Res>
    implements _$ProjectPreviewInfoCopyWith<$Res> {
  __$ProjectPreviewInfoCopyWithImpl(
      _ProjectPreviewInfo _value, $Res Function(_ProjectPreviewInfo) _then)
      : super(_value, (v) => _then(v as _ProjectPreviewInfo));

  @override
  _ProjectPreviewInfo get _value => super._value as _ProjectPreviewInfo;

  @override
  $Res call({
    Object? projectName = freezed,
  }) {
    return _then(_ProjectPreviewInfo(
      projectName: projectName == freezed
          ? _value.projectName
          : projectName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ProjectPreviewInfo implements _ProjectPreviewInfo {
  _$_ProjectPreviewInfo({required this.projectName});

  factory _$_ProjectPreviewInfo.fromJson(Map<String, dynamic> json) =>
      _$_$_ProjectPreviewInfoFromJson(json);

  @override
  final String projectName;

  @override
  String toString() {
    return 'ProjectPreviewInfo(projectName: $projectName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ProjectPreviewInfo &&
            (identical(other.projectName, projectName) ||
                const DeepCollectionEquality()
                    .equals(other.projectName, projectName)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(projectName);

  @JsonKey(ignore: true)
  @override
  _$ProjectPreviewInfoCopyWith<_ProjectPreviewInfo> get copyWith =>
      __$ProjectPreviewInfoCopyWithImpl<_ProjectPreviewInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ProjectPreviewInfoToJson(this);
  }
}

abstract class _ProjectPreviewInfo implements ProjectPreviewInfo {
  factory _ProjectPreviewInfo({required String projectName}) =
      _$_ProjectPreviewInfo;

  factory _ProjectPreviewInfo.fromJson(Map<String, dynamic> json) =
      _$_ProjectPreviewInfo.fromJson;

  @override
  String get projectName => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ProjectPreviewInfoCopyWith<_ProjectPreviewInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
