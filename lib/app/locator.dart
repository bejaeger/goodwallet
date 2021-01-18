import 'package:get_it/get_it.dart';
import 'package:good_wallet/services/authentification/authentification_service.dart';
import 'package:good_wallet/services/finances/firestore_payment_data_service.dart';
import 'package:good_wallet/services/finances/stripe_payment_service.dart';
import 'package:good_wallet/services/userdata/firestore_user_service.dart';
import 'package:good_wallet/services/userdata/wallet_client_service.dart';
import 'package:good_wallet/viewmodels/navigation_bar_view_model.dart';
import 'package:stacked_services/stacked_services.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => FirestoreUserService());
  locator.registerLazySingleton(() => NavigationBarViewModel());
  locator.registerLazySingleton(() => UserWalletService());
  locator.registerLazySingleton(() => FirestorePaymentDataService());
  locator.registerLazySingleton(() => StripePaymentService());
}
