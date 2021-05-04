import 'package:freezed_annotation/freezed_annotation.dart';

part 'paid_out_user.freezed.dart';
part 'paid_out_user.g.dart';

@freezed
class PaidOutUser with _$PaidOutUser {
  factory PaidOutUser({
    required String name,
    required String uid,
    required num amount,
  }) = _PaidOutUser;

  factory PaidOutUser.fromJson(Map<String, dynamic> json) =>
      _$PaidOutUserFromJson(json);
}
