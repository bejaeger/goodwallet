import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';

class SmallButtonWithBackground extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final IconData? icon;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final double width;

  const SmallButtonWithBackground({
    Key? key,
    this.onPressed,
    required this.title,
    this.icon,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.white,
    this.iconColor = Colors.white,
    this.width = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: backgroundColor.withOpacity(0.1),
        ),
        width: width,
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (icon != null)
                Container(
                  child: Icon(
                    icon!,
                    color: iconColor,
                  ),
                ),
              if (icon != null)
                SizedBox(
                  width: 10,
                ),
              Container(
                child: Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: textColor,
                      fontFamily: 'Poppins',
                      fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
