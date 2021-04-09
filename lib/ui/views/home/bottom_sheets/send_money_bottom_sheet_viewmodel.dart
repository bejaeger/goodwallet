import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

class SendMoneyBottomSheetViewModel extends BaseModel {
  final NavigationService? _navigationService = locator<NavigationService>();

  void navigateToScanQRCodeView() {
    _navigationService!.navigateTo(Routes.qRCodeViewMobile,
        arguments: QRCodeViewMobileArguments(initialIndex: 0));
  }
}
