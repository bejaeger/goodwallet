import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/causes/good_wallet_fund_model.dart';
import 'package:good_wallet/datamodels/causes/good_wallet_project_model.dart';
import 'package:good_wallet/enums/causes_type.dart';
import 'package:good_wallet/services/causes/causes_data_service.dart';
import 'package:good_wallet/services/globalgiving/global_giving_api_service.dart';
import 'package:good_wallet/services/userdata/user_data_service.dart';
import 'package:good_wallet/ui/shared/image_paths.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CausesFilterViewModel extends BaseModel {
  final NavigationService? _navigationService = locator<NavigationService>();

  final CausesDataService? _causesDataService = locator<CausesDataService>();

  final log = getLogger("causes_viewmodel.dart");
  List<GoodWalletProjectModel> get projects => _causesDataService!.projects;

  List<GoodWalletFundModel>? goodWalletFunds;
  List<String> get uniqueThemes => _causesDataService!.uniqueThemes;

  Future fetchCauses() async {
    setBusy(true);
    await _causesDataService!.loadProjects();
    if (goodWalletFunds == null) {
      goodWalletFunds = [
        GoodWalletFundModel(
          title: "Friend Referral Fund",
          description:
              "This fund is used to raise money when referring the Good Wallet to your peers",
          imagePath: ImagePath.peopleHoldingHands,
        ),
        GoodWalletFundModel(
          title: "The Developer Fund",
          description:
              "Support further developments of the Good Wallet to offer better services",
          imagePath: ImagePath.workNextToCreek,
        ),
      ];
      log.i(
          "Fetched good wallet fund list with length ${goodWalletFunds!.length}");
    }
    setBusy(false);
  }

  Future navigateToTransactionsHistoryView() async {
    _navigationService!.navigateTo(Routes.transactionsView);
  }

  Future navigateToCausesViewMobile(index) async {
    await _navigationService!.navigateTo(Routes.causesViewMobile,
        arguments: CausesViewMobileArguments(theme: uniqueThemes[index]));
  }
}
