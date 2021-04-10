import 'package:good_wallet/services/globalgiving/global_giving_api_service.dart';
import 'package:good_wallet/services/payments/dummy_payment_service.dart';
import 'package:good_wallet/services/payments/firestore_payment_data_service.dart';
import 'package:good_wallet/services/payments/stripe_payment_service.dart';
import 'package:good_wallet/services/qrcode/qr_code_service.dart';
import 'package:good_wallet/services/userdata/user_data_service.dart';
import 'package:good_wallet/style/page_transitions.dart';
import 'package:good_wallet/ui/views/causes/causes_view.dart';
import 'package:good_wallet/ui/views/causes/causes_viewmodel.dart';
import 'package:good_wallet/ui/views/causes/single_project_view_mobile.dart';
import 'package:good_wallet/ui/views/featured_applications/single_featured_app_view.dart';
import 'package:good_wallet/ui/views/home/home_view_mobile.dart';
import 'package:good_wallet/ui/views/home/welcome_view.dart';
import 'package:good_wallet/ui/views/layout/layout_template_view.dart';
import 'package:good_wallet/ui/views/layout/layout_template_view_mobile.dart';
import 'package:good_wallet/ui/views/layout/navigation_bar_viewmodel.dart';
import 'package:good_wallet/ui/views/login/create_account_view.dart';
import 'package:good_wallet/ui/views/login/login_view.dart';
import 'package:good_wallet/ui/views/money_pools/create_money_pool_view.dart';
import 'package:good_wallet/ui/views/money_pools/manage_money_pools_view.dart';
import 'package:good_wallet/ui/views/payments/payment_cancel_view.dart';
import 'package:good_wallet/ui/views/payments/payment_success_view.dart';
import 'package:good_wallet/ui/views/payments/send_money_view.dart';
import 'package:good_wallet/ui/views/payments/send_money_view_mobile.dart';
import 'package:good_wallet/ui/views/payments/send_money_viewmodel.dart';
import 'package:good_wallet/ui/views/profile/profile_view_mobile.dart';
import 'package:good_wallet/ui/views/qrcode/qrcode_view_mobile.dart';
import 'package:good_wallet/ui/views/raise_money/raise_money_view.dart';
import 'package:good_wallet/ui/views/transaction_history/transactions_history_layout_viewmodel.dart';
import 'package:good_wallet/ui/views/transaction_history/transactions_view.dart';
import 'package:good_wallet/ui/views/wallet/wallet_view.dart';
import 'package:good_wallet/ui/views/wallet/wallet_viewmodel.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  // TODO: Add back transitions
  routes: [
    MaterialRoute(page: WelcomeView),
    MaterialRoute(page: WalletView),
    MaterialRoute(page: SendMoneyView),
    MaterialRoute(page: DonationView),
    MaterialRoute(page: PaymentSuccessView),
    MaterialRoute(page: PaymentCancelView),
    MaterialRoute(page: LayoutTemplate),
    MaterialRoute(page: LoginView, initial: true),

    // Mobile routes
    MaterialRoute(page: LayoutTemplateViewMobile),
    MaterialRoute(page: HomeViewMobile),
    MaterialRoute(page: SingleProjectViewMobile),
    MaterialRoute(page: ProfileViewMobile),
    MaterialRoute(page: CreateAccountView),
    MaterialRoute(page: SingleFeaturedAppView),
    MaterialRoute(page: ManageMoneyPoolsView),
    MaterialRoute(page: SendMoneyViewMobile),
    MaterialRoute(page: TransactionsView),
    MaterialRoute(page: QRCodeViewMobile),
    MaterialRoute(page: CreateMoneyPoolView),
    MaterialRoute(page: RaiseMoneyView),
  ],
  dependencies: [
    // Registers all singletons
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: FirestorePaymentDataService),
    LazySingleton(classType: StripePaymentService),
    LazySingleton(classType: GlobalGivingAPIService),

    // viewmodels
    LazySingleton(classType: WalletViewModel),
    LazySingleton(classType: CausesViewModel),
    LazySingleton(classType: SendMoneyViewModel),
    LazySingleton(classType: TransactionHistoryLayoutViewModel),
    // TODO: Check whether this is deprecated
    LazySingleton(classType: NavigationBarViewModel),

    LazySingleton(
      classType: FirebaseAuthenticationService,
    ),
    LazySingleton(classType: DummyPaymentService),
    LazySingleton(classType: QRCodeService),

    Singleton(classType: UserDataService),

    // don't register the auth service lazily because we want it
    // to be initialized at the start of the app. This needs
    // to happen after all the services that are used inside
    // authentification service are registered.
  ],
)
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
