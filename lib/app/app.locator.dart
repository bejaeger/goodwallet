// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

import '../apis/firestore_api.dart';
import '../apis/global_giving_api.dart';
import '../managers/transfers_manager.dart';
import '../services/money_pools/money_pools_service.dart';
import '../services/payments/dummy_payment_service.dart';
import '../services/payments/firestore_payment_data_service.dart';
import '../services/payments/stripe_payment_service.dart';
import '../services/projects/projects_service.dart';
import '../services/qrcode/qrcode_service.dart';
import '../services/user/user_service.dart';
import '../ui/views/layout/navigation_bar_viewmodel.dart';
import '../ui/views/money_pools/money_pools_viewmodel.dart';
import '../ui/views/wallet/wallet_viewmodel.dart';

final locator = StackedLocator.instance.locator;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => FirestorePaymentDataService());
  locator.registerLazySingleton(() => StripePaymentService());
  locator.registerLazySingleton(() => GlobalGivingApi());
  locator.registerLazySingleton(() => NavigationBarViewModel());
  locator.registerLazySingleton(() => MoneyPoolsService());
  locator.registerLazySingleton(() => FirebaseAuthenticationService());
  locator.registerLazySingleton(() => ProjectsService());
  locator.registerLazySingleton(() => QRCodeService());
  locator.registerLazySingleton(() => MoneyPoolsViewModel());
  locator.registerLazySingleton(() => WalletViewModel());
  locator.registerSingleton(FirestoreApi());
  locator.registerSingleton(DummyPaymentService());
  locator.registerSingleton(UserService());
  locator.registerSingleton(TransfersManager());
}
