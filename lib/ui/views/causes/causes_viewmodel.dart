import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/causes/good_wallet_fund_model.dart';
import 'package:good_wallet/datamodels/causes/good_wallet_project_model.dart';
import 'package:good_wallet/services/globalgiving/global_giving_api_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

class CausesViewModel extends BaseModel {
  List<GoodWalletProjectModel> projects;
  List<GoodWalletFundModel> goodWalletFunds;

  final _globalGivingAPIservice = locator<GlobalGivingAPIService>();
  final _navigationService = locator<NavigationService>();

  Future fetchProjects() async {
    setBusy(true);
    if (projects == null) {
      projects = await _globalGivingAPIservice.getFeaturedProjects();
      log.i("Fetched project list with length ${projects.length}");
    }
    if (goodWalletFunds == null) {
      goodWalletFunds = [
        GoodWalletFundModel.fromMap({
          "title": "Friend Referral Fund",
          "description":
              "This fund is used to raise money when referring the Good Wallet to your peers",
        }),
        GoodWalletFundModel.fromMap({
          "title": "The Developer Fund",
          "description":
              "Support further developments of the Good Wallet to offer better and more services",
        }),
      ];
      log.i(
          "Fetched good wallet fund list with length ${goodWalletFunds.length}");
    }
    setBusy(false);
    notifyListeners();
  }

  Future navigateToProjectScreen(index) async {
    await _navigationService.navigateTo(Routes.singleProjectViewMobile,
        arguments: SingleProjectViewMobileArguments(project: projects[index]));
  }
}