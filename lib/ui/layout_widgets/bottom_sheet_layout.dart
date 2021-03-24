import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/home/bottom_sheets/raise_money_bottom_sheet_viewmodel.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BottomSheetLayout extends StatelessWidget {
  final String title;
  final SheetRequest request;
  final List<BottomSheetListEntry> buttons;
  final Widget widgetBeforeButtons;
  final Widget widgetAfterButtons;

  const BottomSheetLayout({
    Key key,
    @required this.title,
    this.request,
    this.buttons,
    this.widgetBeforeButtons,
    this.widgetAfterButtons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RaiseMoneyBottomSheetViewModel>.reactive(
      viewModelBuilder: () => RaiseMoneyBottomSheetViewModel(),
      builder: (context, model, child) => Container(
        padding: EdgeInsets.only(top: 2),
        constraints: BoxConstraints(
            maxWidth:
                screenWidth(context) - 2 * LayoutSettings.horizontalPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 40,
              child: Divider(
                thickness: 4,
                color: Colors.grey[400],
              ),
            ),
            verticalSpaceSmall,
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorSettings.blackTextColor,
                  ),
                ),
                verticalSpaceMedium,
                if (widgetBeforeButtons != null) widgetBeforeButtons,
                if (buttons != null)
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: buttons),
                if (widgetAfterButtons != null) verticalSpaceMedium,
                if (widgetAfterButtons != null) widgetAfterButtons,
                verticalSpaceMedium,
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// widget for one entry in the bottom sheet

class BottomSheetListEntry extends StatelessWidget {
  final String title;
  final String description;
  final Function(SheetResponse p1) completer;
  final dynamic responseData;
  final Icon icon;

  const BottomSheetListEntry({
    Key key,
    @required this.completer,
    @required this.responseData,
    @required this.title,
    this.icon,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => completer(SheetResponse(responseData: responseData)),
      child: ListTile(
        leading: icon != null
            ? CircleAvatar(
                backgroundColor: Colors.transparent,
                child: icon,
              )
            : null,
        title: Text(
          title,
          style: TextStyle(
              fontWeight: icon != null ? FontWeight.w400 : FontWeight.w600),
        ),
        subtitle: description != null
            ? Text(description,
                style: textTheme(context).bodyText2.copyWith(fontSize: 15))
            : null,
      ),
    );
  }
}
