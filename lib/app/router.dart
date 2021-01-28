import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter/material.dart';
import 'package:good_wallet/views/causes/causes_view.dart';
import 'package:good_wallet/views/layout/layout_template_view.dart';
import 'package:good_wallet/views/login/login_view.dart';
import 'package:good_wallet/views/payments/payment_cancel_view.dart';
import 'package:good_wallet/views/payments/payment_success_view.dart';
import 'package:good_wallet/views/payments/send_money_view.dart';
import 'package:good_wallet/views/wallet/wallet_view.dart';
import 'package:good_wallet/views/welcome_view.dart';

class CustomTransition extends StatefulWidget {
  final Widget child;

  const CustomTransition({Key key, @required this.child}) : super(key: key);
  @override
  _CustomTransitionState createState() => _CustomTransitionState();
}

class _CustomTransitionState extends State<CustomTransition>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    _controller =
        AnimationController(duration: Duration(milliseconds: 100), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return FadeTransition(opacity: _animation, child: widget.child);
  }
}

Widget customTransition(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  return CustomTransition(child: child);
}

@CustomAutoRouter(transitionsBuilder: customTransition, routes: [
  CustomRoute(page: WelcomeView, transitionsBuilder: customTransition),
  CustomRoute(page: WalletView, transitionsBuilder: customTransition),
  CustomRoute(page: SendMoneyView),
  CustomRoute(page: DonationView),
  CustomRoute(page: PaymentSuccessView),
  CustomRoute(page: PaymentCancelView),
  CustomRoute(page: LayoutTemplate),
  CustomRoute(page: LoginView),
])
class $Router {}
