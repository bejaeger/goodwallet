import 'package:flutter/material.dart';
import 'package:good_wallet/ui/layout_widgets/bottom_sheet_layout.dart';
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
              title: "Accept payments",
              icon: Icon(Icons.qr_code, size: 28),
              description: "Create payment link or QR code"),
          BottomSheetListEntry(
            completer: completer,
            responseData: model.navigateToManageMoneyPoolsView,
            title: "Manage your money pools",
            description: "Invite people and raise together",
            icon: Icon(Icons.people, size: 28),
          ),
          BottomSheetListEntry(
            completer: completer,
            responseData: "Clicked checkout featured apps",
            title: "Checkout our featured apps",
            description: "Raise money effortlessly",
            icon: Icon(Icons.apps, size: 28),
          ),
        ],
      ),
    );
  }
}
