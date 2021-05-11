import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:good_wallet/datamodels/user/statistics/money_transfer_statistics.dart';
import 'package:good_wallet/datamodels/user/statistics/user_statistics.dart';
import 'package:good_wallet/exceptions/datamodel_exception.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  static List<String> _checkIfKeywordsAreSet(List<String>? keywordList) {
    if (keywordList == null) {
      throw DataModelException(
          message:
              "User: You can't serialize User data that still has no 'keywordList' attached!",
          devDetails:
              "Please provide a 'keywordList' which will be used to query usernames with Firestore queries");
    } else
      return keywordList;
  }

  @JsonSerializable(explicitToJson: true)
  factory User({
    required String uid,
    required String fullName,
    required String email,
    @JsonKey(
      toJson: User._checkIfKeywordsAreSet,
    )
        List<String>? keywordList,
  }) = _User;

  factory User.empty({
    @Default("") String uid,
    @Default("") String fullName,
    @Default("") String email,
    List<String>? keywordList,
  }) = _EmptyUser;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
