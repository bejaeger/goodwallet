import 'package:get_it/get_it.dart';
import 'package:good_wallet/services/authentification/authentification_service.dart';
import 'package:good_wallet/services/globalgiving/global_giving_api_service.dart';
import 'package:good_wallet/services/layout/layout_service.dart';
import 'package:good_wallet/services/payments/firestore_payment_data_service.dart';
import 'package:good_wallet/services/payments/stripe_payment_service.dart';
import 'package:good_wallet/services/userdata/user_data_service.dart';
import 'package:good_wallet/services/userdata/wallet_client_service.dart';
import 'package:good_wallet/ui/views/goodcauses/causes_viewmodel.dart';
import 'package:good_wallet/ui/views/layout/navigation_bar_viewmodel.dart';
import 'package:good_wallet/ui/views/wallet/wallet_viewmodel.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // Registers all singletons
  locator.registerLazySingleton(() => UserWalletService());
  locator.registerLazySingleton(() => UserDataService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => NavigationBarViewModel());
  locator.registerLazySingleton(() => FirestorePaymentDataService());
  locator.registerLazySingleton(() => StripePaymentService());
  locator.registerLazySingleton(() => WalletViewModel());
  locator.registerLazySingleton(() => LayoutService());
  locator.registerLazySingleton(() => GlobalGivingAPIService());

  locator.registerLazySingleton(() => CausesViewModel());
  locator.registerLazySingleton(() => FirebaseAuthenticationService(
      log: getLogger("Stacked' FirebaseAuthenticationService")));

  // don't register the auth service lazily because we want it
  // to be initialized at the start of the app. This needs
  // to happen after all the services that are used inside
  // authentification service are registered.
  locator.registerSingleton(AuthenticationService());
}
