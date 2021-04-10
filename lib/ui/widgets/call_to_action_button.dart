import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

class CallToActionButton extends StatelessWidget {
  final void Function()? onTap;
  final String? text;
  final Widget? icon;
  final Color? color;
  final bool leadingIcon;

  const CallToActionButton(
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
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: ColorSettings.blackHeadlineColor),
            ),
          ),
        ],
      ),
    );
  }
}
