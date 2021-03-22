import 'package:flutter/material.dart';
import 'package:good_wallet/ui/dumb_widgets/bottom_sheet_layout.dart';
import 'package:good_wallet/ui/views/home/bottom_sheets/donate_bottom_sheet_viewmodel.dart';
import 'package:good_wallet/ui/widgets/bottom_sheet_list_entry.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DonateBottomSheetView extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;

  const DonateBottomSheetView({
    Key key,
    this.request,
    this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DonateBottomSheetViewModel>.reactive(
      viewModelBuilder: () => DonateBottomSheetViewModel(),
      builder: (context, model, child) => BottomSheetLayout(
          request: request,
          column: Column(
            children: [
              BottomSheetListEntry(
                completer: completer,
                responseData: "Donate again clicked",
                title: "Donate again",
                icon: Icon(Icons.favorite),
              ),
            ],
          )),
    );
  }
}
