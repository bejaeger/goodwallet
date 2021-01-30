import 'package:good_wallet/datamodels/goodcauses/organization_model.dart';
import 'package:good_wallet/utils/datamodel_helpers.dart';

// PODO for a good cause defined by our organization

class GoodWalletProjectModel {
  String title;
  String imageUrl;
  String contactUrl;
  String summary;

  Organization organization;

  num fundingCurrent;
  num fundingGoal;

  GoodWalletProjectModel(
      {this.title,
      this.imageUrl,
      this.contactUrl,
      this.summary,
      this.organization,
      this.fundingCurrent,
      this.fundingGoal});

  Map<String, dynamic> toJson() {
    var returnJson = {
      'title': title,
      'imageUrl': imageUrl,
      'contactUrl': contactUrl,
      'summary': summary,
      'organization': organization.toJson(),
      'fundingCurrent': fundingCurrent,
      'fundingGoal': fundingGoal,
    };
    return returnJson;
  }

  static GoodWalletProjectModel fromMap(Map<String, dynamic> map) {
    var data = GoodWalletProjectModel(
      title: map["title"],
      imageUrl: map["imageUrl"],
      contactUrl: map["contactUrl"],
      summary: map["summary"],
      organization: map["organization"],
    );
    data.fundingCurrent = returnIfAvailable(map, "fundingCurrent");
    data.fundingGoal = returnIfAvailable(map, "fundingGoal");
    return data;
  }
}
