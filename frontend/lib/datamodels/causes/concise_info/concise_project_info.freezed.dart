// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'concise_project_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ConciseProjectInfo _$ConciseProjectInfoFromJson(Map<String, dynamic> json) {
  return _ConciseProjectInfo.fromJson(json);
}

/// @nodoc
class _$ConciseProjectInfoTearOff {
  const _$ConciseProjectInfoTearOff();

  _ConciseProjectInfo call(
      {required String name,
      required String id,
      required String area,
      String? description,
      String? imagePath}) {
    return _ConciseProjectInfo(
      name: name,
      id: id,
      area: area,
      description: description,
      imagePath: imagePath,
    );
  }

  ConciseProjectInfo fromJson(Map<String, Object> json) {
    return ConciseProjectInfo.fromJson(json);
  }
}

/// @nodoc
const $ConciseProjectInfo = _$ConciseProjectInfoTearOff();

/// @nodoc
mixin _$ConciseProjectInfo {
  String get name => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get area => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get imagePath => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConciseProjectInfoCopyWith<ConciseProjectInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConciseProjectInfoCopyWith<$Res> {
  factory $ConciseProjectInfoCopyWith(
          ConciseProjectInfo value, $Res Function(ConciseProjectInfo) then) =
      _$ConciseProjectInfoCopyWithImpl<$Res>;
  $Res call(
      {String name,
      String id,
      String area,
      String? description,
      String? imagePath});
}

/// @nodoc
class _$ConciseProjectInfoCopyWithImpl<$Res>
    implements $ConciseProjectInfoCopyWith<$Res> {
  _$ConciseProjectInfoCopyWithImpl(this._value, this._then);

  final ConciseProjectInfo _value;
  // ignore: unused_field
  final $Res Function(ConciseProjectInfo) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? id = freezed,
    Object? area = freezed,
    Object? description = freezed,
    Object? imagePath = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      area: area == freezed
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imagePath: imagePath == freezed
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$ConciseProjectInfoCopyWith<$Res>
    implements $ConciseProjectInfoCopyWith<$Res> {
  factory _$ConciseProjectInfoCopyWith(
          _ConciseProjectInfo value, $Res Function(_ConciseProjectInfo) then) =
      __$ConciseProjectInfoCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      String id,
      String area,
      String? description,
      String? imagePath});
}

/// @nodoc
class __$ConciseProjectInfoCopyWithImpl<$Res>
    extends _$ConciseProjectInfoCopyWithImpl<$Res>
    implements _$ConciseProjectInfoCopyWith<$Res> {
  __$ConciseProjectInfoCopyWithImpl(
      _ConciseProjectInfo _value, $Res Function(_ConciseProjectInfo) _then)
      : super(_value, (v) => _then(v as _ConciseProjectInfo));

  @override
  _ConciseProjectInfo get _value => super._value as _ConciseProjectInfo;

  @override
  $Res call({
    Object? name = freezed,
    Object? id = freezed,
    Object? area = freezed,
    Object? description = freezed,
    Object? imagePath = freezed,
  }) {
    return _then(_ConciseProjectInfo(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      area: area == freezed
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imagePath: imagePath == freezed
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ConciseProjectInfo implements _ConciseProjectInfo {
  _$_ConciseProjectInfo(
      {required this.name,
      required this.id,
      required this.area,
      this.description,
      this.imagePath});

  factory _$_ConciseProjectInfo.fromJson(Map<String, dynamic> json) =>
      _$_$_ConciseProjectInfoFromJson(json);

  @override
  final String name;
  @override
  final String id;
  @override
  final String area;
  @override
  final String? description;
  @override
  final String? imagePath;

  @override
  String toString() {
    return 'ConciseProjectInfo(name: $name, id: $id, area: $area, description: $description, imagePath: $imagePath)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ConciseProjectInfo &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.area, area) ||
                const DeepCollectionEquality().equals(other.area, area)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.imagePath, imagePath) ||
                const DeepCollectionEquality()
                    .equals(other.imagePath, imagePath)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(area) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(imagePath);

  @JsonKey(ignore: true)
  @override
  _$ConciseProjectInfoCopyWith<_ConciseProjectInfo> get copyWith =>
      __$ConciseProjectInfoCopyWithImpl<_ConciseProjectInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ConciseProjectInfoToJson(this);
  }
}

abstract class _ConciseProjectInfo implements ConciseProjectInfo {
  factory _ConciseProjectInfo(
      {required String name,
      required String id,
      required String area,
      String? description,
      String? imagePath}) = _$_ConciseProjectInfo;

  factory _ConciseProjectInfo.fromJson(Map<String, dynamic> json) =
      _$_ConciseProjectInfo.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String get area => throw _privateConstructorUsedError;
  @override
  String? get description => throw _privateConstructorUsedError;
  @override
  String? get imagePath => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ConciseProjectInfoCopyWith<_ConciseProjectInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
