// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../views/causes/causes_view.dart';
import '../views/layout/layout_template_view.dart';
import '../views/login/login_view.dart';
import '../views/payments/payment_cancel_view.dart';
import '../views/payments/payment_success_view.dart';
import '../views/payments/send_money_view.dart';
import '../views/wallet/wallet_view.dart';
import '../views/welcome_view.dart';
import 'router.dart';

class Routes {
  static const String welcomeView = '/welcome-view';
  static const String walletView = '/wallet-view';
  static const String sendMoneyView = '/send-money-view';
  static const String donationView = '/donation-view';
  static const String paymentSuccessView = '/payment-success-view';
  static const String paymentCancelView = '/payment-cancel-view';
  static const String layoutTemplate = '/layout-template';
  static const String loginView = '/login-view';
  static const all = <String>{
    welcomeView,
    walletView,
    sendMoneyView,
    donationView,
    paymentSuccessView,
    paymentCancelView,
    layoutTemplate,
    loginView,
  };
}

class Router extends RouterBase {
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
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    WelcomeView: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const WelcomeView(),
        settings: data,
        transitionsBuilder: customTransition,
      );
    },
    WalletView: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => WalletView(),
        settings: data,
        transitionsBuilder: customTransition,
      );
    },
    SendMoneyView: (data) {
      final args = data.getArgs<SendMoneyViewArguments>(
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
      final args = data.getArgs<LayoutTemplateArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => LayoutTemplate(
          key: args.key,
          childView: args.childView,
        ),
        settings: data,
      );
    },
    LoginView: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => LoginView(),
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
