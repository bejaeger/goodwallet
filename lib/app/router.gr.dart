// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../views/donation/donation_view.dart';
import '../views/finances/payment_cancel_view.dart';
import '../views/finances/payment_success_view.dart';
import '../views/layout/layout_template_view.dart';
import '../views/send_money_view.dart';
import '../views/wallet_view.dart';
import '../views/welcome_view.dart';

class Routes {
  static const String layoutTemplate = '/layout-template';
  static const String welcomeView = '/welcome-view';
  static const String walletView = '/';
  static const String sendMoneyView = '/send-money-view';
  static const String donationView = '/donation-view';
  static const String paymentSuccessView = '/payment-success-view';
  static const String paymentCancelView = '/payment-cancel-view';
  static const all = <String>{
    layoutTemplate,
    welcomeView,
    walletView,
    sendMoneyView,
    donationView,
    paymentSuccessView,
    paymentCancelView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.layoutTemplate, page: LayoutTemplate),
    RouteDef(Routes.welcomeView, page: WelcomeView),
    RouteDef(Routes.walletView, page: WalletView),
    RouteDef(Routes.sendMoneyView, page: SendMoneyView),
    RouteDef(Routes.donationView, page: DonationView),
    RouteDef(Routes.paymentSuccessView, page: PaymentSuccessView),
    RouteDef(Routes.paymentCancelView, page: PaymentCancelView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    LayoutTemplate: (data) {
      final args = data.getArgs<LayoutTemplateArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => LayoutTemplate(
          key: args.key,
          child: args.child,
        ),
        settings: data,
      );
    },
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
      final args = data.getArgs<SendMoneyViewArguments>(
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
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// LayoutTemplate arguments holder class
class LayoutTemplateArguments {
  final Key key;
  final Widget child;
  LayoutTemplateArguments({this.key, @required this.child});
}

/// SendMoneyView arguments holder class
class SendMoneyViewArguments {
  final Key key;
  final Map<String, String> userInfoMap;
  final dynamic openSearchBarOnBuild;
  SendMoneyViewArguments(
      {this.key, this.userInfoMap, this.openSearchBarOnBuild = false});
}
