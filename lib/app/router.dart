import 'package:auto_route/auto_route_annotations.dart';
import 'package:good_wallet/views/causes/causes_view.dart';
import 'package:good_wallet/views/layout/layout_template_view.dart';
import 'package:good_wallet/views/payments/payment_cancel_view.dart';
import 'package:good_wallet/views/payments/payment_success_view.dart';
import 'package:good_wallet/views/payments/send_money_view.dart';
import 'package:good_wallet/views/wallet/wallet_view.dart';
import 'package:good_wallet/views/welcome_view.dart';

@MaterialAutoRouter(routes: [
  MaterialRoute(page: WelcomeView),
  MaterialRoute(page: WalletView),
  MaterialRoute(page: SendMoneyView),
  MaterialRoute(page: DonationView),
  MaterialRoute(page: PaymentSuccessView),
  MaterialRoute(page: PaymentCancelView),
  MaterialRoute(page: LayoutTemplate),
])
class $Router {}
