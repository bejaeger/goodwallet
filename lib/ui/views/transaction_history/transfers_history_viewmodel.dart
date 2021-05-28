import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/money_transfer_query_config.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
import 'package:good_wallet/enums/transfer_type.dart';
import 'package:good_wallet/services/transfers_history/transfers_history_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/transfer_base_model.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class TransfersHistoryViewModel extends TransferBaseViewModel {
  final TransfersHistoryService? _transfersManager =
      locator<TransfersHistoryService>();
  final SnackbarService? _snackbarService = locator<SnackbarService>();

  final MoneyTransferQueryConfig _transferConfig =
      MoneyTransferQueryConfig(type: TransferType.AllInvolvingUser);
  List<MoneyTransfer>? get transfers =>
      _transfersManager!.getTransfers(config: _transferConfig);

  final log = getLogger("transfers_history_viewmodel.dart");

  Future listenToData() async {
    setBusy(true);
    await _transfersManager!.addTransferDataListener(config: _transferConfig);
    setBusy(false);
  }

  void showNotImplementedSnackbar() {
    _snackbarService!.showSnackbar(
        title: "Not yet implemented.",
        message: "I know... it's sad",
        duration: Duration(seconds: 2));
  }
}
