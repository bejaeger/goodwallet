import 'package:flutter/foundation.dart';
import 'package:good_wallet/datamodels/causes/organization_model.dart';
import 'package:good_wallet/enums/causes_type.dart';
import 'package:good_wallet/utils/datamodel_helpers.dart';
import 'package:good_wallet/utils/logger.dart';

// PODO for a good cause

class GoodWalletProjectModel {
  String? title;
  String? imageUrl;
  String? contactUrl;
  String? summary;
  num? globalGivingProjectId;

  Organization? organization;

  num? fundingCurrent;
  num? fundingGoal;
  String? themeName;

  CauseType? causeType;

  GoodWalletProjectModel({
    required this.title,
    required this.organization,
    required this.themeName,
    required this.causeType,
    this.imageUrl,
    this.contactUrl,
    this.summary,
    this.fundingCurrent,
    this.fundingGoal,
    this.globalGivingProjectId,
  });

  Map<String, dynamic> toJson() {
    var returnJson = {
      'title': title,
      'imageUrl': imageUrl,
      'contactUrl': contactUrl,
      'summary': summary,
      'organization': organization!.toJson(),
      'fundingCurrent': fundingCurrent,
      'fundingGoal': fundingGoal,
      'themeName': themeName,
      'globalGivingProjectId': globalGivingProjectId,
      'causeType': describeEnum(causeType),
    };
    return returnJson;
  }

  static GoodWalletProjectModel fromMap(Map<String, dynamic> map) {
    final log = getLogger("good_wallet_project_model.dart");
    try {
      var data = GoodWalletProjectModel(
        title: map["title"],
        imageUrl: map["imageUrl"],
        contactUrl: map["contactUrl"],
        summary: map["summary"],
        organization: Organization.fromMap(map["organization"]),
        causeType: getCauseTypeFromString(map["causeType"]),
        themeName: map["themeName"],
      );
      data.globalGivingProjectId =
          returnIfAvailable(map, "globalGivingProjectId");
      data.fundingCurrent = returnIfAvailable(map, "fundingCurrent");
      data.fundingGoal = returnIfAvailable(map, "fundingGoal");
      return data;
    } catch (e) {
      log.e("Could not retrieve good wallet fromMap");
      rethrow;
    }
  }
}
