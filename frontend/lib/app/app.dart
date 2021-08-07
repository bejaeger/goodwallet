import 'package:good_wallet/apis/firestore_api.dart';
import 'package:good_wallet/apis/global_giving_api.dart';
import 'package:good_wallet/services/payments/stripe_service.dart';
import 'package:good_wallet/services/transfers_history/transfers_history_service.dart';
import 'package:good_wallet/services/money_pools/money_pools_service.dart';
import 'package:good_wallet/services/payments/dummy_payment_service.dart';
import 'package:good_wallet/services/projects/projects_service.dart';
import 'package:good_wallet/services/qrcode/qrcode_service.dart';
import 'package:good_wallet/services/user/user_service.dart';
import 'package:good_wallet/ui/views/explore_view/explore_view.dart';
import 'package:good_wallet/ui/views/featured_applications/single_featured_app_view.dart';
import 'package:good_wallet/ui/views/friends/friends_view.dart';
import 'package:good_wallet/ui/views/home/home_view_mobile.dart';
import 'package:good_wallet/ui/views/home/welcome_view.dart';
import 'package:good_wallet/ui/views/in_app_notifications/in_app_notifications_view.dart';
import 'package:good_wallet/ui/views/layout/layout_template_view.dart';
import 'package:good_wallet/ui/views/layout/layout_template_view_mobile.dart';
import 'package:good_wallet/ui/views/layout/navigation_bar_viewmodel.dart';
import 'package:good_wallet/ui/views/login/create_account_view.dart';
import 'package:good_wallet/ui/views/login/login_view.dart';
import 'package:good_wallet/ui/views/money_pools/create_money_pool_form_view.dart';
import 'package:good_wallet/ui/views/money_pools/create_money_pool_intro_view.dart';
import 'package:good_wallet/ui/views/money_pools/disburse_money_pool_view.dart';
import 'package:good_wallet/ui/views/money_pools/money_pools_view.dart';
import 'package:good_wallet/ui/views/money_pools/money_pools_viewmodel.dart';
import 'package:good_wallet/ui/views/money_pools/single_money_pool_view.dart';
import 'package:good_wallet/ui/views/payments/payment_view_webhook.dart';
import 'package:good_wallet/ui/views/payments/payments_view.dart';
import 'package:good_wallet/ui/views/profile/account_view.dart';
import 'package:good_wallet/ui/views/profile/profile_view_mobile.dart';
import 'package:good_wallet/ui/views/profile/public_profile/public_profile_view_mobile.dart';
import 'package:good_wallet/ui/views/projects/favorite_projects_view.dart';
import 'package:good_wallet/ui/views/projects/projects_for_area_view.dart';
import 'package:good_wallet/ui/views/projects/projects_search_view.dart';
import 'package:good_wallet/ui/views/projects/projects_view.dart';
import 'package:good_wallet/ui/views/projects/single_project_view_mobile.dart';
import 'package:good_wallet/ui/views/qrcode/qrcode_view_mobile.dart';
import 'package:good_wallet/ui/views/search_view/search_view.dart';
import 'package:good_wallet/ui/views/settings/settings_view.dart';
import 'package:good_wallet/ui/views/startup_logic/startup_logic_view.dart';
import 'package:good_wallet/ui/views/transaction_history/transfers_history_view.dart';
import 'package:good_wallet/ui/views/transfer_funds/transfer_funds_amount_view.dart';
import 'package:good_wallet/ui/views/wallet/wallet_view.dart';
import 'package:good_wallet/ui/views/wallet/wallet_viewmodel.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: WelcomeView),
    MaterialRoute(page: WalletView),
    MaterialRoute(page: LayoutTemplate),
    MaterialRoute(page: LoginView),

    // Mobile routes
    MaterialRoute(page: SingleMoneyPoolView),
    MaterialRoute(page: CreateMoneyPoolIntroView),
    MaterialRoute(page: CreateMoneyPoolFormView),
    MaterialRoute(page: LayoutTemplateViewMobile),
    MaterialRoute(page: HomeViewMobile),
    MaterialRoute(page: ProfileViewMobile),
    MaterialRoute(page: CreateAccountView),
    MaterialRoute(page: PaymentView),
    MaterialRoute(page: PaymentViewWebhook),
    MaterialRoute(page: SingleFeaturedAppView),
    MaterialRoute(page: MoneyPoolsView),
    MaterialRoute(page: QRCodeViewMobile),
    MaterialRoute(page: StartUpLogicView, initial: true),
    MaterialRoute(page: ExploreView),
    MaterialRoute(page: SearchView),

    MaterialRoute(page: TransferFundsAmountView),
    MaterialRoute(page: DisburseMoneyPoolView),
    MaterialRoute(page: TransfersHistoryView),
    MaterialRoute(page: ProjectsView),
    MaterialRoute(page: FavoriteProjectsView),
    MaterialRoute(page: ProjectsForAreaView),
    MaterialRoute(page: SingleProjectViewMobile),
    MaterialRoute(page: InAppNotificationsView),
    MaterialRoute(page: SettingsView),
    MaterialRoute(page: PublicProfileViewMobile),
    MaterialRoute(page: FriendsView),
    MaterialRoute(page: AccountView),
    MaterialRoute(page: ProjectsSearchView),
  ],
  dependencies: [
    // Services
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: GlobalGivingApi),
    LazySingleton(classType: StripeService),

    // TODO: Check whether this is deprecated
    LazySingleton(classType: NavigationBarViewModel),
    LazySingleton(classType: MoneyPoolsService),
    LazySingleton(classType: FirebaseAuthenticationService),
    LazySingleton(classType: ProjectsService),
    LazySingleton(classType: QRCodeService),

    // View Models
    LazySingleton(classType: MoneyPoolsViewModel),
    LazySingleton(classType: WalletViewModel),

    // We don't really need local storage atm! (will need this for local search history for example)
    // Presolve(
    //   classType: LocalStorageService,
    //   presolveUsing: LocalStorageService.getInstance,
    // ),

    // The order is important in the following
    Singleton(classType: FirestoreApi),
    Singleton(classType: DummyPaymentService),
    Singleton(classType: UserService),
    Singleton(classType: TransfersHistoryService),
  ],
)
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
