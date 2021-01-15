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
import '../views/navigation_view.dart';
import '../views/send_money_view.dart';
import '../views/wallet_view.dart';

class Routes {
  static const String navigationView = '/';
  static const String walletView = '/wallet-view';
  static const String sendMoneyView = '/send-money-view';
  static const String donationView = '/donation-view';
  static const String paymentSuccessView = '/payment-success-view';
  static const String paymentCancelView = '/payment-cancel-view';
  static const all = <String>{
    navigationView,
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
    RouteDef(Routes.navigationView, page: NavigationView),
    RouteDef(Routes.walletView, page: WalletView),
    RouteDef(Routes.sendMoneyView, page: SendMoneyView),
    RouteDef(Routes.donationView, page: DonationView),
    RouteDef(Routes.paymentSuccessView, page: PaymentSuccessView),
    RouteDef(Routes.paymentCancelView, page: PaymentCancelView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    NavigationView: (data) {
      final args = data.getArgs<NavigationViewArguments>(
        orElse: () => NavigationViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => NavigationView(
          key: args.key,
          pageIndex: args.pageIndex,
        ),
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

/// NavigationView arguments holder class
class NavigationViewArguments {
  final Key key;
  final dynamic pageIndex;
  NavigationViewArguments({this.key, this.pageIndex});
}

/// SendMoneyView arguments holder class
class SendMoneyViewArguments {
  final Key key;
  final Map<String, String> userInfoMap;
  final dynamic openSearchBarOnBuild;
  SendMoneyViewArguments(
      {this.key, this.userInfoMap, this.openSearchBarOnBuild = false});
}
