import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/recipient_info.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/sender_info.dart';
import 'package:good_wallet/datamodels/user/public_user_info.dart';
import 'package:good_wallet/enums/money_source.dart';
import 'package:good_wallet/enums/search_type.dart';
import 'package:good_wallet/enums/transfer_type.dart';
import 'package:good_wallet/exceptions/qrcode_service_exception.dart';
import 'package:good_wallet/services/qrcode/qrcode_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class QRCodeViewModel extends BaseModel {
  final log = getLogger("qrcode_viewmodel.dart");
  final QRCodeService? _qrCodeService = locator<QRCodeService>();
  final SnackbarService? _snackbarService = locator<SnackbarService>();
  final NavigationService? _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  bool doneScanning = false;
  SearchType searchType = SearchType.Explore;
  QRCodeViewModel({required SearchType? searchTypeIn}) {
    if (searchTypeIn != null) searchType = searchTypeIn;
  }

  String getUserInfo() {
    return _qrCodeService!.getEncodedUserInfo(currentUser);
  }

  Future navigateToSearchViewMobile() async {
    await _navigationService!.navigateTo(Routes.searchView,
        arguments:
            SearchViewArguments(searchType: searchType, autofocus: true));
  }

  Future analyzeScanResult({required Barcode result}) async {
    if (isBusy) {
      return null;
    }
    if (doneScanning) return;
    setBusy(true);
    var deadTime = Duration(seconds: 3);
    log.i(
        "Scanned code with result '${result.code}' and format '${result.format}");
    PublicUserInfo? userInfo;
    try {
      userInfo = _qrCodeService!.analyzeScanResult(result);
    } catch (e) {
      if (e is QRCodeServiceException) {
        log.e("Error when reading QR Code: $e");
        _snackbarService!.showSnackbar(
            title: "Could not read QR code",
            message: "${e.prettyDetails}",
            duration: deadTime);
        await Future.delayed(deadTime);
      } else {
        rethrow;
      }
    }

    log.i("Successfully read user information from QR Code");

    // navigation depends on searchType.
    if (searchType == SearchType.UserToTransferTo) {
      log.i("replacing view with transfer amount view");
      _navigationService!.replaceWith(Routes.transferFundsAmountView,
          arguments: TransferFundsAmountViewArguments(
              senderInfo: SenderInfo(moneySource: MoneySource.Bank),
              type: TransferType.User2UserSent,
              recipientInfo:
                  RecipientInfo.user(name: userInfo!.name, id: userInfo.uid)));
    } else if (searchType == SearchType.UserToInviteToMP) {
      log.i("navigating back with result");
      _navigationService!.back(
          result: PublicUserInfo(uid: userInfo!.uid, name: userInfo.name));
    } else {
      log.i("navigate to user profile");
      dynamic result = await _navigationService!.navigateTo(
          Routes.publicProfileViewMobile,
          arguments: PublicProfileViewMobileArguments(uid: userInfo!.uid));
      if (result == false) {
        await _dialogService.showDialog(
          title: "User could not be found",
          description: "The QR Code does not seem to be valid!",
          dialogPlatform: DialogPlatform.Material,
        );
        _navigationService!.back();
      }
    }

    doneScanning = true;
    setBusy(false);
  }
}
