import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:good_wallet/datamodels/causes/organization.dart';
import 'package:good_wallet/enums/causes_type.dart';
import 'package:good_wallet/exceptions/datamodel_exception.dart';

part 'project.freezed.dart';
part 'project.g.dart';

// Please also see ConciseProjectInfo!

@freezed
class Project with _$Project {
  static String _checkIfIdIsSet(String id) {
    if (id == "placeholder") {
      throw DataModelException(
          message:
              "Project: You can't serialize a project model that still has a placeholder for the 'Id' property!",
          devDetails:
              "Please provide a valid 'Id' by creating a new 'Project' with the copyWith constructor and adding the firestore DocumentReference id as 'id'");
    } else
      return id;
  }

  static List<String> _checkIfSearchKeywordsAreSet(
      List<String>? searchKeywords) {
    if (searchKeywords == null) {
      throw DataModelException(
          message:
              "Project: You can't serialize Project data that still has no 'nameSearch' attached!",
          devDetails:
              "Please provide a 'nameSearch' which will be used to query project names with Firestore queries");
    } else
      return searchKeywords;
  }

  @JsonSerializable(explicitToJson: true)
  factory Project({
    required String name,
    @JsonKey(
      name: "id",
      toJson: Project._checkIfIdIsSet,
    )
    @Default("placeholder")
        String id,
    required String area,
    required CauseType causeType,
    String? imageUrl,
    String? contactUrl,
    String? summary,
    @Default(0)
        num totalDonations,
    num? globalGivingProjectId,
    Organization? organization,
    num? fundingCurrent,
    num? fundingGoal,
    @JsonKey(
      toJson: Project._checkIfSearchKeywordsAreSet,
    )
        List<String>? nameSearch,
  }) = _Project;

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);
}

Project getProjectFromGlobalGivingAPICall(var json) {
  var organization = Organization(
      name: json["organization"]["name"], url: json["organization"]["url"]);
  var data = Project(
    name: json["title"],
    imageUrl: json["image"]["imagelink"][3]["url"],
    contactUrl: json["contactUrl"],
    summary: json["summary"],
    organization: organization,
    causeType: CauseType.GlobalGivingProject,
    area: json["themeName"],
    globalGivingProjectId: json["id"],
    fundingCurrent: json["funding"],
    fundingGoal: json["goal"],
  );
  return data;
}
