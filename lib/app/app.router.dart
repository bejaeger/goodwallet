// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../datamodels/causes/good_wallet_project_model.dart';
import '../datamodels/money_pools/money_pool_model.dart';
import '../datamodels/user/public_user_info.dart';
import '../enums/featured_app_type.dart';
import '../enums/fund_transfer_type.dart';
import '../enums/search_type.dart';
import '../enums/transaction_type.dart';
import '../ui/views/causes/causes_filter_view_mobile.dart';
import '../ui/views/causes/causes_view.dart';
import '../ui/views/causes/causes_view_mobile.dart';
import '../ui/views/causes/single_project_view_mobile.dart';
import '../ui/views/featured_applications/single_featured_app_view.dart';
import '../ui/views/home/home_view_mobile.dart';
import '../ui/views/home/welcome_view.dart';
import '../ui/views/layout/layout_template_view.dart';
import '../ui/views/layout/layout_template_view_mobile.dart';
import '../ui/views/login/create_account_view.dart';
import '../ui/views/login/login_view.dart';
import '../ui/views/money_pools/create_money_pool_form_view.dart';
import '../ui/views/money_pools/create_money_pool_intro_view.dart';
import '../ui/views/money_pools/money_pools_view.dart';
import '../ui/views/money_pools/single_money_pool_view.dart';
import '../ui/views/payments/payment_cancel_view.dart';
import '../ui/views/payments/payment_success_view.dart';
import '../ui/views/payments/send_money_view.dart';
import '../ui/views/payments/send_money_view_mobile.dart';
import '../ui/views/profile/profile_view_mobile.dart';
import '../ui/views/qrcode/qrcode_view_mobile.dart';
import '../ui/views/raise_money/raise_money_view.dart';
import '../ui/views/search_view/search_view.dart';
import '../ui/views/startup_logic/startup_logic_view.dart';
import '../ui/views/transaction_history/transactions_view.dart';
import '../ui/views/transfer_funds/transfer_funds_amount_view.dart';
import '../ui/views/wallet/wallet_view.dart';

