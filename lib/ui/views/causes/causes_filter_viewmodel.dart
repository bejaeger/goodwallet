import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/causes/concise_info/concise_project_info.dart';
import 'package:good_wallet/datamodels/causes/project.dart';
import 'package:good_wallet/services/causes/causes_data_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class CausesFilterViewModel extends BaseModel {
  final NavigationService? _navigationService = locator<NavigationService>();

  final CausesDataService? _causesDataService = locator<CausesDataService>();

  final log = getLogger("causes_viewmodel.dart");
  List<Project> get projects => _causesDataService!.projects;

  List<ConciseProjectInfo> get goodWalletFunds =>
      _causesDataService!.goodWalletFunds;
  List<String> get uniqueThemes => _causesDataService!.uniqueThemes;

  Future fetchCauses() async {
    setBusy(true);
    await _causesDataService!.loadProjects();
    await _causesDataService!.loadGoodWalletFunds();
    setBusy(false);
  }

  Future navigateToTransactionsHistoryView() async {
    _navigationService!.navigateTo(Routes.transfersHistoryView);
  }

  Future navigateToCausesViewMobile(index) async {
    await _navigationService!.navigateTo(Routes.causesViewMobile,
        arguments: CausesViewMobileArguments(theme: uniqueThemes[index]));
  }
}
