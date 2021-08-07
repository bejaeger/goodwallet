// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../datamodels/money_pools/base/money_pool.dart';
import '../datamodels/transfers/bookkeeping/recipient_info.dart';
import '../datamodels/transfers/bookkeeping/sender_info.dart';
import '../datamodels/user/user.dart';
import '../enums/featured_app_type.dart';
import '../enums/search_type.dart';
import '../enums/transfer_type.dart';
import '../ui/views/explore_view/explore_view.dart';
import '../ui/views/featured_applications/single_featured_app_view.dart';
import '../ui/views/friends/friends_view.dart';
import '../ui/views/home/home_view_mobile.dart';
import '../ui/views/home/welcome_view.dart';
import '../ui/views/in_app_notifications/in_app_notifications_view.dart';
import '../ui/views/layout/layout_template_view.dart';
import '../ui/views/layout/layout_template_view_mobile.dart';
import '../ui/views/login/create_account_view.dart';
import '../ui/views/login/login_view.dart';
import '../ui/views/money_pools/create_money_pool_form_view.dart';
import '../ui/views/money_pools/create_money_pool_intro_view.dart';
import '../ui/views/money_pools/disburse_money_pool_view.dart';
import '../ui/views/money_pools/money_pools_view.dart';
import '../ui/views/money_pools/single_money_pool_view.dart';
import '../ui/views/payments/payment_view_webhook.dart';
import '../ui/views/payments/payments_view.dart';
import '../ui/views/profile/account_view.dart';
import '../ui/views/profile/profile_view_mobile.dart';
import '../ui/views/profile/public_profile/public_profile_view_mobile.dart';
import '../ui/views/projects/favorite_projects_view.dart';
import '../ui/views/projects/projects_for_area_view.dart';
import '../ui/views/projects/projects_search_view.dart';
import '../ui/views/projects/projects_view.dart';
import '../ui/views/projects/single_project_view_mobile.dart';
import '../ui/views/qrcode/qrcode_view_mobile.dart';
import '../ui/views/search_view/search_view.dart';
import '../ui/views/settings/settings_view.dart';
import '../ui/views/startup_logic/startup_logic_view.dart';
import '../ui/views/transaction_history/transfers_history_view.dart';
import '../ui/views/transfer_funds/transfer_funds_amount_view.dart';
import '../ui/views/wallet/wallet_view.dart';

