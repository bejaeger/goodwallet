import 'package:flutter/material.dart';
import 'package:good_wallet/ui/layout_widgets/bottom_sheet_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/image_icon_paths.dart';
import 'package:good_wallet/ui/views/home/bottom_sheets/send_money_bottom_sheet_viewmodel.dart';
import 'package:good_wallet/ui/widgets/call_to_action_button.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SendMoneyBottomSheetView extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;

  const SendMoneyBottomSheetView({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SendMoneyBottomSheetViewModel>.reactive(
      viewModelBuilder: () =>
          SendMoneyBottomSheetViewModel(latestTransactions: request.customData),
      builder: (context, model, child) => BottomSheetLayout(
        title: "Send Money",
        widgetBeforeButtons: request.customData != null
            ? request.customData.length > 0
                ? Container(
                    height: 100,
                    width: screenWidth(context) * 0.8,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: model.latestTransactions.length,
                      itemBuilder: (context, index) => Row(
                        children: [
                          horizontalSpaceSmall,
                          CallToActionButtonRoundInitials(
                              color: MyColors.paletteBlue.withOpacity(0.9),
                              onPressed: () =>
                                  model.navigateToTransferFundsAmountView(
                                      model.latestTransactions[index]),
                              name: model.latestTransactions[index]
                                  .transferDetails.recipientName),
                        ],
                      ),
                    ),
                  )
                : null
            : null,
        buttons: [
          BottomSheetListEntry(
            completer: completer,
            responseData: model.navigateToSearchViewMobile,
            title: "Search for user",
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
