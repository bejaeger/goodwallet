import 'package:auto_route/auto_route_annotations.dart';
import 'package:good_wallet/style/page_transitions.dart';
import 'package:good_wallet/views/causes/causes_view.dart';
import 'package:good_wallet/views/layout/layout_template_view.dart';
import 'package:good_wallet/views/login/login_view.dart';
import 'package:good_wallet/views/payments/payment_cancel_view.dart';
import 'package:good_wallet/views/payments/payment_success_view.dart';
import 'package:good_wallet/views/payments/send_money_view.dart';
import 'package:good_wallet/views/wallet/wallet_view.dart';
import 'package:good_wallet/views/welcome_view.dart';

@CustomAutoRouter(transitionsBuilder: customTransition, routes: [
  CustomRoute(page: WelcomeView, transitionsBuilder: customTransition),
  CustomRoute(page: WalletView, transitionsBuilder: customTransition),
  CustomRoute(page: SendMoneyView, transitionsBuilder: customTransition),
  CustomRoute(page: DonationView, transitionsBuilder: customTransition),
  CustomRoute(page: PaymentSuccessView, transitionsBuilder: customTransition),
  CustomRoute(page: PaymentCancelView, transitionsBuilder: customTransition),
  CustomRoute(page: LayoutTemplate, transitionsBuilder: customTransition),
  CustomRoute(page: LoginView, transitionsBuilder: customTransition),
])
class $Router {}
