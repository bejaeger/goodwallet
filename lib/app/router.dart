import 'package:auto_route/auto_route_annotations.dart';
import 'package:good_wallet/views/donation/donation_view.dart';
import 'package:good_wallet/views/finances/payment_cancel_view.dart';
import 'package:good_wallet/views/finances/payment_success_view.dart';
import 'package:good_wallet/views/layout/layout_template_view.dart';
import 'package:good_wallet/views/send_money_view.dart';
import 'package:good_wallet/views/wallet_view.dart';
import 'package:good_wallet/views/welcome_view.dart';

@MaterialAutoRouter(routes: [
  MaterialRoute(page: LayoutTemplate),
  MaterialRoute(page: WelcomeView),
  MaterialRoute(page: WalletView, initial: true),
  MaterialRoute(page: SendMoneyView),
  MaterialRoute(page: DonationView),
  MaterialRoute(page: PaymentSuccessView),
  MaterialRoute(page: PaymentCancelView),
])
class $Router {}
