import 'package:flutter/material.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/enums/bottom_sheet_type.dart';
import 'package:good_wallet/ui/views/home/bottom_sheets/give_bottom_sheet_view.dart';
import 'package:good_wallet/ui/views/home/bottom_sheets/raise_money_bottom_sheet_view.dart';
import 'package:good_wallet/ui/views/home/bottom_sheets/send_money_bottom_sheet_view.dart';
import 'package:good_wallet/ui/views/money_pools/bottom_sheets/money_pool_invitation_bottom_sheet_view.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';

void setupBottomSheetUi() {
  final BottomSheetService? _bottomSheetService = locator<BottomSheetService>();

  final builders = {
    BottomSheetType.raise: (context, sheetRequest, completer) =>
        RaiseMoneyBottomSheetView(request: sheetRequest, completer: completer),
    BottomSheetType.sendMoney: (context, sheetRequest, completer) =>
        SendMoneyBottomSheetView(request: sheetRequest, completer: completer),
    BottomSheetType.donate: (context, sheetRequest, completer) =>
        GiveBottomSheetView(request: sheetRequest, completer: completer),
    BottomSheetType.moneyPoolInvitation: (context, sheetRequest, completer) =>
        MoneyPoolInvitationBottomSheetView(
            request: sheetRequest, completer: completer),
  };

  _bottomSheetService!.setCustomSheetBuilders(builders);
}
