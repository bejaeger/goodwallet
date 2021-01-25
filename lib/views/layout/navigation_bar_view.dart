import 'package:flutter/material.dart';
import 'package:good_wallet/enums/user_status.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:good_wallet/viewmodels/layout/navigation_bar_view_model.dart';
import 'package:stacked/stacked.dart';

class NavigationBar extends StatelessWidget {
  final dynamic model;
  const NavigationBar({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NavigationBarViewModel>.reactive(
      viewModelBuilder: () => NavigationBarViewModel(),
      builder: (context, model, child) => Card(
        margin: EdgeInsets.only(bottom: 1),
        color: Colors.blue[100],
        elevation: 10,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 10),
          child: Container(
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
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
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      _NavBarItem(
                          label: 'Home',
                          onPressed: () => model.navigateToWelcomeView()),
                      horizontalSpaceMedium,
                      _NavBarItem(
                          label: 'Wallet',
                          onPressed: () => model.navigateToWalletView()),
                      horizontalSpaceMedium,
                      _NavBarItem(
                          label: 'Send Money',
                          onPressed: () => model.navigateToSendMoneyView()),
                      horizontalSpaceMedium,
                      _NavBarItem(
                          label: 'Give',
                          onPressed: () => model.navigateToDonationView()),
                      horizontalSpaceMedium,
                      model.userStatus == UserStatus.SignedIn
                          ? _NavBarItem(
                              label: 'Logout',
                              onPressed: () async => await model.logout())
                          : _NavBarItem(
                              label: 'Login with Google',
                              onPressed: () async =>
                                  await model.loginWithGoogle()),
                    ],
                  ),
                )
              ],
            ),
          ),
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
