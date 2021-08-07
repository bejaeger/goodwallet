import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/enums/dialog_type.dart';
import 'package:good_wallet/ui/shared/custom_dialogs/money_transfer_dialog_view.dart';
import 'package:good_wallet/ui/shared/custom_dialogs/stats_dialog_view.dart';
import 'package:good_wallet/ui/shared/onboarding_dialog_view.dart';
import 'package:stacked_services/stacked_services.dart';

void setupDialogUi() {
  final dialogService = locator<DialogService>();
  final builders = {
    DialogType.Stats: (context, sheetRequest, completer) =>
        StatsDialog(request: sheetRequest, completer: completer),
    DialogType.RaisedFundsStats: (context, sheetRequest, completer) =>
        RaisedFundsStatsDialog(request: sheetRequest, completer: completer),
    DialogType.DonationStats: (context, sheetRequest, completer) =>
        DonationStatsDialog(request: sheetRequest, completer: completer),
    DialogType.MoneyTransfer: (context, sheetRequest, completer) =>
        MoneyTransferDialogView(request: sheetRequest, completer: completer),
    DialogType.Onboarding: (context, sheetRequest, completer) =>
        OnboardingDialogView(request: sheetRequest, completer: completer),
  };
  dialogService.registerCustomDialogBuilders(builders);
}
