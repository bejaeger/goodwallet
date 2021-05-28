// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Project _$_$_ProjectFromJson(Map<String, dynamic> json) {
  return _$_Project(
    name: json['name'] as String,
    id: json['id'] as String,
    area: json['area'] as String,
    causeType: _$enumDecode(_$CauseTypeEnumMap, json['causeType']),
    imageUrl: json['imageUrl'] as String?,
    contactUrl: json['contactUrl'] as String?,
    summary: json['summary'] as String?,
    totalDonations: json['totalDonations'] as num? ?? 0,
    globalGivingProjectId: json['globalGivingProjectId'] as num?,
    organization: json['organization'] == null
        ? null
        : Organization.fromJson(json['organization'] as Map<String, dynamic>),
    fundingCurrent: json['fundingCurrent'] as num?,
    fundingGoal: json['fundingGoal'] as num?,
  );
}

Map<String, dynamic> _$_$_ProjectToJson(_$_Project instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': Project._checkIfIdIsSet(instance.id),
      'area': instance.area,
      'causeType': _$CauseTypeEnumMap[instance.causeType],
      'imageUrl': instance.imageUrl,
      'contactUrl': instance.contactUrl,
      'summary': instance.summary,
      'totalDonations': instance.totalDonations,
      'globalGivingProjectId': instance.globalGivingProjectId,
      'organization': instance.organization?.toJson(),
      'fundingCurrent': instance.fundingCurrent,
      'fundingGoal': instance.fundingGoal,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$CauseTypeEnumMap = {
  CauseType.GlobalGivingProject: 'GlobalGivingProject',
  CauseType.GoodWalletFund: 'GoodWalletFund',
};
