import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/services/payments/dummy_payment_service.dart';
import 'package:good_wallet/services/userdata/user_data_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';

class SingleProjectViewModel extends BaseModel {
  final DialogService? _dialogService = locator<DialogService>();
  final DummyPaymentService? _dummyPaymentService =
      locator<DummyPaymentService>();
  final NavigationService? _navigationService = locator<NavigationService>();
  final UserDataService? _userDataService = locator<UserDataService>();

  final log = getLogger("single_project_viewmodel.dart");

  Future showConfirmationDialog(
      String projectTitle, String donationAmount) async {
    try {
      DialogResponse? response = await _dialogService!.showConfirmationDialog(
        title: 'Confirmation',
        description:
            "Are you sure that you want to donate $donationAmount good dollars to $projectTitle",
        confirmationTitle: 'Yes',
        dialogPlatform: DialogPlatform.Material,
        cancelTitle: 'No',
      );
      if (response!.confirmed) {
        _dummyPaymentService!.processDonation(
            currentUser!.id, projectTitle, int.parse(donationAmount * 100));
      }
      print('DialogResponse: ${response.confirmed}');
    } catch (e) {
      log.e("Couldn't process donation: ${e.toString()}");
      rethrow;
    }
  }

  Future showAmountTooHighDialog(String donationAmount) async {
    await _dialogService!.showConfirmationDialog(
      title: 'Donation Amount Too High',
      description:
          'You cannot donate \$ $donationAmount with just \$ ${userWallet.currentBalance! / 100} in your account.',
    );
  }

  Future? confirmationOrCancellationDistributor(
      String? projectTitle, int donationAmount) {
    if ((userWallet.currentBalance! / 100 - donationAmount) < 0) {
      showAmountTooHighDialog(donationAmount.toString());
    } else {
      showConfirmationDialog(projectTitle!, donationAmount.toString());
    }
    return null;
  }

  void navigateBack() {
    _navigationService!.back();
  }
}
