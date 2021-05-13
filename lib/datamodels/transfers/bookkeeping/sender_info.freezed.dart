// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'sender_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SenderInfo _$SenderInfoFromJson(Map<String, dynamic> json) {
  return _SenderInfo.fromJson(json);
}

/// @nodoc
class _$SenderInfoTearOff {
  const _$SenderInfoTearOff();

  _SenderInfo call(
      {String? name, String? id, required MoneySource moneySource}) {
    return _SenderInfo(
      name: name,
      id: id,
      moneySource: moneySource,
    );
  }

  SenderInfo fromJson(Map<String, Object> json) {
    return SenderInfo.fromJson(json);
  }
}

/// @nodoc
const $SenderInfo = _$SenderInfoTearOff();

/// @nodoc
mixin _$SenderInfo {
  String? get name => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;
  MoneySource get moneySource => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SenderInfoCopyWith<SenderInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SenderInfoCopyWith<$Res> {
  factory $SenderInfoCopyWith(
          SenderInfo value, $Res Function(SenderInfo) then) =
      _$SenderInfoCopyWithImpl<$Res>;
  $Res call({String? name, String? id, MoneySource moneySource});
}

/// @nodoc
class _$SenderInfoCopyWithImpl<$Res> implements $SenderInfoCopyWith<$Res> {
  _$SenderInfoCopyWithImpl(this._value, this._then);

  final SenderInfo _value;
  // ignore: unused_field
  final $Res Function(SenderInfo) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? id = freezed,
    Object? moneySource = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      moneySource: moneySource == freezed
          ? _value.moneySource
          : moneySource // ignore: cast_nullable_to_non_nullable
              as MoneySource,
    ));
  }
}

/// @nodoc
abstract class _$SenderInfoCopyWith<$Res> implements $SenderInfoCopyWith<$Res> {
  factory _$SenderInfoCopyWith(
          _SenderInfo value, $Res Function(_SenderInfo) then) =
      __$SenderInfoCopyWithImpl<$Res>;
  @override
  $Res call({String? name, String? id, MoneySource moneySource});
}

/// @nodoc
class __$SenderInfoCopyWithImpl<$Res> extends _$SenderInfoCopyWithImpl<$Res>
    implements _$SenderInfoCopyWith<$Res> {
  __$SenderInfoCopyWithImpl(
      _SenderInfo _value, $Res Function(_SenderInfo) _then)
      : super(_value, (v) => _then(v as _SenderInfo));

  @override
  _SenderInfo get _value => super._value as _SenderInfo;

  @override
  $Res call({
    Object? name = freezed,
    Object? id = freezed,
    Object? moneySource = freezed,
  }) {
    return _then(_SenderInfo(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      moneySource: moneySource == freezed
          ? _value.moneySource
          : moneySource // ignore: cast_nullable_to_non_nullable
              as MoneySource,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SenderInfo implements _SenderInfo {
  _$_SenderInfo({this.name, this.id, required this.moneySource});

  factory _$_SenderInfo.fromJson(Map<String, dynamic> json) =>
      _$_$_SenderInfoFromJson(json);

  @override
  final String? name;
  @override
  final String? id;
  @override
  final MoneySource moneySource;

  @override
  String toString() {
    return 'SenderInfo(name: $name, id: $id, moneySource: $moneySource)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SenderInfo &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.moneySource, moneySource) ||
                const DeepCollectionEquality()
                    .equals(other.moneySource, moneySource)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(moneySource);

  @JsonKey(ignore: true)
  @override
  _$SenderInfoCopyWith<_SenderInfo> get copyWith =>
      __$SenderInfoCopyWithImpl<_SenderInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_SenderInfoToJson(this);
  }
}

abstract class _SenderInfo implements SenderInfo {
  factory _SenderInfo(
      {String? name,
      String? id,
      required MoneySource moneySource}) = _$_SenderInfo;

  factory _SenderInfo.fromJson(Map<String, dynamic> json) =
      _$_SenderInfo.fromJson;

  @override
  String? get name => throw _privateConstructorUsedError;
  @override
  String? get id => throw _privateConstructorUsedError;
  @override
  MoneySource get moneySource => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$SenderInfoCopyWith<_SenderInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
