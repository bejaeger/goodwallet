import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/money_transfer_query_config.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
import 'package:good_wallet/enums/transfer_type.dart';
import 'package:good_wallet/services/userdata/user_data_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class TransfersHistoryViewModel extends BaseModel {
  final UserDataService? _userDataService = locator<UserDataService>();
  final SnackbarService? _snackbarService = locator<SnackbarService>();

  final MoneyTransferQueryConfig _transferConfig =
      MoneyTransferQueryConfig(type: TransferType.All);
  List<MoneyTransfer>? get transfers =>
      _userDataService!.getTransfers(config: _transferConfig);

  final log = getLogger("transfers_history_viewmodel.dart");

  Future listenToData() async {
    setBusy(false);
    await _userDataService!.addTransferDataListener(config: _transferConfig);
    setBusy(true);
  }

  // helper function that figures out transaction
  // type based on transaction data
  TransferType inferTransactionType(MoneyTransfer transfer) {
    return _userDataService!.inferTransactionType(transfer: transfer);
  }

  void showNotImplementedSnackbar() {
    _snackbarService!.showSnackbar(
        title: "Not yet implemented.",
        message: "I know... it's sad",
        duration: Duration(seconds: 2));
  }
}
