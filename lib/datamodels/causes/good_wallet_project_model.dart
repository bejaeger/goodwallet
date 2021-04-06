import 'package:good_wallet/datamodels/causes/organization_model.dart';
import 'package:good_wallet/enums/causes_type.dart';
import 'package:good_wallet/utils/datamodel_helpers.dart';

// PODO for a good cause

class GoodWalletProjectModel {
  String title;
  String imageUrl;
  String contactUrl;
  String summary;
  num globalGivingProjectId;

  Organization organization;

  num fundingCurrent;
  num fundingGoal;
  String themeName;

  CauseType causeType;

  GoodWalletProjectModel(
      {this.title,
      this.imageUrl,
      this.contactUrl,
      this.summary,
      this.organization,
      this.fundingCurrent,
      this.fundingGoal,
      this.themeName,
      this.globalGivingProjectId,
      this.causeType});

  Map<String, dynamic> toJson() {
    var returnJson = {
      'title': title,
      'imageUrl': imageUrl,
      'contactUrl': contactUrl,
      'summary': summary,
      'organization': organization.toJson(),
      'fundingCurrent': fundingCurrent,
      'fundingGoal': fundingGoal,
      'themeName': themeName,
      'globalGivingProjectId': globalGivingProjectId,
      'causeType': causeType.toString(),
    };
    return returnJson;
  }

  static GoodWalletProjectModel fromMap(Map<String, dynamic> map) {
    var data = GoodWalletProjectModel(
      title: map["title"],
      imageUrl: map["imageUrl"],
      contactUrl: map["contactUrl"],
      summary: map["summary"],
      organization: Organization.fromMap(map["organization"]),
      causeType: getCauseTypeFromString(map["causeType"]),
    );
    data.globalGivingProjectId =
        returnIfAvailable(map, "globalGivingProjectId");
    data.fundingCurrent = returnIfAvailable(map, "fundingCurrent");
    data.fundingGoal = returnIfAvailable(map, "fundingGoal");
    data.themeName = returnIfAvailable(map, "themeName");
    return data;
  }

  //   // use this when retrieving data from firestore
  // static GoodWalletProjectModel fromMap(Map<String, dynamic> map) {
  //   try {
  //     var data = GoodWalletProjectModel(
  //       title: map["title"],
  //       imageUrl: map["imageUrl"],
  //       contactUrl: map["contactUrl"],
  //       organization: Organization.fromMap(map["organization"]),
  //       fundingCurrent: map["fundingCurrent"],
  //       fundingGoal: map["fundingGoal"],
  //       summary: map["summary"],
  //       themeName: map["themeName"],
  //       globalGivingProjectId: map["globalGivingProjectId"],
  //       causeType: CauseType.GlobalGivingProject,
  //     );
  //     return data;
  //   } catch (e) {
  //     final log = getLogger("global_giving_project_model.dart");
  //     log.e("Failed to read Json project with error: ${e.toString()}");
  //   }
  // }

}
