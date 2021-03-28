import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

class ManageMoneyPoolsViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();

  void navigateBack() {
    _navigationService.back();
  }
}
