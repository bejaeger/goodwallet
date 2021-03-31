// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../datamodels/goodcauses/global_giving_project_model.dart';
import '../enums/featured_app_type.dart';
import '../ui/views/featured_applications/single_featured_app_view.dart';
import '../ui/views/goodcauses/causes_view.dart';
import '../ui/views/goodcauses/single_project_view_mobile.dart';
import '../ui/views/home/home_view_mobile.dart';
import '../ui/views/home/welcome_view.dart';
import '../ui/views/layout/layout_template_view.dart';
import '../ui/views/layout/layout_template_view_mobile.dart';
import '../ui/views/login/create_account_view.dart';
import '../ui/views/login/login_view.dart';
import '../ui/views/money_pools/manage_money_pools_view.dart';
import '../ui/views/payments/payment_cancel_view.dart';
import '../ui/views/payments/payment_success_view.dart';
import '../ui/views/payments/send_money_view.dart';
import '../ui/views/payments/send_money_view_mobile.dart';
import '../ui/views/profile/profile_view.dart';
import '../ui/views/wallet/wallet_view.dart';

class Routes {
  static const String welcomeView = '/welcome-view';
  static const String walletView = '/wallet-view';
  static const String sendMoneyView = '/send-money-view';
  static const String donationView = '/donation-view';
  static const String paymentSuccessView = '/payment-success-view';
  static const String paymentCancelView = '/payment-cancel-view';
  static const String layoutTemplate = '/layout-template';
  static const String loginView = '/';
  static const String layoutTemplateViewMobile = '/layout-template-view-mobile';
  static const String homeViewMobile = '/home-view-mobile';
  static const String singleProjectViewMobile = '/single-project-view-mobile';
  static const String profileView = '/profile-view';
  static const String createAccountView = '/create-account-view';
  static const String singleFeaturedAppView = '/single-featured-app-view';
  static const String manageMoneyPoolsView = '/manage-money-pools-view';
  static const String sendMoneyViewMobile = '/send-money-view-mobile';
  static const all = <String>{
    welcomeView,
    walletView,
    sendMoneyView,
    donationView,
    paymentSuccessView,
    paymentCancelView,
    layoutTemplate,
    loginView,
    layoutTemplateViewMobile,
    homeViewMobile,
    singleProjectViewMobile,
    profileView,
    createAccountView,
    singleFeaturedAppView,
    manageMoneyPoolsView,
    sendMoneyViewMobile,
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
    RouteDef(Routes.layoutTemplateViewMobile, page: LayoutTemplateViewMobile),
    RouteDef(Routes.homeViewMobile, page: HomeViewMobile),
    RouteDef(Routes.singleProjectViewMobile, page: SingleProjectViewMobile),
    RouteDef(Routes.profileView, page: ProfileView),
    RouteDef(Routes.createAccountView, page: CreateAccountView),
    RouteDef(Routes.singleFeaturedAppView, page: SingleFeaturedAppView),
    RouteDef(Routes.manageMoneyPoolsView, page: ManageMoneyPoolsView),
    RouteDef(Routes.sendMoneyViewMobile, page: SendMoneyViewMobile),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    WelcomeView: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const WelcomeView(),
        settings: data,
      );
    },
    WalletView: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => WalletView(),
        settings: data,
      );
    },
    SendMoneyView: (data) {
      var args = data.getArgs<SendMoneyViewArguments>(
        orElse: () => SendMoneyViewArguments(),
      );
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => SendMoneyView(
          key: args.key,
          userInfoMap: args.userInfoMap,
          openSearchBarOnBuild: args.openSearchBarOnBuild,
        ),
        settings: data,
      );
    },
    DonationView: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => DonationView(),
        settings: data,
      );
    },
    PaymentSuccessView: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            PaymentSuccessView(),
        settings: data,
      );
    },
    PaymentCancelView: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            PaymentCancelView(),
        settings: data,
      );
    },
    LayoutTemplate: (data) {
      var args = data.getArgs<LayoutTemplateArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => LayoutTemplate(
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
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            LoginView(key: args.key),
        settings: data,
      );
    },
    LayoutTemplateViewMobile: (data) {
      var args = data.getArgs<LayoutTemplateViewMobileArguments>(
        orElse: () => LayoutTemplateViewMobileArguments(),
      );
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            LayoutTemplateViewMobile(
          key: args.key,
          index: args.index,
        ),
        settings: data,
      );
    },
    HomeViewMobile: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            HomeViewMobile(),
        settings: data,
      );
    },
    SingleProjectViewMobile: (data) {
      var args = data.getArgs<SingleProjectViewMobileArguments>(
        orElse: () => SingleProjectViewMobileArguments(),
      );
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            SingleProjectViewMobile(
          key: args.key,
          project: args.project,
        ),
        settings: data,
      );
    },
    ProfileView: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => ProfileView(),
        settings: data,
      );
    },
    CreateAccountView: (data) {
      var args = data.getArgs<CreateAccountViewArguments>(
        orElse: () => CreateAccountViewArguments(),
      );
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            CreateAccountView(key: args.key),
        settings: data,
      );
    },
    SingleFeaturedAppView: (data) {
      var args = data.getArgs<SingleFeaturedAppViewArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            SingleFeaturedAppView(
          key: args.key,
          type: args.type,
        ),
        settings: data,
      );
    },
    ManageMoneyPoolsView: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const ManageMoneyPoolsView(),
        settings: data,
      );
    },
    SendMoneyViewMobile: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            SendMoneyViewMobile(),
        settings: data,
      );
    },
  };
}

/// ******************x******************************************************
/// Arguments holder classes
/// *************************************************************************

/// SendMoneyView arguments holder class
class SendMoneyViewArguments {
  final Key key;
  final Map<String, String> userInfoMap;
  final dynamic openSearchBarOnBuild;
  SendMoneyViewArguments(
      {this.key, this.userInfoMap, this.openSearchBarOnBuild = false});
}

/// LayoutTemplate arguments holder class
class LayoutTemplateArguments {
  final Key key;
  final Widget childView;
  LayoutTemplateArguments({this.key, @required this.childView});
}

/// LoginView arguments holder class
class LoginViewArguments {
  final Key key;
  LoginViewArguments({this.key});
}

/// LayoutTemplateViewMobile arguments holder class
class LayoutTemplateViewMobileArguments {
  final Key key;
  final int index;
  LayoutTemplateViewMobileArguments({this.key, this.index});
}

/// SingleProjectViewMobile arguments holder class
class SingleProjectViewMobileArguments {
  final Key key;
  final GlobalGivingProjectModel project;
  SingleProjectViewMobileArguments({this.key, this.project});
}

/// CreateAccountView arguments holder class
class CreateAccountViewArguments {
  final Key key;
  CreateAccountViewArguments({this.key});
}

/// SingleFeaturedAppView arguments holder class
class SingleFeaturedAppViewArguments {
  final Key key;
  final FeaturedAppType type;
  SingleFeaturedAppViewArguments({this.key, @required this.type});
}
