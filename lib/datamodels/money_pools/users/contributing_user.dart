import 'package:freezed_annotation/freezed_annotation.dart';

part 'contributing_user.freezed.dart';
part 'contributing_user.g.dart';

@freezed
class ContributingUser with _$ContributingUser {
  factory ContributingUser({
    required String name,
    required String uid,
    @Default(0) num contribution,
  }) = _ContributingUser;

  factory ContributingUser.fromJson(Map<String, dynamic> json) =>
      _$ContributingUserFromJson(json);
}
