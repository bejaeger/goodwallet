import 'package:good_wallet/app/locator.dart';
import 'package:good_wallet/ui/views/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

class SingleProjectViewModel extends BaseModel {
  final _dialogService = locator<DialogService>();

  Future showConfirmationDialog(
      String projectTitle, String donationAmount) async {
    DialogResponse response = await _dialogService.showConfirmationDialog(
      title: 'Confirmation',
      description:
          "Are you sure that you want to donate $donationAmount good dollars to $projectTitle",
      confirmationTitle: 'Yes',
      dialogPlatform: DialogPlatform.Material,
      cancelTitle: 'No',
    );

    print('DialogResponse: ${response?.confirmed}');
  }

  // Future showAmountTooHighDialog() async{
  //   await _dialogService.showAmountTooHighDialog(
  //     title: 'Title',
  //     description: 'description',
  //   );
  // }
}