class Routes {
  static const String welcomeView = '/welcome-view';
  static const String walletView = '/wallet-view';
  static const String layoutTemplate = '/layout-template';
  static const String loginView = '/login-view';
  static const String singleMoneyPoolView = '/single-money-pool-view';
  static const String createMoneyPoolIntroView =
      '/create-money-pool-intro-view';
  static const String createMoneyPoolFormView = '/create-money-pool-form-view';
  static const String layoutTemplateViewMobile = '/layout-template-view-mobile';
  static const String homeViewMobile = '/home-view-mobile';
  static const String profileViewMobile = '/profile-view-mobile';
  static const String createAccountView = '/create-account-view';
  static const String paymentView = '/payment-view';
  static const String paymentViewWebhook = '/payment-view-webhook';
  static const String singleFeaturedAppView = '/single-featured-app-view';
  static const String moneyPoolsView = '/money-pools-view';
  static const String qRCodeViewMobile = '/q-rcode-view-mobile';
  static const String startUpLogicView = '/';
  static const String exploreView = '/explore-view';
  static const String searchView = '/search-view';
  static const String transferFundsAmountView = '/transfer-funds-amount-view';
  static const String disburseMoneyPoolView = '/disburse-money-pool-view';
  static const String transfersHistoryView = '/transfers-history-view';
  static const String projectsView = '/projects-view';
  static const String favoriteProjectsView = '/favorite-projects-view';
  static const String projectsForAreaView = '/projects-for-area-view';
  static const String singleProjectViewMobile = '/single-project-view-mobile';
  static const String inAppNotificationsView = '/in-app-notifications-view';
  static const String settingsView = '/settings-view';
  static const String publicProfileViewMobile = '/public-profile-view-mobile';
  static const String friendsView = '/friends-view';
  static const String accountView = '/account-view';
  static const String projectsSearchView = '/projects-search-view';
  static const all = <String>{
    welcomeView,
    walletView,
    layoutTemplate,
    loginView,
    singleMoneyPoolView,
    createMoneyPoolIntroView,
    createMoneyPoolFormView,
    layoutTemplateViewMobile,
    homeViewMobile,
    profileViewMobile,
    createAccountView,
    paymentView,
    paymentViewWebhook,
    singleFeaturedAppView,
    moneyPoolsView,
    qRCodeViewMobile,
    startUpLogicView,
    exploreView,
    searchView,
    transferFundsAmountView,
    disburseMoneyPoolView,
    transfersHistoryView,
    projectsView,
    favoriteProjectsView,
    projectsForAreaView,
    singleProjectViewMobile,
    inAppNotificationsView,
    settingsView,
    publicProfileViewMobile,
    friendsView,
    accountView,
    projectsSearchView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.welcomeView, page: WelcomeView),
    RouteDef(Routes.walletView, page: WalletView),
    RouteDef(Routes.layoutTemplate, page: LayoutTemplate),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.singleMoneyPoolView, page: SingleMoneyPoolView),
    RouteDef(Routes.createMoneyPoolIntroView, page: CreateMoneyPoolIntroView),
    RouteDef(Routes.createMoneyPoolFormView, page: CreateMoneyPoolFormView),
    RouteDef(Routes.layoutTemplateViewMobile, page: LayoutTemplateViewMobile),
    RouteDef(Routes.homeViewMobile, page: HomeViewMobile),
    RouteDef(Routes.profileViewMobile, page: ProfileViewMobile),
    RouteDef(Routes.createAccountView, page: CreateAccountView),
    RouteDef(Routes.paymentView, page: PaymentView),
    RouteDef(Routes.paymentViewWebhook, page: PaymentViewWebhook),
    RouteDef(Routes.singleFeaturedAppView, page: SingleFeaturedAppView),
    RouteDef(Routes.moneyPoolsView, page: MoneyPoolsView),
    RouteDef(Routes.qRCodeViewMobile, page: QRCodeViewMobile),
    RouteDef(Routes.startUpLogicView, page: StartUpLogicView),
    RouteDef(Routes.exploreView, page: ExploreView),
    RouteDef(Routes.searchView, page: SearchView),
    RouteDef(Routes.transferFundsAmountView, page: TransferFundsAmountView),
    RouteDef(Routes.disburseMoneyPoolView, page: DisburseMoneyPoolView),
    RouteDef(Routes.transfersHistoryView, page: TransfersHistoryView),
    RouteDef(Routes.projectsView, page: ProjectsView),
    RouteDef(Routes.favoriteProjectsView, page: FavoriteProjectsView),
    RouteDef(Routes.projectsForAreaView, page: ProjectsForAreaView),
    RouteDef(Routes.singleProjectViewMobile, page: SingleProjectViewMobile),
    RouteDef(Routes.inAppNotificationsView, page: InAppNotificationsView),
    RouteDef(Routes.settingsView, page: SettingsView),
    RouteDef(Routes.publicProfileViewMobile, page: PublicProfileViewMobile),
    RouteDef(Routes.friendsView, page: FriendsView),
    RouteDef(Routes.accountView, page: AccountView),
    RouteDef(Routes.projectsSearchView, page: ProjectsSearchView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    WelcomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const WelcomeView(),
        settings: data,
      );
    },
    WalletView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => WalletView(),
        settings: data,
      );
    },
    LayoutTemplate: (data) {
      var args = data.getArgs<LayoutTemplateArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => LayoutTemplate(
          key: args.key,
          childView: args.childView,
        ),
        settings: data,
      );
    },
    LoginView: (data) {
      var args = data.getArgs<LoginViewArguments>(
        orElse: () => LoginViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginView(key: args.key),
        settings: data,
      );
    },
    SingleMoneyPoolView: (data) {
      var args = data.getArgs<SingleMoneyPoolViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => SingleMoneyPoolView(
          key: args.key,
          moneyPool: args.moneyPool,
        ),
        settings: data,
      );
    },
    CreateMoneyPoolIntroView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => CreateMoneyPoolIntroView(),
        settings: data,
      );
    },
    CreateMoneyPoolFormView: (data) {
      var args = data.getArgs<CreateMoneyPoolFormViewArguments>(
        orElse: () => CreateMoneyPoolFormViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => CreateMoneyPoolFormView(key: args.key),
        settings: data,
      );
    },
    LayoutTemplateViewMobile: (data) {
      var args = data.getArgs<LayoutTemplateViewMobileArguments>(
        orElse: () => LayoutTemplateViewMobileArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => LayoutTemplateViewMobile(
          key: args.key,
          initialBottomNavBarIndex: args.initialBottomNavBarIndex,
          initialTabBarIndex: args.initialTabBarIndex,
          showDialog: args.showDialog,
        ),
        settings: data,
      );
    },
    HomeViewMobile: (data) {
      var args = data.getArgs<HomeViewMobileArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeViewMobile(
          key: args.key,
          showDialog: args.showDialog,
        ),
        settings: data,
      );
    },
    ProfileViewMobile: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ProfileViewMobile(),
        settings: data,
      );
    },
    CreateAccountView: (data) {
      var args = data.getArgs<CreateAccountViewArguments>(
        orElse: () => CreateAccountViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => CreateAccountView(key: args.key),
        settings: data,
      );
    },
    PaymentView: (data) {
      var args = data.getArgs<PaymentViewArguments>(
        orElse: () => PaymentViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => PaymentView(key: args.key),
        settings: data,
      );
    },
    PaymentViewWebhook: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => PaymentViewWebhook(),
        settings: data,
      );
    },
    SingleFeaturedAppView: (data) {
      var args = data.getArgs<SingleFeaturedAppViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => SingleFeaturedAppView(
          key: args.key,
          type: args.type,
        ),
        settings: data,
      );
    },
    MoneyPoolsView: (data) {
      var args = data.getArgs<MoneyPoolsViewArguments>(
        orElse: () => MoneyPoolsViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => MoneyPoolsView(
          key: args.key,
          forceReload: args.forceReload,
        ),
        settings: data,
      );
    },
    QRCodeViewMobile: (data) {
      var args = data.getArgs<QRCodeViewMobileArguments>(
        orElse: () => QRCodeViewMobileArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => QRCodeViewMobile(
          key: args.key,
          initialIndex: args.initialIndex,
          searchType: args.searchType,
          showSwitchToSearch: args.showSwitchToSearch,
        ),
        settings: data,
      );
    },
    StartUpLogicView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const StartUpLogicView(),
        settings: data,
      );
    },
    ExploreView: (data) {
      var args = data.getArgs<ExploreViewArguments>(
        orElse: () => ExploreViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => ExploreView(
          key: args.key,
          searchType: args.searchType,
          autofocus: args.autofocus,
        ),
        settings: data,
      );
    },
    SearchView: (data) {
      var args = data.getArgs<SearchViewArguments>(
        orElse: () => SearchViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => SearchView(
          key: args.key,
          searchType: args.searchType,
          autofocus: args.autofocus,
        ),
        settings: data,
      );
    },
    TransferFundsAmountView: (data) {
      var args = data.getArgs<TransferFundsAmountViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => TransferFundsAmountView(
          key: args.key,
          type: args.type,
          senderInfo: args.senderInfo,
          recipientInfo: args.recipientInfo,
          onContinuePressed: args.onContinuePressed,
        ),
        settings: data,
      );
    },
    DisburseMoneyPoolView: (data) {
      var args = data.getArgs<DisburseMoneyPoolViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => DisburseMoneyPoolView(
          key: args.key,
          moneyPool: args.moneyPool,
        ),
        settings: data,
      );
    },
    TransfersHistoryView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const TransfersHistoryView(),
        settings: data,
      );
    },
    ProjectsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ProjectsView(),
        settings: data,
      );
    },
    FavoriteProjectsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const FavoriteProjectsView(),
        settings: data,
      );
    },
    ProjectsForAreaView: (data) {
      var args = data.getArgs<ProjectsForAreaViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => ProjectsForAreaView(
          key: args.key,
          area: args.area,
        ),
        settings: data,
      );
    },
    SingleProjectViewMobile: (data) {
      var args = data.getArgs<SingleProjectViewMobileArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => SingleProjectViewMobile(
          key: args.key,
          projectId: args.projectId,
        ),
        settings: data,
      );
    },
    InAppNotificationsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const InAppNotificationsView(),
        settings: data,
      );
    },
    SettingsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const SettingsView(),
        settings: data,
      );
    },
    PublicProfileViewMobile: (data) {
      var args = data.getArgs<PublicProfileViewMobileArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => PublicProfileViewMobile(
          key: args.key,
          uid: args.uid,
        ),
        settings: data,
      );
    },
    FriendsView: (data) {
      var args = data.getArgs<FriendsViewArguments>(
        orElse: () => FriendsViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => FriendsView(
          key: args.key,
          friends: args.friends,
        ),
        settings: data,
      );
    },
    AccountView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const AccountView(),
        settings: data,
      );
    },
    ProjectsSearchView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ProjectsSearchView(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// LayoutTemplate arguments holder class
class LayoutTemplateArguments {
  final Key? key;
  final Widget? childView;
  LayoutTemplateArguments({this.key, required this.childView});
}

/// LoginView arguments holder class
class LoginViewArguments {
  final Key? key;
  LoginViewArguments({this.key});
}

/// SingleMoneyPoolView arguments holder class
class SingleMoneyPoolViewArguments {
  final Key? key;
  final MoneyPool moneyPool;
  SingleMoneyPoolViewArguments({this.key, required this.moneyPool});
}

/// CreateMoneyPoolFormView arguments holder class
class CreateMoneyPoolFormViewArguments {
  final Key? key;
  CreateMoneyPoolFormViewArguments({this.key});
}

/// LayoutTemplateViewMobile arguments holder class
class LayoutTemplateViewMobileArguments {
  final Key? key;
  final int? initialBottomNavBarIndex;
  final int? initialTabBarIndex;
  final bool showDialog;
  LayoutTemplateViewMobileArguments(
      {this.key,
      this.initialBottomNavBarIndex,
      this.initialTabBarIndex = 0,
      this.showDialog = false});
}

/// HomeViewMobile arguments holder class
class HomeViewMobileArguments {
  final Key? key;
  final bool showDialog;
  HomeViewMobileArguments({this.key, required this.showDialog});
}

/// CreateAccountView arguments holder class
class CreateAccountViewArguments {
  final Key? key;
  CreateAccountViewArguments({this.key});
}

/// PaymentView arguments holder class
class PaymentViewArguments {
  final Key? key;
  PaymentViewArguments({this.key});
}

/// SingleFeaturedAppView arguments holder class
class SingleFeaturedAppViewArguments {
  final Key? key;
  final FeaturedAppType type;
  SingleFeaturedAppViewArguments({this.key, required this.type});
}

/// MoneyPoolsView arguments holder class
class MoneyPoolsViewArguments {
  final Key? key;
  final bool forceReload;
  MoneyPoolsViewArguments({this.key, this.forceReload = false});
}

/// QRCodeViewMobile arguments holder class
class QRCodeViewMobileArguments {
  final Key? key;
  final int initialIndex;
  final SearchType? searchType;
  final bool showSwitchToSearch;
  QRCodeViewMobileArguments(
      {this.key,
      this.initialIndex = 0,
      this.searchType,
      this.showSwitchToSearch = true});
}

/// ExploreView arguments holder class
class ExploreViewArguments {
  final Key? key;
  final SearchType searchType;
  final bool autofocus;
  ExploreViewArguments(
      {this.key, this.searchType = SearchType.Explore, this.autofocus = false});
}

/// SearchView arguments holder class
class SearchViewArguments {
  final Key? key;
  final SearchType searchType;
  final bool autofocus;
  SearchViewArguments(
      {this.key, this.searchType = SearchType.Explore, this.autofocus = false});
}

/// TransferFundsAmountView arguments holder class
class TransferFundsAmountViewArguments {
  final Key? key;
  final TransferType type;
  final SenderInfo senderInfo;
  final RecipientInfo? recipientInfo;
  final void Function()? onContinuePressed;
  TransferFundsAmountViewArguments(
      {this.key,
      required this.type,
      required this.senderInfo,
      this.recipientInfo,
      this.onContinuePressed});
}

/// DisburseMoneyPoolView arguments holder class
class DisburseMoneyPoolViewArguments {
  final Key? key;
  final MoneyPool moneyPool;
  DisburseMoneyPoolViewArguments({this.key, required this.moneyPool});
}

/// ProjectsForAreaView arguments holder class
class ProjectsForAreaViewArguments {
  final Key? key;
  final String area;
  ProjectsForAreaViewArguments({this.key, required this.area});
}

/// SingleProjectViewMobile arguments holder class
class SingleProjectViewMobileArguments {
  final Key? key;
  final String projectId;
  SingleProjectViewMobileArguments({this.key, required this.projectId});
}

/// PublicProfileViewMobile arguments holder class
class PublicProfileViewMobileArguments {
  final Key? key;
  final String uid;
  PublicProfileViewMobileArguments({this.key, required this.uid});
}

/// FriendsView arguments holder class
class FriendsViewArguments {
  final Key? key;
  final List<User>? friends;
  FriendsViewArguments({this.key, this.friends});
}
