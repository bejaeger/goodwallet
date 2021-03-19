import 'package:flutter/material.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

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
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            height: 25,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                textAlign: TextAlign.left,
                style: textTheme(context).headline5.copyWith(fontSize: 18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
