import 'package:flutter/material.dart';
import 'package:good_wallet/app/locator.dart';
import 'package:good_wallet/app/router.gr.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked_services/stacked_services.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationService _navigationService = locator<NavigationService>();
    return WillPopScope(
      onWillPop: () async {
        await _navigationService.navigateTo(Routes.walletView);
        return true;
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(100.0),
          child: CenteredView(
            maxWidth: 600,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Welcome to the',
                  style: TextStyle(
                      fontWeight: FontWeight.w500, height: 0.9, fontSize: 40),
                ),
                Text(
                  'GOOD WALLET',
                  style: TextStyle(
                      fontWeight: FontWeight.w800, height: 0.9, fontSize: 60),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Earn money and spend it on good causes.',
                  style: TextStyle(
                    fontSize: 21,
                    height: 1.7,
                  ),
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Colors.lightBlue,
                  elevation: 10.0,
                  onPressed: () =>
                      _navigationService.navigateTo(Routes.walletView),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Wallet View",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
