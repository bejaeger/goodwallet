import 'package:good_wallet/datamodels/causes/good_wallet_project_model.dart';
import 'package:good_wallet/datamodels/causes/organization_model.dart';
import 'package:good_wallet/enums/causes_type.dart';
import 'package:good_wallet/utils/logger.dart';

class GlobalGivingProjectModel extends GoodWalletProjectModel {
  final log = getLogger("global_giving_project_model.dart");

  GlobalGivingProjectModel.readJsonProject(var jsonProject) {
    try {
      title = jsonProject["title"];
      imageUrl = jsonProject["image"]["imagelink"][3]["url"];
      contactUrl = jsonProject["contactUrl"];
      var organizationName = jsonProject["organization"]["name"];
      var organizationUrl = jsonProject["organization"]["url"];
      organization = Organization(name: organizationName, url: organizationUrl);
      fundingCurrent = jsonProject["funding"];
      fundingGoal = jsonProject["goal"];
      summary = jsonProject["summary"];
      themeName = jsonProject["themeName"];
      globalGivingProjectId = jsonProject["id"];
      causeType = CauseType.GlobalGivingProject;
    } catch (e) {
      log.e("Failed to read Json project with error: ${e.toString()}");
    }
  }
}
