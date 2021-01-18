import 'package:flutter/material.dart';
import 'package:good_wallet/viewmodels/navigation_bar_view_model.dart';
import 'package:stacked/stacked.dart';

class NavigationBar extends StatelessWidget {
  final dynamic model;
  const NavigationBar({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NavigationBarViewModel>.reactive(
      viewModelBuilder: () => NavigationBarViewModel(),
      onModelReady: (model) {
        model.handleStartUpLogic();
      },
      builder: (context, model, child) => Container(
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
                _NavBarItem(
                    label: 'Home',
                    onPressed: () => model.navigateToWelcomeView()),
                _NavBarItem(
                    label: 'Wallet',
                    onPressed: () => model.navigateToWalletView()),
                _NavBarItem(
                    label: 'Send Money',
                    onPressed: () => model.navigateToSendMoneyView()),
                _NavBarItem(
                    label: 'Donation Options',
                    onPressed: () => model.navigateToDonationView()),
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
