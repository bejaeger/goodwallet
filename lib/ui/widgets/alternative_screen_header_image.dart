import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

class AlternativeScreenHeaderImage extends StatelessWidget {
  final Widget backgroundWidget;
  final String title;
  final void Function()? onTopLeftButtonPressed;
  final Widget? topLeftWidget;
  final Widget? topRightWidget;
  final Widget? bottomRightWidget;
  final double imageHeight;

  const AlternativeScreenHeaderImage(
      {Key? key,
      required this.backgroundWidget,
      required this.title,
      this.onTopLeftButtonPressed,
      this.topRightWidget,
      this.imageHeight = 250,
      this.bottomRightWidget,
      this.topLeftWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: imageHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            width: screenWidth(context),
            height: 200.0,
            child: backgroundWidget,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                //stops: [0.0, 1.0],
                colors: [
                  Colors.transparent,
                  MyColors.black87.withOpacity(0.6),
                ],
              ),
            ),
          ),
          if (onTopLeftButtonPressed != null)
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: LayoutSettings.horizontalPadding,
                    vertical: 8.0),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerLeft,
                  icon: topLeftWidget ??
                      Icon(
                        Icons.arrow_back_ios,
                        color: MyColors.almostWhite,
                        size: 25,
                      ),
                  onPressed: onTopLeftButtonPressed,
                ),
              ),
            ),
          if (topRightWidget != null)
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: topRightWidget,
              ),
            ),
          if (bottomRightWidget != null)
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: bottomRightWidget,
              ),
            ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
              child: SizedBox(
                width: screenWidthPercentage(context, percentage: 0.8),
                child: Text(
                  title,
                  style: textTheme(context).headline3!.copyWith(fontSize: 25),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
