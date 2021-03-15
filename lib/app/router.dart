import 'package:auto_route/auto_route_annotations.dart';
import 'package:good_wallet/style/page_transitions.dart';
import 'package:good_wallet/ui/views/goodcauses/causes_view.dart';
import 'package:good_wallet/ui/views/home/home_view_mobile.dart';
import 'package:good_wallet/ui/views/home/welcome_view.dart';
import 'package:good_wallet/ui/views/layout/layout_template_view.dart';
import 'package:good_wallet/ui/views/layout/layout_template_view_mobile.dart';
import 'package:good_wallet/ui/views/login/login_view.dart';
import 'package:good_wallet/ui/views/payments/payment_cancel_view.dart';
import 'package:good_wallet/ui/views/payments/payment_success_view.dart';
import 'package:good_wallet/ui/views/payments/send_money_view.dart';
import 'package:good_wallet/ui/views/wallet/wallet_view.dart';

@CustomAutoRouter(transitionsBuilder: customTransition, routes: [
  CustomRoute(page: WelcomeView, transitionsBuilder: customTransition),
  CustomRoute(page: WalletView, transitionsBuilder: customTransition),
  CustomRoute(page: SendMoneyView, transitionsBuilder: customTransition),
  CustomRoute(page: DonationView, transitionsBuilder: customTransition),
  CustomRoute(page: PaymentSuccessView, transitionsBuilder: customTransition),
  CustomRoute(page: PaymentCancelView, transitionsBuilder: customTransition),
  CustomRoute(page: LayoutTemplate, transitionsBuilder: customTransition),
  CustomRoute(page: LoginView, transitionsBuilder: customTransition),

  // Mobile routes
  CustomRoute(page: LayoutTemplateViewMobile),
  CustomRoute(page: HomeViewMobile),
])
class $Router {}
