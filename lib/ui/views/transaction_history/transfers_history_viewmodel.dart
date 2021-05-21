import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/money_transfer_query_config.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
import 'package:good_wallet/enums/transfer_type.dart';
import 'package:good_wallet/managers/transfers_manager.dart';
import 'package:good_wallet/ui/views/common_viewmodels/transfer_base_model.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class TransfersHistoryViewModel extends TransferBaseViewModel {
  final TransfersManager? _transfersManager = locator<TransfersManager>();
  final SnackbarService? _snackbarService = locator<SnackbarService>();

  final MoneyTransferQueryConfig _transferConfig =
      MoneyTransferQueryConfig(type: TransferType.All);
  List<MoneyTransfer>? get transfers =>
      _transfersManager!.getTransfers(config: _transferConfig);

  final log = getLogger("transfers_history_viewmodel.dart");

  Future listenToData() async {
    setBusy(false);
    await _transfersManager!.addTransferDataListener(config: _transferConfig);
    setBusy(true);
  }

  void showNotImplementedSnackbar() {
    _snackbarService!.showSnackbar(
        title: "Not yet implemented.",
        message: "I know... it's sad",
        duration: Duration(seconds: 2));
  }
}
