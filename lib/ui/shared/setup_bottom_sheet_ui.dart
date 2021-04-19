import 'package:flutter/material.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/enums/bottom_sheet_type.dart';
import 'package:good_wallet/ui/views/home/bottom_sheets/raise_money_bottom_sheet_view.dart';
import 'package:good_wallet/ui/views/home/bottom_sheets/send_money_bottom_sheet_view.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';

void setupBottomSheetUi() {
  final BottomSheetService? _bottomSheetService = locator<BottomSheetService>();

  final builders = {
    BottomSheetType.raise: (context, sheetRequest, completer) =>
        RaiseMoneyBottomSheetView(request: sheetRequest, completer: completer),
    BottomSheetType.sendMoney: (context, sheetRequest, completer) =>
        SendMoneyBottomSheetView(request: sheetRequest, completer: completer),
  };

  _bottomSheetService!.setCustomSheetBuilders(builders);
}
