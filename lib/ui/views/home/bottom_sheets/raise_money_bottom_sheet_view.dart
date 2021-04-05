import 'package:flutter/material.dart';
import 'package:good_wallet/ui/layout_widgets/bottom_sheet_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/image_icon_paths.dart';
import 'package:good_wallet/ui/views/home/bottom_sheets/raise_money_bottom_sheet_viewmodel.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RaiseMoneyBottomSheetView extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;

  const RaiseMoneyBottomSheetView({
    Key key,
    this.request,
    this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RaiseMoneyBottomSheetViewModel>.reactive(
      viewModelBuilder: () => RaiseMoneyBottomSheetViewModel(),
      builder: (context, model, child) => BottomSheetLayout(
        title: "Raise Money",
        buttons: [
          BottomSheetListEntry(
              completer: completer,
              responseData: model.navigateToAcceptPaymentsView,
              title: "Get payed into your Good Wallet",
              icon: Image.asset(ImageIconPaths.handAcceptingMoney,
                  color: MyColors.paletteBlue),
              description: "Create payment link or QR code"),
          BottomSheetListEntry(
            completer: completer,
            responseData: model.navigateToCreateMoneyPoolView,
            title: "Create money pool",
            description: "Raise together as a community",
            icon: Image.asset(ImageIconPaths.circleOfPeople),
          ),
          BottomSheetListEntry(
            completer: completer,
            responseData: model.showNotImplementedSnackbar,
            title: "Checkout our featured apps",
            description: "Raise effortlessly",
            icon: Image.asset(ImageIconPaths.appsAroundGlobus),
          ),
          BottomSheetListEntry(
            completer: completer,
            responseData: model.showNotImplementedSnackbar,
            title: "Invite friends",
            description: "Raise through the Good Wallet referral fund",
            icon: Image.asset(ImageIconPaths.huggingPeople),
          ),
        ],
      ),
    );
  }
}
