import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/data/description_texts.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

class MoneyPoolsViewModel extends BaseModel {
  final DialogService? _dialogService = locator<DialogService>();

  Future showInformationDialog() async {
    await _dialogService!.showDialog(
      title: "Money pools",
      description: DescriptionText.moneyPoolDescription,
    );
  }
}
