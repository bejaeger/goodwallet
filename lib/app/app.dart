import 'package:good_wallet/services/authentification/authentification_service.dart';
import 'package:good_wallet/services/globalgiving/global_giving_api_service.dart';
import 'package:good_wallet/services/layout/layout_service.dart';
import 'package:good_wallet/services/payments/firestore_payment_data_service.dart';
import 'package:good_wallet/services/payments/stripe_payment_service.dart';
import 'package:good_wallet/services/userdata/user_data_service.dart';
import 'package:good_wallet/services/userdata/wallet_client_service.dart';
import 'package:good_wallet/style/page_transitions.dart';
import 'package:good_wallet/ui/views/goodcauses/causes_view.dart';
import 'package:good_wallet/ui/views/goodcauses/causes_viewmodel.dart';
import 'package:good_wallet/ui/views/goodcauses/single_project_view_mobile.dart';
import 'package:good_wallet/ui/views/home/home_view_mobile.dart';
import 'package:good_wallet/ui/views/home/welcome_view.dart';
import 'package:good_wallet/ui/views/layout/layout_template_view.dart';
import 'package:good_wallet/ui/views/layout/layout_template_view_mobile.dart';
import 'package:good_wallet/ui/views/layout/navigation_bar_viewmodel.dart';
import 'package:good_wallet/ui/views/login/create_account_view.dart';
import 'package:good_wallet/ui/views/login/login_view.dart';
import 'package:good_wallet/ui/views/payments/payment_cancel_view.dart';
import 'package:good_wallet/ui/views/payments/payment_success_view.dart';
import 'package:good_wallet/ui/views/payments/send_money_view.dart';
import 'package:good_wallet/ui/views/profile/profile_view.dart';
import 'package:good_wallet/ui/views/wallet/wallet_view.dart';
import 'package:good_wallet/ui/views/wallet/wallet_viewmodel.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  // TODO: Add back transitions
  routes: [
    CustomRoute(page: WelcomeView),
    CustomRoute(page: WalletView),
    CustomRoute(page: SendMoneyView),
    CustomRoute(page: DonationView),
    CustomRoute(page: PaymentSuccessView),
    CustomRoute(page: PaymentCancelView),
    CustomRoute(page: LayoutTemplate),
    CustomRoute(page: LoginView, initial: true),

    // Mobile routes
    CustomRoute(page: LayoutTemplateViewMobile),
    CustomRoute(page: HomeViewMobile),
    CustomRoute(page: SingleProjectViewMobile),
    CustomRoute(page: ProfileView),
    CustomRoute(page: CreateAccountView),
  ],
  dependencies: [
    // Registers all singletons
    LazySingleton(classType: UserWalletService),
    LazySingleton(classType: UserDataService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: NavigationBarViewModel),
    LazySingleton(classType: FirestorePaymentDataService),
    LazySingleton(classType: StripePaymentService),
    LazySingleton(classType: WalletViewModel),
    LazySingleton(classType: LayoutService),
    LazySingleton(classType: GlobalGivingAPIService),
    LazySingleton(classType: CausesViewModel),
    LazySingleton(
      classType: FirebaseAuthenticationService,
    ),

    // don't register the auth service lazily because we want it
    // to be initialized at the start of the app. This needs
    // to happen after all the services that are used inside
    // authentification service are registered.
    Singleton(classType: AuthenticationService),
  ],
)
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}