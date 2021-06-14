import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:good_wallet/datamodels/user/user_settings.dart';
import 'package:good_wallet/exceptions/datamodel_exception.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  static List<String> _checkIfKeywordsAreSet(List<String>? searchKeywords) {
    if (searchKeywords == null) {
      throw DataModelException(
          message:
              "User: You can't serialize User data that still has no 'keywordList' attached!",
          devDetails:
              "Please provide a 'keywordList' which will be used to query usernames with Firestore queries");
    } else
      return searchKeywords;
  }

  @JsonSerializable(explicitToJson: true)
  factory User({
    required String uid,
    required String fullName,
    required String email,
    required UserSettings userSettings,
    @JsonKey(
      toJson: User._checkIfKeywordsAreSet,
    )
        List<String>? searchKeywords,
  }) = _User;

  factory User.empty({
    @Default("") String uid,
    @Default("") String fullName,
    @Default("") String email,
    UserSettings? userSettings,
    List<String>? searchKeywords,
  }) = _EmptyUser;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
