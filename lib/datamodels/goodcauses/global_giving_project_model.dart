import 'package:good_wallet/datamodels/goodcauses/good_wallet_project_model.dart';
import 'package:good_wallet/datamodels/goodcauses/organization_model.dart';

class GlobalGivingProjectModel extends GoodWalletProjectModel {
  GlobalGivingProjectModel.readJsonProject(var jsonProject) {
    try {
      title = jsonProject["title"];
      imageUrl = jsonProject["image"]["imagelink"][2]["url"];
      contactUrl = jsonProject["contactUrl"];
      var organizationName = jsonProject["organization"]["name"];
      var organizationUrl = jsonProject["organization"]["url"];
      organization = Organization(name: organizationName, url: organizationUrl);
      fundingCurrent = jsonProject["funding"];
      fundingGoal = jsonProject["goal"];
      summary = jsonProject["summary"];
      themeName = jsonProject["themeName"];
    } catch (e) {
      print(
          "Error in GlobalGivingProjectModel.readJsonProject: ${e.toString()}");
    }
  }
}
