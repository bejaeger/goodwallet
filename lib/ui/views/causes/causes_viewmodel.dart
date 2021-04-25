import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/causes/good_wallet_fund_model.dart';
import 'package:good_wallet/datamodels/causes/good_wallet_project_model.dart';
import 'package:good_wallet/enums/causes_type.dart';
import 'package:good_wallet/services/causes/causes_data_service.dart';
import 'package:good_wallet/services/globalgiving/global_giving_api_service.dart';
import 'package:good_wallet/ui/shared/image_paths.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';

class CausesViewModel extends BaseModel {
  final GlobalGivingAPIService? _globalGivingAPIservice =
      locator<GlobalGivingAPIService>();
  final NavigationService? _navigationService = locator<NavigationService>();
  final CollectionReference _causesCollectionReference =
      FirebaseFirestore.instance.collection("causes");
  final CausesDataService? _causesDataService = locator<CausesDataService>();

  final log = getLogger("causes_viewmodel.dart");

  List<GoodWalletProjectModel> get projects => _causesDataService!.projects;
  List<GoodWalletFundModel>? goodWalletFunds;
  List<GoodWalletProjectModel> filteredProjects = [];

  void loadFilteredProjects(String? theme) {
    setBusy(true);
    if (theme != null)
      filteredProjects =
          projects.where((element) => element.themeName == theme).toList();
    log.i("Found ${filteredProjects.length} projects with theme $theme");
    setBusy(false);
  }

  Future navigateToProjectScreen(index) async {
    await _navigationService!.navigateTo(Routes.singleProjectViewMobile,
        arguments: SingleProjectViewMobileArguments(project: projects[index]));
  }

  Future navigateToTransactionsHistoryView() async {
    _navigationService!.navigateTo(Routes.transactionsView);
  }
}
