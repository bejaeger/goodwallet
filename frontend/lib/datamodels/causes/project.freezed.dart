// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'project.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Project _$ProjectFromJson(Map<String, dynamic> json) {
  return _Project.fromJson(json);
}

/// @nodoc
class _$ProjectTearOff {
  const _$ProjectTearOff();

  _Project call(
      {required String name,
      @JsonKey(name: "id", toJson: Project._checkIfIdIsSet)
          String id = "placeholder",
      required String area,
      required CauseType causeType,
      String? imageUrl,
      String? contactUrl,
      String? summary,
      num totalDonations = 0,
      num? globalGivingProjectId,
      Organization? organization,
      num? fundingCurrent,
      num? fundingGoal,
      @JsonKey(toJson: Project._checkIfSearchKeywordsAreSet)
          List<String>? nameSearch}) {
    return _Project(
      name: name,
      id: id,
      area: area,
      causeType: causeType,
      imageUrl: imageUrl,
      contactUrl: contactUrl,
      summary: summary,
      totalDonations: totalDonations,
      globalGivingProjectId: globalGivingProjectId,
      organization: organization,
      fundingCurrent: fundingCurrent,
      fundingGoal: fundingGoal,
      nameSearch: nameSearch,
    );
  }

  Project fromJson(Map<String, Object> json) {
    return Project.fromJson(json);
  }
}

/// @nodoc
const $Project = _$ProjectTearOff();

/// @nodoc
mixin _$Project {
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: "id", toJson: Project._checkIfIdIsSet)
  String get id => throw _privateConstructorUsedError;
  String get area => throw _privateConstructorUsedError;
  CauseType get causeType => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get contactUrl => throw _privateConstructorUsedError;
  String? get summary => throw _privateConstructorUsedError;
  num get totalDonations => throw _privateConstructorUsedError;
  num? get globalGivingProjectId => throw _privateConstructorUsedError;
  Organization? get organization => throw _privateConstructorUsedError;
  num? get fundingCurrent => throw _privateConstructorUsedError;
  num? get fundingGoal => throw _privateConstructorUsedError;
  @JsonKey(toJson: Project._checkIfSearchKeywordsAreSet)
  List<String>? get nameSearch => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectCopyWith<Project> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectCopyWith<$Res> {
  factory $ProjectCopyWith(Project value, $Res Function(Project) then) =
      _$ProjectCopyWithImpl<$Res>;
  $Res call(
      {String name,
      @JsonKey(name: "id", toJson: Project._checkIfIdIsSet)
          String id,
      String area,
      CauseType causeType,
      String? imageUrl,
      String? contactUrl,
      String? summary,
      num totalDonations,
      num? globalGivingProjectId,
      Organization? organization,
      num? fundingCurrent,
      num? fundingGoal,
      @JsonKey(toJson: Project._checkIfSearchKeywordsAreSet)
          List<String>? nameSearch});

  $OrganizationCopyWith<$Res>? get organization;
}

/// @nodoc
class _$ProjectCopyWithImpl<$Res> implements $ProjectCopyWith<$Res> {
  _$ProjectCopyWithImpl(this._value, this._then);

  final Project _value;
  // ignore: unused_field
  final $Res Function(Project) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? id = freezed,
    Object? area = freezed,
    Object? causeType = freezed,
    Object? imageUrl = freezed,
    Object? contactUrl = freezed,
    Object? summary = freezed,
    Object? totalDonations = freezed,
    Object? globalGivingProjectId = freezed,
    Object? organization = freezed,
    Object? fundingCurrent = freezed,
    Object? fundingGoal = freezed,
    Object? nameSearch = freezed,
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
      causeType: causeType == freezed
          ? _value.causeType
          : causeType // ignore: cast_nullable_to_non_nullable
              as CauseType,
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      contactUrl: contactUrl == freezed
          ? _value.contactUrl
          : contactUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      summary: summary == freezed
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String?,
      totalDonations: totalDonations == freezed
          ? _value.totalDonations
          : totalDonations // ignore: cast_nullable_to_non_nullable
              as num,
      globalGivingProjectId: globalGivingProjectId == freezed
          ? _value.globalGivingProjectId
          : globalGivingProjectId // ignore: cast_nullable_to_non_nullable
              as num?,
      organization: organization == freezed
          ? _value.organization
          : organization // ignore: cast_nullable_to_non_nullable
              as Organization?,
      fundingCurrent: fundingCurrent == freezed
          ? _value.fundingCurrent
          : fundingCurrent // ignore: cast_nullable_to_non_nullable
              as num?,
      fundingGoal: fundingGoal == freezed
          ? _value.fundingGoal
          : fundingGoal // ignore: cast_nullable_to_non_nullable
              as num?,
      nameSearch: nameSearch == freezed
          ? _value.nameSearch
          : nameSearch // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }

