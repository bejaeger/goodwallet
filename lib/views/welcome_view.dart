import 'package:flutter/material.dart';
import 'package:good_wallet/app/locator.dart';
import 'package:good_wallet/app/router.gr.dart';
import 'package:good_wallet/style/colors.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked_services/stacked_services.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationService _navigationService = locator<NavigationService>();
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
