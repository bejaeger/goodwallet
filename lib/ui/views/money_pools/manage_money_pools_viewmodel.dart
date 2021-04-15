import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/money_pools/money_pool_model.dart';
import 'package:good_wallet/services/money_pools/money_pool_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/money_pools_viewmodel.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class ManageMoneyPoolsViewModel extends MoneyPoolsViewModel {
  final NavigationService? _navigationService = locator<NavigationService>();
  final MoneyPoolService? _moneyPoolService = locator<MoneyPoolService>();

  List<MoneyPoolModel> moneyPools = [];

  final log = getLogger("manage_money_pools_viewmodel.dart");

  Future fetchMoneyPools({bool force = false}) async {
    setBusy(true);
    try {
      moneyPools =
          await _moneyPoolService!.getMoneyPools(currentUser.id, force);
    } catch (e) {
      // Need to set some validation
      log.e("Could not fetch money pools, error: ${e.toString()}");
      log.e("NEED TO SET SOME validation method HERE!");
    }
    setBusy(false);
  }

  Future navigateToSingleMoneyPoolView(MoneyPoolModel moneyPool) async {
    await _navigationService!.navigateTo(Routes.singleMoneyPoolView,
        arguments: SingleMoneyPoolViewArguments(moneyPool: moneyPool));
  }

  void navigateToCreateMoneyPoolView() {
    _navigationService!.replaceWith(Routes.createMoneyPoolIntroView);
  }
}