  @override
  $OrganizationCopyWith<$Res>? get organization {
    if (_value.organization == null) {
      return null;
    }

    return $OrganizationCopyWith<$Res>(_value.organization!, (value) {
      return _then(_value.copyWith(organization: value));
    });
  }
}

/// @nodoc
abstract class _$ProjectCopyWith<$Res> implements $ProjectCopyWith<$Res> {
  factory _$ProjectCopyWith(_Project value, $Res Function(_Project) then) =
      __$ProjectCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      @JsonKey(name: "id", toJson: Project._checkIfIdIsSet)
          String id,
      String area,
      CauseType causeType,
      String? imageUrl,
      String? contactUrl,
      String? summary,
      num totalDonations,
      num? globalGivingProjectId,
      Organization? organization,
      num? fundingCurrent,
      num? fundingGoal,
      @JsonKey(toJson: Project._checkIfSearchKeywordsAreSet)
          List<String>? nameSearch});

  @override
  $OrganizationCopyWith<$Res>? get organization;
}

/// @nodoc
class __$ProjectCopyWithImpl<$Res> extends _$ProjectCopyWithImpl<$Res>
    implements _$ProjectCopyWith<$Res> {
  __$ProjectCopyWithImpl(_Project _value, $Res Function(_Project) _then)
      : super(_value, (v) => _then(v as _Project));

  @override
  _Project get _value => super._value as _Project;

  @override
  $Res call({
    Object? name = freezed,
    Object? id = freezed,
    Object? area = freezed,
    Object? causeType = freezed,
    Object? imageUrl = freezed,
    Object? contactUrl = freezed,
    Object? summary = freezed,
    Object? totalDonations = freezed,
    Object? globalGivingProjectId = freezed,
    Object? organization = freezed,
    Object? fundingCurrent = freezed,
    Object? fundingGoal = freezed,
    Object? nameSearch = freezed,
  }) {
    return _then(_Project(
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
      causeType: causeType == freezed
          ? _value.causeType
          : causeType // ignore: cast_nullable_to_non_nullable
              as CauseType,
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      contactUrl: contactUrl == freezed
          ? _value.contactUrl
          : contactUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      summary: summary == freezed
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String?,
      totalDonations: totalDonations == freezed
          ? _value.totalDonations
          : totalDonations // ignore: cast_nullable_to_non_nullable
              as num,
      globalGivingProjectId: globalGivingProjectId == freezed
          ? _value.globalGivingProjectId
          : globalGivingProjectId // ignore: cast_nullable_to_non_nullable
              as num?,
      organization: organization == freezed
          ? _value.organization
          : organization // ignore: cast_nullable_to_non_nullable
              as Organization?,
      fundingCurrent: fundingCurrent == freezed
          ? _value.fundingCurrent
          : fundingCurrent // ignore: cast_nullable_to_non_nullable
              as num?,
      fundingGoal: fundingGoal == freezed
          ? _value.fundingGoal
          : fundingGoal // ignore: cast_nullable_to_non_nullable
              as num?,
      nameSearch: nameSearch == freezed
          ? _value.nameSearch
          : nameSearch // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_Project implements _Project {
  _$_Project(
      {required this.name,
      @JsonKey(name: "id", toJson: Project._checkIfIdIsSet)
          this.id = "placeholder",
      required this.area,
      required this.causeType,
      this.imageUrl,
      this.contactUrl,
      this.summary,
      this.totalDonations = 0,
      this.globalGivingProjectId,
      this.organization,
      this.fundingCurrent,
      this.fundingGoal,
      @JsonKey(toJson: Project._checkIfSearchKeywordsAreSet)
          this.nameSearch});

  factory _$_Project.fromJson(Map<String, dynamic> json) =>
      _$_$_ProjectFromJson(json);

  @override
  final String name;
  @override
  @JsonKey(name: "id", toJson: Project._checkIfIdIsSet)
  final String id;
  @override
  final String area;
  @override
  final CauseType causeType;
  @override
  final String? imageUrl;
  @override
  final String? contactUrl;
  @override
  final String? summary;
  @JsonKey(defaultValue: 0)
  @override
  final num totalDonations;
  @override
  final num? globalGivingProjectId;
  @override
  final Organization? organization;
  @override
  final num? fundingCurrent;
  @override
  final num? fundingGoal;
  @override
  @JsonKey(toJson: Project._checkIfSearchKeywordsAreSet)
  final List<String>? nameSearch;

  @override
  String toString() {
    return 'Project(name: $name, id: $id, area: $area, causeType: $causeType, imageUrl: $imageUrl, contactUrl: $contactUrl, summary: $summary, totalDonations: $totalDonations, globalGivingProjectId: $globalGivingProjectId, organization: $organization, fundingCurrent: $fundingCurrent, fundingGoal: $fundingGoal, nameSearch: $nameSearch)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Project &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.area, area) ||
                const DeepCollectionEquality().equals(other.area, area)) &&
            (identical(other.causeType, causeType) ||
                const DeepCollectionEquality()
                    .equals(other.causeType, causeType)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)) &&
            (identical(other.contactUrl, contactUrl) ||
                const DeepCollectionEquality()
                    .equals(other.contactUrl, contactUrl)) &&
            (identical(other.summary, summary) ||
                const DeepCollectionEquality()
                    .equals(other.summary, summary)) &&
            (identical(other.totalDonations, totalDonations) ||
                const DeepCollectionEquality()
                    .equals(other.totalDonations, totalDonations)) &&
            (identical(other.globalGivingProjectId, globalGivingProjectId) ||
                const DeepCollectionEquality().equals(
                    other.globalGivingProjectId, globalGivingProjectId)) &&
            (identical(other.organization, organization) ||
                const DeepCollectionEquality()
                    .equals(other.organization, organization)) &&
            (identical(other.fundingCurrent, fundingCurrent) ||
                const DeepCollectionEquality()
                    .equals(other.fundingCurrent, fundingCurrent)) &&
            (identical(other.fundingGoal, fundingGoal) ||
                const DeepCollectionEquality()
                    .equals(other.fundingGoal, fundingGoal)) &&
            (identical(other.nameSearch, nameSearch) ||
                const DeepCollectionEquality()
                    .equals(other.nameSearch, nameSearch)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(area) ^
      const DeepCollectionEquality().hash(causeType) ^
      const DeepCollectionEquality().hash(imageUrl) ^
      const DeepCollectionEquality().hash(contactUrl) ^
      const DeepCollectionEquality().hash(summary) ^
      const DeepCollectionEquality().hash(totalDonations) ^
      const DeepCollectionEquality().hash(globalGivingProjectId) ^
      const DeepCollectionEquality().hash(organization) ^
      const DeepCollectionEquality().hash(fundingCurrent) ^
      const DeepCollectionEquality().hash(fundingGoal) ^
      const DeepCollectionEquality().hash(nameSearch);

  @JsonKey(ignore: true)
  @override
  _$ProjectCopyWith<_Project> get copyWith =>
      __$ProjectCopyWithImpl<_Project>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ProjectToJson(this);
  }
}

abstract class _Project implements Project {
  factory _Project(
      {required String name,
      @JsonKey(name: "id", toJson: Project._checkIfIdIsSet)
          String id,
      required String area,
      required CauseType causeType,
      String? imageUrl,
      String? contactUrl,
      String? summary,
      num totalDonations,
      num? globalGivingProjectId,
      Organization? organization,
      num? fundingCurrent,
      num? fundingGoal,
      @JsonKey(toJson: Project._checkIfSearchKeywordsAreSet)
          List<String>? nameSearch}) = _$_Project;

  factory _Project.fromJson(Map<String, dynamic> json) = _$_Project.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "id", toJson: Project._checkIfIdIsSet)
  String get id => throw _privateConstructorUsedError;
  @override
  String get area => throw _privateConstructorUsedError;
  @override
  CauseType get causeType => throw _privateConstructorUsedError;
  @override
  String? get imageUrl => throw _privateConstructorUsedError;
  @override
  String? get contactUrl => throw _privateConstructorUsedError;
  @override
  String? get summary => throw _privateConstructorUsedError;
  @override
  num get totalDonations => throw _privateConstructorUsedError;
  @override
  num? get globalGivingProjectId => throw _privateConstructorUsedError;
  @override
  Organization? get organization => throw _privateConstructorUsedError;
  @override
  num? get fundingCurrent => throw _privateConstructorUsedError;
  @override
  num? get fundingGoal => throw _privateConstructorUsedError;
  @override
  @JsonKey(toJson: Project._checkIfSearchKeywordsAreSet)
  List<String>? get nameSearch => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ProjectCopyWith<_Project> get copyWith =>
      throw _privateConstructorUsedError;
}
