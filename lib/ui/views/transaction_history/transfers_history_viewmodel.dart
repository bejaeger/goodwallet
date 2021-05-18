import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/money_pools/payouts/money_pool_payout.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/money_transfer_query_config.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
import 'package:good_wallet/enums/transfer_type.dart';
import 'package:good_wallet/services/userdata/user_data_service.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

// TODO: Somehow the transition to the view is not really nice
// Is notifyListeners() called to often? Weird!
// Maybe work with my own implementation after all
class TransfersHistoryViewModel extends StreamViewModel<List<MoneyTransfer>> {
  final UserDataService? _userDataService = locator<UserDataService>();
  final SnackbarService? _snackbarService = locator<SnackbarService>();

  @override
  Stream<List<MoneyTransfer>> get stream =>
      locator<UserDataService>().getTransferDataStream(
          config: MoneyTransferQueryConfig(type: TransferType.All));
  List<MoneyTransfer>? get transfers => data;
  final log = getLogger("transfers_history_viewmodel.dart");

  TransfersHistoryViewModel() {
    setBusy(true);
  }
  @override
  void onData(List<MoneyTransfer>? data) {
    setBusy(false);
    notifyListeners();
  }

  // get latest money pool contributions for send money bottom sheet view
  // Need to add listeners otherwise this will be empty
  //List<MoneyTransfer> get latestTransfers => _userDataService!.getTransfers(type: type);

  String get uid => _userDataService!.currentUser.uid;

  // Listen to stream of latest donations and transactions
  // void addDataListeners() {
  //   setBusy(true);
  //   _userDataService!.addTransferDataListener(
  //       type: TransferType.All, callback: () => setBusy(false));
  // }

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
