// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/globalgiving/global_giving_api_service.dart';
import '../services/payments/dummy_payment_service.dart';
import '../services/payments/firestore_payment_data_service.dart';
import '../services/payments/stripe_payment_service.dart';
import '../services/userdata/user_data_service.dart';
import '../ui/views/goodcauses/causes_viewmodel.dart';
import '../ui/views/layout/navigation_bar_viewmodel.dart';
import '../ui/views/profile/transaction_history_viewmodel.dart';
import '../ui/views/wallet/wallet_viewmodel.dart';

final locator = StackedLocator.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => FirestorePaymentDataService());
  locator.registerLazySingleton(() => StripePaymentService());
  locator.registerLazySingleton(() => GlobalGivingAPIService());
  locator.registerLazySingleton(() => WalletViewModel());
  locator.registerLazySingleton(() => CausesViewModel());
  locator.registerLazySingleton(() => TransactionHistoryViewModel());
  locator.registerLazySingleton(() => NavigationBarViewModel());
  locator.registerLazySingleton(() => FirebaseAuthenticationService());
  locator.registerLazySingleton(() => DummyPaymentService());
  locator.registerSingleton(UserDataService());
}
