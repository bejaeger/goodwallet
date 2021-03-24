import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

class StripeCheckoutMobileViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future showSuccessDialog() async {
    _navigationService.back();
    await _dialogService.showDialog(
      title: 'Successfully transferred 7 Good Dollars to Hans!',
      description: "You are the best!",
    );
  }

  Future showDeniedDialog() async {
    _navigationService.back();
    await _dialogService.showDialog(
      title: 'Transaction Denied!',
      description: "Do better!",
    );
  }
}
