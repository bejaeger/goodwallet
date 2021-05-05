import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/money_pools/base/money_pool.dart';
import 'package:good_wallet/services/money_pools/money_pool_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:rxdart/subjects.dart';

class LayoutTemplateViewModel extends BaseModel {
  final MoneyPoolService? _moneyPoolService = locator<MoneyPoolService>();

  List<MoneyPool> get moneyPoolsInvitedTo =>
      _moneyPoolService!.moneyPoolsInvitedTo;

  int numberInvitedMoneyPoolsSubject = 0;

  final log = getLogger("layout_template_viewmodel.dart");
  LayoutTemplateViewModel() {
    // listen to the number of money pools the user is invited to
    // to adjust "money pool" icon
    _moneyPoolService!.numberInvitedMoneyPoolsSubject.listen((int integer) {
      numberInvitedMoneyPoolsSubject = integer;
      notifyListeners();
    });

    log.i("Constructing layout template view model");
  }
}
