// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$_$_UserFromJson(Map<String, dynamic> json) {
  return _$_User(
    uid: json['uid'] as String,
    fullName: json['fullName'] as String,
    email: json['email'] as String,
    searchKeywords: (json['searchKeywords'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
  );
}

Map<String, dynamic> _$_$_UserToJson(_$_User instance) => <String, dynamic>{
      'uid': instance.uid,
      'fullName': instance.fullName,
      'email': instance.email,
      'searchKeywords': User._checkIfKeywordsAreSet(instance.searchKeywords),
    };

_$_EmptyUser _$_$_EmptyUserFromJson(Map<String, dynamic> json) {
  return _$_EmptyUser(
    uid: json['uid'] as String? ?? '',
    fullName: json['fullName'] as String? ?? '',
    email: json['email'] as String? ?? '',
    searchKeywords: (json['searchKeywords'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
  );
}

Map<String, dynamic> _$_$_EmptyUserToJson(_$_EmptyUser instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'fullName': instance.fullName,
      'email': instance.email,
      'searchKeywords': instance.searchKeywords,
    };