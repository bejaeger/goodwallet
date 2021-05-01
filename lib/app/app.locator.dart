// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/causes/causes_data_service.dart';
import '../services/globalgiving/global_giving_api_service.dart';
import '../services/money_pools/money_pool_service.dart';
import '../services/payments/dummy_payment_service.dart';
import '../services/payments/firestore_payment_data_service.dart';
import '../services/payments/stripe_payment_service.dart';
import '../services/qrcode/qrcode_service.dart';
import '../services/userdata/user_data_service.dart';
import '../ui/views/layout/navigation_bar_viewmodel.dart';
import '../ui/views/payments/send_money_viewmodel.dart';
import '../ui/views/transaction_history/transactions_history_layout_viewmodel.dart';
import '../ui/views/wallet/wallet_viewmodel.dart';

final locator = StackedLocator.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => FirestorePaymentDataService());
  locator.registerLazySingleton(() => StripePaymentService());
  locator.registerLazySingleton(() => GlobalGivingAPIService());
  locator.registerLazySingleton(() => WalletViewModel());
  locator.registerLazySingleton(() => SendMoneyViewModel());
  locator.registerLazySingleton(() => TransactionHistoryLayoutViewModel());
  locator.registerLazySingleton(() => NavigationBarViewModel());
  locator.registerLazySingleton(() => MoneyPoolService());
  locator.registerLazySingleton(() => FirebaseAuthenticationService());
  locator.registerSingleton(DummyPaymentService());
  locator.registerLazySingleton(() => QRCodeService());
  locator.registerLazySingleton(() => CausesDataService());
  locator.registerLazySingleton(() => UserDataService());
}
