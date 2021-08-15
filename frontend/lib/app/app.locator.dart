// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

import '../apis/firestore_api.dart';
import '../apis/global_giving_api.dart';
import '../flavor_config.dart';
import '../services/money_pools/money_pools_service.dart';
import '../services/payments/dummy_payment_service.dart';
import '../services/payments/stripe_service.dart';
import '../services/projects/projects_service.dart';
import '../services/qrcode/qrcode_service.dart';
import '../services/transfers_history/transfers_history_service.dart';
import '../services/user/user_service.dart';
import '../ui/views/layout/navigation_bar_viewmodel.dart';
import '../ui/views/money_pools/money_pools_viewmodel.dart';
import '../ui/views/wallet/wallet_viewmodel.dart';

final locator = StackedLocator.instance;

void setupLocator({String? environment, EnvironmentFilter? environmentFilter}) {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => GlobalGivingApi());
  locator.registerLazySingleton(() => StripeService());
  locator.registerLazySingleton(() => NavigationBarViewModel());
  locator.registerLazySingleton(() => MoneyPoolsService());
  locator.registerLazySingleton(() => FirebaseAuthenticationService());
  locator.registerLazySingleton(() => ProjectsService());
  locator.registerLazySingleton(() => QRCodeService());
  locator.registerLazySingleton(() => MoneyPoolsViewModel());
  locator.registerLazySingleton(() => WalletViewModel());
  locator.registerLazySingleton(() => FlavorConfigProvider());
  locator.registerSingleton(FirestoreApi());
  locator.registerSingleton(DummyPaymentService());
  locator.registerSingleton(UserService());
  locator.registerSingleton(TransfersHistoryService());
}
