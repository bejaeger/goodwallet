import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/causes/concise_info/concise_project_info.dart';
import 'package:good_wallet/datamodels/causes/project.dart';
import 'package:good_wallet/services/causes/causes_data_service.dart';
import 'package:good_wallet/services/globalgiving/global_giving_api_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';

class CausesViewModel extends BaseModel {
  final NavigationService? _navigationService = locator<NavigationService>();
  final CausesDataService? _causesDataService = locator<CausesDataService>();

  final log = getLogger("causes_viewmodel.dart");

  List<Project> get projects => _causesDataService!.projects;
  List<ConciseProjectInfo> get goodWalletFunds =>
      _causesDataService!.goodWalletFunds;
  List<Project> filteredProjects = [];

  void loadFilteredProjects(String? theme) {
    setBusy(true);
    if (theme != null)
      filteredProjects =
          projects.where((element) => element.area == theme).toList();
    log.i("Found ${filteredProjects.length} projects with theme $theme");
    setBusy(false);
  }

  Future navigateToProjectScreen(index) async {
    await _navigationService!.navigateTo(Routes.singleProjectViewMobile,
        arguments:
            SingleProjectViewMobileArguments(project: filteredProjects[index]));
  }

  Future navigateToTransactionsHistoryView() async {
    _navigationService!.navigateTo(Routes.transfersHistoryView);
  }
}
