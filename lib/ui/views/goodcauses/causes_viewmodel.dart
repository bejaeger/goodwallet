import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/goodcauses/global_giving_project_model.dart';
import 'package:good_wallet/datamodels/goodcauses/good_wallet_project_model.dart';
import 'package:good_wallet/services/globalgiving/global_giving_api_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

class CausesViewModel extends BaseModel {
  List<GoodWalletProjectModel> projects;

  final _globalGivingAPIservice = locator<GlobalGivingAPIService>();
  final _navigationService = locator<NavigationService>();
  Future fetchProjects() async {
    if (projects == null) {
      setBusy(true);
      projects = await _globalGivingAPIservice.getFeaturedProjects();
      setBusy(false);
      notifyListeners();
    }
  }

  Future navigateToProjectScreen(index) async {
    await _navigationService.navigateTo(Routes.singleProjectViewMobile,
        arguments: SingleProjectViewMobileArguments(project: projects[index]));
  }
}
