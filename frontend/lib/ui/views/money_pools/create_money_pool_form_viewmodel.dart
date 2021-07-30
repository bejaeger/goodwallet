import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/money_pools/base/money_pool.dart';
import 'package:good_wallet/datamodels/money_pools/settings/money_pool_settings.dart';
import 'package:good_wallet/datamodels/money_pools/users/contributing_user.dart';
import 'package:good_wallet/datamodels/user/user.dart';
import 'package:good_wallet/services/money_pools/money_pools_service.dart';
import 'package:good_wallet/services/user/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/ui/views/money_pools/create_money_pool_form_view.form.dart';
import 'package:good_wallet/utils/logger.dart';

class CreateMoneyPoolFormViewModel extends FormViewModel {
  final NavigationService? _navigationService = locator<NavigationService>();
  final MoneyPoolsService? _moneyPoolsService = locator<MoneyPoolsService>();
  final UserService? _userService = locator<UserService>();
  User get currentUser => _userService!.currentUser;

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
      MoneyPool moneyPool = MoneyPool(
        adminName: currentUser.fullName,
        adminUID: currentUser.uid,
        name: nameValue!,
        total: 0,
        moneyPoolSettings: MoneyPoolSettings(showTotal: true),
        currency: 'cad',
        description: descriptionValue,
        contributingUserIds: [currentUser.uid],
        contributingUsers: [
          ContributingUser(uid: currentUser.uid, name: currentUser.fullName)
        ],
        invitedUserIds: [],
        invitedUsers: [],
        createdAt: FieldValue.serverTimestamp(),
      );

      try {
        moneyPool = await _moneyPoolsService!
            .createAndReturnMoneyPool(moneyPool: moneyPool);
      } catch (e) {
        log.e("Could not create money pool, error: ${e.toString()}");
        setValidationMessage(
            "Could not create money pool due to unknown reasons. Please contact the support team with the error message: ${e.toString()}");
        notifyListeners();
      }

      // This will be the implementation of the money pool!
      await Future.delayed(Duration(seconds: 1));
      // this will create the money pool.
      await _navigationService!.clearTillFirstAndShow(
        Routes.singleMoneyPoolView,
        arguments: SingleMoneyPoolViewArguments(moneyPool: moneyPool),
      );
      setBusy(false);
    } else {
      setValidationMessage("Please provide a valid name for your money pool.");
      notifyListeners();
    }
  }

  Future navigateToSingleMoneyPool(MoneyPool moneyPool) async {
    await _navigationService!.navigateTo(Routes.singleMoneyPoolView,
        arguments: SingleMoneyPoolViewArguments(moneyPool: moneyPool));
  }

  void navigateBack() {
    _navigationService!.back();
  }
}
