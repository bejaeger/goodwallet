import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

class LayoutTemplateViewModel extends BaseModel {
  final SnackbarService? _snackbarService = locator<SnackbarService>();

  void showSnackBar(String msg) {
    _snackbarService!.showSnackbar(message: msg);
  }
}
