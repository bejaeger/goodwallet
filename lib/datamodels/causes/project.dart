import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:good_wallet/datamodels/causes/organization.dart';
import 'package:good_wallet/enums/causes_type.dart';

part 'project.freezed.dart';
part 'project.g.dart';

// Please also see ConciseProjectInfo!

@freezed
class Project with _$Project {
  @JsonSerializable(explicitToJson: true)
  factory Project({
    required String name,
    // TODO: prepare toJson without id set properly as in MoneyTransfer!
    required String id,
    required String area,
    required CauseType causeType,
    String? imageUrl,
    String? contactUrl,
    String? summary,
    @Default(0) num totalDonations,
    num? globalGivingProjectId,
    Organization? organization,
    num? fundingCurrent,
    num? fundingGoal,
  }) = _Project;

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);
}

Project getProjectFromGlobalGivingAPICall(var json) {
  var organization = Organization(
      name: json["organization"]["name"], url: json["organization"]["url"]);
  var data = Project(
    id: "DUMMY",
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
