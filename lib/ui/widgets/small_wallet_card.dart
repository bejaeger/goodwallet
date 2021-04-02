// shows icon with wallet balance in small card

import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

class SmallWalletCard extends StatelessWidget {
  final Function onTap;
  final num balance;
  final num width;
  final num fontSize;
  final num height;

  const SmallWalletCard(
      {Key key,
      @required this.balance,
      this.onTap,
      this.width = 125.0,
      this.fontSize = 18.0,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 2.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          width: width,
          height: height ?? null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.account_balance_wallet,
                      color: ColorSettings.blackTextColor),
                  horizontalSpaceSmall,
                  Text(
                    "\$ " + (balance / 100).toString(),
                    style: textTheme(context).bodyText2.copyWith(
                        fontWeight: FontWeight.bold, fontSize: fontSize),
                  ),
                ],
              ),
              //Text("Current balance"),
            ],
          ),
        ),
      ),
    );
  }
}
