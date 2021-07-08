import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/utils/string_utils.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

class CallToActionButtonRectangular extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final double? minWidth;
  final double? maxWidth;
  final double? minHeight;
  final double? maxHeight;
  final double? fontSize;
  final Color? color;

  const CallToActionButtonRectangular(
      {Key? key,
      required this.title,
      required this.onPressed,
      this.minWidth,
      this.maxWidth,
      this.minHeight,
      this.maxHeight,
      this.fontSize,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maxWidthActual = maxWidth ?? screenWidthWithoutPadding(context);
    Color colorActual = color ?? ColorSettings.primaryColor.withOpacity(0.8);
    return Container(
      constraints: BoxConstraints(
        minWidth: minWidth ??
            (screenWidthWithoutPadding(context) > maxWidthActual
                ? maxWidthActual
                : screenWidthWithoutPadding(context)),
        maxWidth: maxWidth ?? screenWidthWithoutPadding(context),
        minHeight: minHeight ?? 45,
        maxHeight: maxHeight ?? double.infinity,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(0.0),
            elevation: 0.0,
            primary: colorActual),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 12.0, bottom: 12.0, left: 20.0, right: 20.0),
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme(context).headline5!.copyWith(
                fontSize: fontSize ?? 18,
                color: onPressed != null
                    ? ColorSettings.whiteTextColor
                    : ColorSettings.lightGreyTextColor),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class CallToActionButtonSimple extends StatelessWidget {
  final void Function()? onTap;
  final String? text;
  final Widget? icon;
  final Color? color;
  final bool leadingIcon;

  const CallToActionButtonSimple(
      {Key? key,
      this.leadingIcon = true,
      this.onTap,
      this.text,
      this.icon,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(10),
        //   border: Border.all(color: color!),
        //   //color: color,
        // ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              leadingIcon
                  ? icon != null
                      ? icon!
                      : Container()
                  : Container(),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  text!,
                  style: TextStyle(fontSize: 14, color: color),
                ),
              ),
              leadingIcon
                  ? Container()
                  : icon != null
                      ? icon!
                      : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

// Round call to action button with text below round button
class CallToActionButtonRound extends StatelessWidget {
  final void Function()? onPressed;
  final String? text;
  final Widget? icon;
  final Color? color;

  const CallToActionButtonRound(
      {Key? key, this.onPressed, this.text, this.icon, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: color,
            child: IconButton(
              icon: icon!,
              color: Colors.white,
              onPressed: onPressed,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text!,
              textAlign: TextAlign.center,
              style: textTheme(context).bodyText2!.copyWith(
                  letterSpacing: 0,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: ColorSettings.blackTextColor),
            ),
          ),
        ],
      ),
    );
  }
}

// Round call to action button with text below round button
class CallToActionButtonRoundInitials extends StatelessWidget {
  final void Function() onPressed;
  final String name;
  final Color? color;

  const CallToActionButtonRoundInitials(
      {Key? key, required this.onPressed, required this.name, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: GestureDetector(
        onTap: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: color,
              child: Text(getInitialsFromName(name),
                  style: textTheme(context).headline5!.copyWith(fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme(context).bodyText2!.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: ColorSettings.blackHeadlineColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Round call to action button with text below round button but WITHOUT circle avatar
// and without width settings
class CallToActionIcon extends StatelessWidget {
  final void Function()? onPressed;
  final String? text;
  final Widget? icon;
  final Color? textColor;
  final bool showText;
  final Color backgroundColor;

  const CallToActionIcon(
      {Key? key,
      this.onPressed,
      this.text,
      this.icon,
      this.textColor,
      this.showText = false,
      required this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: backgroundColor.withOpacity(0.3)),
      child: Padding(
        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showText)
              Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Text(
                  text!,
                  textAlign: TextAlign.center,
                  style: textTheme(context).bodyText2!.copyWith(
                      fontSize: 12,
                      //fontWeight: FontWeight.bold,
                      color: textColor ?? ColorSettings.blackHeadlineColor),
                ),
              ),
            IconButton(
              visualDensity: VisualDensity.comfortable,
              padding: const EdgeInsets.all(0.0),
              icon: icon!,
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
