import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/enums/dialog_type.dart';
import 'package:good_wallet/ui/views/home/custom_dialogs/stats_dialog_view.dart';
import 'package:stacked_services/stacked_services.dart';

void setupDialogUi() {
  final dialogService = locator<DialogService>();
  final builders = {
    DialogType.Stats: (context, sheetRequest, completer) =>
        StatsDialog(request: sheetRequest, completer: completer),
  };
  dialogService.registerCustomDialogBuilders(builders);
}