class Routes {
  static const String welcomeView = '/welcome-view';
  static const String walletView = '/wallet-view';
  static const String sendMoneyView = '/send-money-view';
  static const String donationView = '/donation-view';
  static const String paymentSuccessView = '/payment-success-view';
  static const String paymentCancelView = '/payment-cancel-view';
  static const String layoutTemplate = '/layout-template';
  static const String loginView = '/login-view';
  static const String singleMoneyPoolView = '/single-money-pool-view';
  static const String createMoneyPoolIntroView =
      '/create-money-pool-intro-view';
  static const String createMoneyPoolFormView = '/create-money-pool-form-view';
  static const String layoutTemplateViewMobile = '/layout-template-view-mobile';
  static const String homeViewMobile = '/home-view-mobile';
  static const String singleProjectViewMobile = '/single-project-view-mobile';
  static const String profileViewMobile = '/profile-view-mobile';
  static const String createAccountView = '/create-account-view';
  static const String singleFeaturedAppView = '/single-featured-app-view';
  static const String moneyPoolsView = '/money-pools-view';
  static const String sendMoneyViewMobile = '/send-money-view-mobile';
  static const String transactionsView = '/transactions-view';
  static const String qRCodeViewMobile = '/q-rcode-view-mobile';
  static const String raiseMoneyView = '/raise-money-view';
<<<<<<< HEAD
  static const String causesFilterViewMobile = '/causes-filter-view-mobile';
  static const String causesViewMobile = '/causes-view-mobile';
  static const String startUpLogicView = '/';
||||||| c7e05cc
  static const String startUpLogicView = '/';
=======
  static const String startUpLogicView = '/start-up-logic-view';
  static const String searchView = '/search-view';
  static const String transferFundsAmountView = '/transfer-funds-amount-view';
>>>>>>> origin/master
  static const all = <String>{
    welcomeView,
    walletView,
    sendMoneyView,
    donationView,
    paymentSuccessView,
    paymentCancelView,
    layoutTemplate,
    loginView,
    singleMoneyPoolView,
    createMoneyPoolIntroView,
    createMoneyPoolFormView,
    layoutTemplateViewMobile,
    homeViewMobile,
    singleProjectViewMobile,
    profileViewMobile,
    createAccountView,
    singleFeaturedAppView,
    moneyPoolsView,
    sendMoneyViewMobile,
    transactionsView,
    qRCodeViewMobile,
    raiseMoneyView,
    causesFilterViewMobile,
    causesViewMobile,
    startUpLogicView,
    searchView,
    transferFundsAmountView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.welcomeView, page: WelcomeView),
    RouteDef(Routes.walletView, page: WalletView),
    RouteDef(Routes.sendMoneyView, page: SendMoneyView),
    RouteDef(Routes.donationView, page: DonationView),
    RouteDef(Routes.paymentSuccessView, page: PaymentSuccessView),
    RouteDef(Routes.paymentCancelView, page: PaymentCancelView),
    RouteDef(Routes.layoutTemplate, page: LayoutTemplate),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.singleMoneyPoolView, page: SingleMoneyPoolView),
    RouteDef(Routes.createMoneyPoolIntroView, page: CreateMoneyPoolIntroView),
    RouteDef(Routes.createMoneyPoolFormView, page: CreateMoneyPoolFormView),
    RouteDef(Routes.layoutTemplateViewMobile, page: LayoutTemplateViewMobile),
    RouteDef(Routes.homeViewMobile, page: HomeViewMobile),
    RouteDef(Routes.singleProjectViewMobile, page: SingleProjectViewMobile),
    RouteDef(Routes.profileViewMobile, page: ProfileViewMobile),
    RouteDef(Routes.createAccountView, page: CreateAccountView),
    RouteDef(Routes.singleFeaturedAppView, page: SingleFeaturedAppView),
    RouteDef(Routes.moneyPoolsView, page: MoneyPoolsView),
    RouteDef(Routes.sendMoneyViewMobile, page: SendMoneyViewMobile),
    RouteDef(Routes.transactionsView, page: TransactionsView),
    RouteDef(Routes.qRCodeViewMobile, page: QRCodeViewMobile),
    RouteDef(Routes.raiseMoneyView, page: RaiseMoneyView),
    RouteDef(Routes.causesFilterViewMobile, page: CausesFilterViewMobile),
    RouteDef(Routes.causesViewMobile, page: CausesViewMobile),
    RouteDef(Routes.startUpLogicView, page: StartUpLogicView),
    RouteDef(Routes.searchView, page: SearchView),
    RouteDef(Routes.transferFundsAmountView, page: TransferFundsAmountView),
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
    SendMoneyView: (data) {
      var args = data.getArgs<SendMoneyViewArguments>(
        orElse: () => SendMoneyViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => SendMoneyView(
          key: args.key,
          userInfoMap: args.userInfoMap,
          openSearchBarOnBuild: args.openSearchBarOnBuild,
        ),
        settings: data,
      );
    },
    DonationView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => DonationView(),
        settings: data,
      );
    },
    PaymentSuccessView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => PaymentSuccessView(),
        settings: data,
      );
    },
    PaymentCancelView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => PaymentCancelView(),
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
        ),
        settings: data,
      );
    },
    HomeViewMobile: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeViewMobile(),
        settings: data,
      );
    },
    SingleProjectViewMobile: (data) {
      var args = data.getArgs<SingleProjectViewMobileArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => SingleProjectViewMobile(
          key: args.key,
          project: args.project,
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
    SendMoneyViewMobile: (data) {
      var args = data.getArgs<SendMoneyViewMobileArguments>(
        orElse: () => SendMoneyViewMobileArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => SendMoneyViewMobile(
          key: args.key,
          userInfo: args.userInfo,
          openSearchBarOnBuild: args.openSearchBarOnBuild,
        ),
        settings: data,
      );
    },
    TransactionsView: (data) {
      var args = data.getArgs<TransactionsViewArguments>(
        orElse: () => TransactionsViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => TransactionsView(
          key: args.key,
          historyType: args.historyType,
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
        ),
        settings: data,
      );
    },
    RaiseMoneyView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const RaiseMoneyView(),
        settings: data,
      );
    },
    CausesFilterViewMobile: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const CausesFilterViewMobile(),
        settings: data,
      );
    },
    CausesViewMobile: (data) {
      var args = data.getArgs<CausesViewMobileArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => CausesViewMobile(
          key: args.key,
          Theme: args.Theme,
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
    SearchView: (data) {
      var args = data.getArgs<SearchViewArguments>(
        orElse: () => SearchViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => SearchView(
          key: args.key,
          searchType: args.searchType,
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
          receiverInfo: args.receiverInfo,
          onContinuePressed: args.onContinuePressed,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// SendMoneyView arguments holder class
class SendMoneyViewArguments {
  final Key? key;
  final PublicUserInfo? userInfoMap;
  final dynamic openSearchBarOnBuild;
  SendMoneyViewArguments(
      {this.key, this.userInfoMap, this.openSearchBarOnBuild = false});
}

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
  final MoneyPoolModel moneyPool;
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
  LayoutTemplateViewMobileArguments(
      {this.key, this.initialBottomNavBarIndex, this.initialTabBarIndex = 0});
}

/// SingleProjectViewMobile arguments holder class
class SingleProjectViewMobileArguments {
  final Key? key;
  final GoodWalletProjectModel? project;
  SingleProjectViewMobileArguments({this.key, required this.project});
}

/// CreateAccountView arguments holder class
class CreateAccountViewArguments {
  final Key? key;
  CreateAccountViewArguments({this.key});
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

/// SendMoneyViewMobile arguments holder class
class SendMoneyViewMobileArguments {
  final Key? key;
  final PublicUserInfo? userInfo;
  final dynamic openSearchBarOnBuild;
  SendMoneyViewMobileArguments(
      {this.key, this.userInfo, this.openSearchBarOnBuild = false});
}

/// TransactionsView arguments holder class
class TransactionsViewArguments {
  final Key? key;
  final TransactionType historyType;
  TransactionsViewArguments(
      {this.key, this.historyType = TransactionType.InOrOut});
}

/// QRCodeViewMobile arguments holder class
class QRCodeViewMobileArguments {
  final Key? key;
  final int initialIndex;
  QRCodeViewMobileArguments({this.key, this.initialIndex = 0});
}
<<<<<<< HEAD

/// CausesViewMobile arguments holder class
class CausesViewMobileArguments {
  final Key? key;
  final String? Theme;
  CausesViewMobileArguments({this.key, required this.Theme});
}
||||||| c7e05cc
=======

/// SearchView arguments holder class
class SearchViewArguments {
  final Key? key;
  final SearchType searchType;
  SearchViewArguments(
      {this.key, this.searchType = SearchType.userToTransferTo});
}

/// TransferFundsAmountView arguments holder class
class TransferFundsAmountViewArguments {
  final Key? key;
  final FundTransferType type;
  final dynamic receiverInfo;
  final void Function()? onContinuePressed;
  TransferFundsAmountViewArguments(
      {this.key,
      required this.type,
      this.receiverInfo,
      this.onContinuePressed});
}
>>>>>>> origin/master
