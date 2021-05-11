import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/money_pools/base/money_pool.dart';
import 'package:good_wallet/enums/featured_app_type.dart';
import 'package:good_wallet/services/money_pools/money_pool_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';

class RaiseMoneyViewModel extends BaseModel {
  final NavigationService? _navigationService = locator<NavigationService>();
  final MoneyPoolService? _moneyPoolService = locator<MoneyPoolService>();

  final log = getLogger("raise_money_viewmodel.dart");

  List<MoneyPool> get moneyPools => _moneyPoolService!.moneyPools;

  Future fetchMoneyPools({bool force = false}) async {
    setBusy(true);
    try {
      await _moneyPoolService!.loadMoneyPools(currentUser.uid, force);
    } catch (e) {
      // Need to set some validation
      log.e("Could not fetch money pools, error: ${e.toString()}");
      log.e("NEED TO SET SOME validation method HERE!");
    }
    setBusy(false);
  }

  Future navigateToSingleMoneyPoolView(MoneyPool moneyPool) async {
    await _navigationService!.navigateTo(Routes.singleMoneyPoolView,
        arguments: SingleMoneyPoolViewArguments(moneyPool: moneyPool));
  }

  Future navigateToProfileView() async {
    await _navigationService!.navigateTo(Routes.profileViewMobile);
  }

  Future navigateToCreateMoneyPoolView() async {
    await _navigationService!.navigateTo(Routes.createMoneyPoolIntroView);
  }

  Future navigateToManageMoneyPoolView() async {
    await _navigationService!.navigateTo(Routes.moneyPoolsView);
  }

  Future navigateToSingleFeaturedAppView(FeaturedAppType type) async {
    log.i("Navigating to single featured app view");
    await _navigationService!.navigateTo(Routes.singleFeaturedAppView,
        arguments: SingleFeaturedAppViewArguments(type: type));
  }
}
