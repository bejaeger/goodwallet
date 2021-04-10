import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/data/description_texts.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

class MoneyPoolsViewModel extends BaseModel {
  final NavigationService? _navigationService = locator<NavigationService>();
  final DialogService? _dialogService = locator<DialogService>();

  void navigateBack() {
    _navigationService!.back();
  }

  void navigateToCreateMoneyPoolView() {
    _navigationService!.replaceWith(Routes.createMoneyPoolView);
  }

  void navigateToManageMoneyPoolsView() {
    _navigationService!.replaceWith(Routes.manageMoneyPoolsView);
  }

  Future showInformationDialog() async {
    await _dialogService!.showDialog(
      title: "Money pools",
      description: DescriptionText.moneyPoolDescription,
    );
  }
}
