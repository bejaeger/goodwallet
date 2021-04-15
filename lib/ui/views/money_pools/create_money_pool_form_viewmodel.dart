import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/money_pools/money_pool_model.dart';
import 'package:good_wallet/datamodels/user/user_model.dart';
import 'package:good_wallet/services/money_pools/money_pool_service.dart';
import 'package:good_wallet/services/userdata/user_data_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/ui/views/money_pools/create_money_pool_form_view.form.dart';
import 'package:good_wallet/utils/logger.dart';

class CreateMoneyPoolFormViewModel extends FormViewModel {
  final NavigationService? _navigationService = locator<NavigationService>();
  final MoneyPoolService? _moneyPoolService = locator<MoneyPoolService>();
  final UserDataService? _userDataService = locator<UserDataService>();
  MyUser get currentUser => _userDataService!.currentUser;

  final log = getLogger("create_money_pool_form_viewmodel.dart");

  @override
  void setFormStatus() {}

  bool? isShowBalanceChecked = true;
  void setIsShowBalanceChecked(bool? value) {
    isShowBalanceChecked = value;
    notifyListeners();
  }

  bool isValidData() {
    if (nameValue == null) return false;
    if (nameValue!.length < 3) return false;
    return true;
  }

  Future createMoneyPool() async {
    // TODO:
    // formValidation!
    if (isValidData()) {
      setBusy(true);
      MoneyPoolModel moneyPool = MoneyPoolModel(
        adminName: currentUser.fullName,
        adminUID: currentUser.id,
        name: nameValue!,
        description: descriptionValue,
      );

      try {
        await _moneyPoolService!.createMoneyPool(moneyPool);
      } catch (e) {
        log.e("Could not create money pool, error: ${e.toString()}");
        setValidationMessage(
            "Could not create money pool due to unknown reasons. Please contact the support team with the error message: ${e.toString()}");
        notifyListeners();
      }

      // This will be the implementation of the money pool!
      await Future.delayed(Duration(seconds: 2));

      // this will create the money pool.
      //nameValue!;
      await navigateToSingleMoneyPool(moneyPool);
      setBusy(false);
    } else {
      setValidationMessage("Please provide a valid name for your money pool.");
      notifyListeners();
    }
  }

  Future navigateToSingleMoneyPool(MoneyPoolModel moneyPool) async {
    await _navigationService!.navigateTo(Routes.singleMoneyPoolView,
        arguments: SingleMoneyPoolViewArguments(moneyPool: moneyPool));
  }

  void navigateBack() {
    _navigationService!.back();
  }
}
