import 'package:flutter/material.dart';
import 'package:good_wallet/ui/dumb_widgets/bottom_sheet_layout.dart';
import 'package:good_wallet/ui/views/home/bottom_sheets/raise_money_bottom_sheet_viewmodel.dart';
import 'package:good_wallet/ui/widgets/bottom_sheet_list_entry.dart';
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
        request: request,
        column: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomSheetListEntry(
                completer: completer,
                responseData: "Clicked accept payments",
                title: "Accept payments",
                icon: Icon(Icons.qr_code_scanner_rounded),
                description: "Create personal payment link"),
            BottomSheetListEntry(
              completer: completer,
              responseData: "Clicked create money pool",
              title: "Create money pool",
              icon: Icon(Icons.people),
            ),
            BottomSheetListEntry(
              completer: completer,
              responseData: "Clicked checkout good apps",
              title: "Checkout our good apps",
              icon: Icon(Icons.apps),
            ),
          ],
        ),
      ),
    );
  }
}
