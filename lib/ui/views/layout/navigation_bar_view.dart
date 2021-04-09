import 'package:flutter/material.dart';
import 'package:good_wallet/ui/views/layout/navigation_bar_viewmodel.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:good_wallet/utils/extensions/hover_extension.dart';

class NavigationBar extends StatelessWidget {
  final dynamic model;
  const NavigationBar({Key? key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NavigationBarViewModel>.reactive(
      viewModelBuilder: () => NavigationBarViewModel(),
      builder: (context, model, child) => Card(
        margin: EdgeInsets.only(bottom: 3),
        color: Colors.indigo, //Colors.blue[100],
        // Color(0xFF0290FF)
        //Color(0xFF0b80c3) ATLAS blue
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Container(
            height: 40,
            child: CenteredView(
              maxWidth: MediaQuery.of(context).size.width > 1000
                  ? 1000
                  : MediaQuery.of(context).size.width / 1.1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/vacuum.png"),
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
                        // _NavBarItem(
                        //     label: 'Send Money',
                        //     onPressed: () =>
                        //         model.navigateToSendMoneyView()),
                        horizontalSpaceMedium,
                        _NavBarItem(
                            label: 'Give',
                            onPressed: () => model.navigateToDonationView()),
                        horizontalSpaceMedium,
                        model.isUserSignedIn
                            ? _NavBarItem(
                                label: 'Logout',
                                onPressed: () async => await model.logout())
                            : _NavBarItem(
                                label: 'Login',
                                onPressed: () async =>
                                    await model.navigateToLoginScreen()),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String? label;
  final void Function()? onPressed;
  const _NavBarItem({this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      onPressed: onPressed,
      child: Text(
        label!,
        style: TextStyle(
            fontSize: 16, color: Colors.grey[100]), //Colors.grey[100]),
      ),
    ).moveUpOnHover;
  }
}
