import 'package:flutter_test/flutter_test.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/money_transfer_query_config.dart';
import 'package:good_wallet/enums/transfer_type.dart';
import 'package:good_wallet/services/userdata/user_data_service.dart';

import '../helpers/test_helpers.dart';

UserDataService _getService() => UserDataService();

// TODO: Figure out how to mock authStateChanges!

// void main() {
//   group('UserDataServiceTest -', () {
//     setUp(() => registerServices());
//     tearDown(() => unregisterServices());
//   });

//   group('isValidFirestoreQueryConfig -', () {
//     test('Should be true if simply asked for transfer type donation', () {
//       print("HIER");
//       getAndRegisterFirestoreApi();
//       print("HIER 2");
//       getAndRegisterFirebaseAuthenticationService();
//       print("HIER 4");
//       final service = _getService();
//       final config = MoneyTransferQueryConfig(type: TransferType.Donation);
//       final ok = service.isValidFirestoreQueryConfig(config: config);
//       print("OK: $ok");
//       expect(ok, true);
//     });
//   });
// }
