import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:good_wallet/viewmodels/navigation_view_model.dart';
import 'package:good_wallet/views/donation/donation_view.dart';
import 'package:good_wallet/views/send_money_view.dart';
import 'package:good_wallet/views/utils/ui_helpers.dart';
import 'package:good_wallet/views/wallet_view.dart';
import 'package:good_wallet/views/welcome_view.dart';
import 'package:stacked/stacked.dart';

class NavigationView extends StatelessWidget {
  final pageIndex;
  const NavigationView({Key key, this.pageIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ViewModelBuilder<NavigationViewModel>.reactive(
      viewModelBuilder: () => NavigationViewModel(),
      onModelReady: (model) {
        model.setIndex(pageIndex);
        model.handleStartUpLogic();
        return null;
      },
      builder: (context, model, child) => Scaffold(
        body: CenteredView(
          maxWidth: screenSize.width,
          child: Column(
            children: <Widget>[
              NavigationBar(model: model),
              Expanded(
                child: PageTransitionSwitcher(
                  duration: const Duration(milliseconds: 300),
                  reverse: model.reverse,
                  transitionBuilder: (
                    Widget child,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                  ) {
                    return SharedAxisTransition(
                      child: child,
                      animation: animation,
                      secondaryAnimation: secondaryAnimation,
                      transitionType: SharedAxisTransitionType.horizontal,
                    );
                  },
                  child: getViewForIndex(model, model.currentIndex),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getViewForIndex(dynamic model, int index) {
    switch (index) {
      case 0:
        return WelcomeView();
      case 1:
        return WalletView();
      case 2:
        return SendMoneyView();
      case 3:
        return DonationView();
      default:
        return WelcomeView();
    }
  }
}

class NavigationBar extends StatelessWidget {
  final dynamic model;
  const NavigationBar({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 150,
            width: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/wallet_icon.png"),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _NavBarItem(label: 'Home', onPressed: () => model.setIndex(0)),
              _NavBarItem(label: 'Wallet', onPressed: () => model.setIndex(1)),
              _NavBarItem(
                  label: 'Send Money', onPressed: () => model.setIndex(2)),
              _NavBarItem(
                  label: 'Donation Options',
                  onPressed: () => model.setIndex(3)),
              model.currentUser != null
                  ? _NavBarItem(
                      label: 'Logout ${model.currentUser.fullName[0]}.',
                      onPressed: () => model.logout())
                  : _NavBarItem(
                      label: 'Login with Google',
                      onPressed: () => model.loginWithGoogle()),
            ],
          )
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String label;
  final Function onPressed;
  const _NavBarItem({this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(fontSize: 17),
      ),
    );
  }
}
