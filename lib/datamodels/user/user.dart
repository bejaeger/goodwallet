import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:good_wallet/datamodels/user/statistics/money_transfer_statistics.dart';
import 'package:good_wallet/datamodels/user/statistics/user_statistics.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  @JsonSerializable(explicitToJson: true)
  factory User({
    required String uid,
    required String fullName,
    required String email,
    required List<String> keywordList,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
