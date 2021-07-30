import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

class HorizontalCentralButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  final Color? color;
  final double? minWidth;
  final double? maxWidth;
  final double minHeight;

  const HorizontalCentralButton(
      {Key? key,
      required this.onPressed,
      required this.title,
      this.color,
      this.minWidth,
      this.maxWidth,
      this.minHeight = 35.0})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: minWidth ?? screenWidthWithoutPadding(context),
        maxWidth: maxWidth ?? screenWidthWithoutPadding(context),
        minHeight: minHeight,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0.0),
          elevation: 0.0,
          primary: color ?? ColorSettings.primaryColor.withOpacity(0.9),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 12.0, bottom: 12.0, left: 20.0, right: 20.0),
          child: FittedBox(
            child: Text(
              title,
              style: textTheme(context)
                  .headline5!
                  .copyWith(fontSize: 18, color: ColorSettings.whiteTextColor),
            ),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
