import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
import 'package:good_wallet/ui/layout_widgets/bottom_sheet_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/image_icon_paths.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
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
        description: "Your sent funds become charitable-only",
        title: "Give the Gift of Giving",
        widgetBeforeButtons: request.customData != null
            ? request.customData.length > 0
                ? Container(
                    height: 100,
                    width: screenWidth(context),
                    child: UserList(
                      latestTransactions: model.latestTransactions,
                      onUserPressed: model.navigateToTransferFundsAmountView,
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

class UserList extends StatelessWidget {
  final List<MoneyTransfer> latestTransactions;
  final void Function(MoneyTransfer) onUserPressed;
  //final void Function() onAllUsers;

  const UserList({
    Key? key,
    required this.latestTransactions,
    required this.onUserPressed,
    //required this.onAllUsers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(left: LayoutSettings.horizontalPadding),
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: latestTransactions.length,
      itemBuilder: (context, index) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CallToActionButtonRoundInitials(
              color: MyColors.niceColors[index % 4],
              onPressed: () => onUserPressed(latestTransactions[index]),
              name: latestTransactions[index].transferDetails.recipientName),
          horizontalSpaceTiny,
        ],
      ),
    );
  }
}
