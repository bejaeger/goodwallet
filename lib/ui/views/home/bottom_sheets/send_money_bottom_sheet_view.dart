import 'package:flutter/material.dart';
import 'package:good_wallet/ui/layout_widgets/bottom_sheet_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/image_icon_paths.dart';
import 'package:good_wallet/ui/views/home/bottom_sheets/send_money_bottom_sheet_viewmodel.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SendMoneyBottomSheetView extends StatelessWidget {
  final SheetRequest? request;
  final Function(SheetResponse)? completer;

  const SendMoneyBottomSheetView({
    Key? key,
    this.request,
    this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SendMoneyBottomSheetViewModel>.reactive(
      viewModelBuilder: () => SendMoneyBottomSheetViewModel(),
      builder: (context, model, child) => BottomSheetLayout(
        title: "Send Money",
        widgetBeforeButtons: Container(
          height: 80,
          width: screenWidth(context) * 0.8,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              CircleAvatar(
                foregroundColor: MyColors.paletteBlue,
                backgroundColor: MyColors.paletteBlue.withOpacity(0.4),
                radius: 30,
                child: Text("BJ"),
              ),
              horizontalSpaceSmall,
              CircleAvatar(
                foregroundColor: MyColors.paletteTurquoise,
                backgroundColor: MyColors.paletteTurquoise.withOpacity(0.4),
                child: Text("KE"),
                radius: 30,
              ),
              horizontalSpaceSmall,
              CircleAvatar(
                foregroundColor: MyColors.paletteGrey,
                backgroundColor: MyColors.paletteGrey.withOpacity(0.4),
                child: Text("PM"),
                radius: 30,
              )
            ],
          ),
        ),
        buttons: [
          BottomSheetListEntry(
            completer: completer,
            responseData: model.navigateToSendMoneyViewMobile,
            title: "Search for user or money pool",
            icon: Image.asset(ImageIconPaths.magnifyingGlass),
          ),
          BottomSheetListEntry(
            completer: completer,
            responseData: model.navigateToScanQRCodeView,
            title: "Scan user QR code",
            icon: Image.asset(ImageIconPaths.qrcodeScan),
          ),
        ],
      ),
    );
  }
}
