import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

import 'package:flutter/material.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

// Call-to-action (CTA) buttons for home view

class PledgeCircularButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final Widget icon;
  final Color buttonColor;
  const PledgeCircularButton(
      {Key key,
      @required this.title,
      @required this.onPressed,
      this.icon,
      this.buttonColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            style:
                ElevatedButton.styleFrom(shape: CircleBorder(), elevation: 2.0),
            onPressed: onPressed,
            child: CircleAvatar(
                child: icon,
                backgroundColor: buttonColor ?? ColorSettings.primaryColorLight,
                radius: 30),
          ),
          verticalSpaceTiny,
          Text(title,
              style: textTheme(context).bodyText2.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: ColorSettings.blackHeadlineColor))
        ],
      ),
    );
  }
}

class PledgeButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final double minWidth;
  const PledgeButton(
      {Key key, @required this.title, @required this.onPressed, this.minWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      clipBehavior: Clip.hardEdge,
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(top: 6.0, bottom: 6.0, right: 6.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            height: 25,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                textAlign: TextAlign.left,
                style: textTheme(context).headline5.copyWith(fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
