import 'package:flutter/material.dart';
import 'package:good_wallet/ui/dumb_widgets/bottom_sheet_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/views/home/bottom_sheets/send_money_bottom_sheet_viewmodel.dart';
import 'package:good_wallet/ui/widgets/bottom_sheet_list_entry.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SendMoneyBottomSheetView extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;

  const SendMoneyBottomSheetView({
    Key key,
    this.request,
    this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SendMoneyBottomSheetViewModel>.reactive(
      viewModelBuilder: () => SendMoneyBottomSheetViewModel(),
      builder: (context, model, child) => BottomSheetLayout(
          request: request,
          column: Column(
            children: [
              BottomSheetListEntry(
                completer: completer,
                responseData: "Send money clicked",
                title: "Send again",
                icon: Icon(Icons.send),
              ),
            ],
          )),
    );
  }
}
