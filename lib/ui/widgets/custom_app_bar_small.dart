import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/shared/style_settings.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

class CustomAppBarSmall extends StatelessWidget {
  final String title;
  final Widget? rightWidget;
  final PreferredSize? bottom;
  final double height;
  final double titleSize;
  final bool onlyBackButton;
  final double elevation;
  final bool forceElevated;

  const CustomAppBarSmall(
      {Key? key,
      required this.title,
      this.rightWidget,
      this.bottom,
      this.height = LayoutSettings.minAppBarHeight,
      this.titleSize = Style.pageHeaderSize,
      this.onlyBackButton = false,
      this.elevation = 0.0,
      this.forceElevated = Style.elevatedAppBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: AppBar(
        iconTheme: IconThemeData(color: ColorSettings.pageTitleColor),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (title != "")
                  Text(title,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme(context).headline4!.copyWith(
                          fontSize: titleSize,
                          color: ColorSettings.pageTitleColor)),
                if (rightWidget != null) rightWidget!,
              ],
            ),
          ],
        ),
        titleSpacing: 20,
        toolbarHeight: LayoutSettings.minAppBarHeight,
        backgroundColor: ColorSettings.backgroundColor, //Colors.white,
        elevation: forceElevated ? 2.0 : elevation,
        bottom: bottom,
      ),
    );
  }
}

class CustomSliverAppBarSmall extends StatelessWidget {
  final String title;
  final void Function()? onRightIconPressed;
  final void Function()? onSecondRightIconPressed;
  final Widget? rightIcon;
  final Widget? secondRightIcon;
  final bool pinned;
  final PreferredSize? bottom;
  final bool forceElevated;

  const CustomSliverAppBarSmall(
      {Key? key,
      required this.title,
      this.onRightIconPressed,
      this.rightIcon,
      this.pinned = true,
      this.bottom,
      this.onSecondRightIconPressed,
      this.secondRightIcon,
      this.forceElevated = Style.elevatedAppBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      forceElevated: forceElevated,
      iconTheme: IconThemeData(
        color: ColorSettings.pageTitleColor, //change your color here
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: textTheme(context).headline4!.copyWith(
                    fontSize: Style.pageHeaderSize,
                    color: ColorSettings.pageTitleColor),
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (onRightIconPressed != null)
                    GestureDetector(
                      onTap: onRightIconPressed,
                      child: rightIcon ??
                          Icon(
                            Icons.person,
                            color: ColorSettings.pageTitleColor,
                            size: 25,
                          ),
                    ),
                  if (onSecondRightIconPressed != null) SizedBox(width: 22.0),
                  if (onSecondRightIconPressed != null)
                    GestureDetector(
                      onTap: onSecondRightIconPressed,
                      child: secondRightIcon ??
                          Icon(
                            Icons.person,
                            color: ColorSettings.pageTitleColor,
                            size: 25,
                          ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
      titleSpacing: 20,
      expandedHeight: LayoutSettings.minAppBarHeight * 1,
      collapsedHeight: LayoutSettings.minAppBarHeight,
      backgroundColor: ColorSettings.backgroundColor,
      elevation: 2.0,
      toolbarHeight: LayoutSettings.minAppBarHeight,
      pinned: pinned,
      bottom: bottom,
    );
  }
}

class CustomSliverAppBar extends StatelessWidget {
  final String title;
  final double? titleSize;
  final void Function()? onRightIconPressed;
  final void Function()? onSecondRightIconPressed;
  final Widget? rightIcon;
  final Widget? secondRightIcon;
  final bool pinned;
  final PreferredSize? bottom;

  const CustomSliverAppBar(
      {Key? key,
      required this.title,
      this.titleSize,
      this.onRightIconPressed,
      this.rightIcon,
      this.pinned = true,
      this.bottom,
      this.onSecondRightIconPressed,
      this.secondRightIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(
            left: LayoutSettings.horizontalPadding,
            right: 80,
            bottom: 10,
            top: 10),
        title: Text(
          title,
          style: textTheme(context).headline4!.copyWith(
              fontSize: titleSize ?? Style.pageHeaderSize,
              color: ColorSettings.blackHeadlineColor),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "",
                style: textTheme(context).headline4!,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (onRightIconPressed != null)
                    GestureDetector(
                      onTap: onRightIconPressed,
                      child: rightIcon ??
                          Icon(
                            Icons.person,
                            color: ColorSettings.pageTitleColor,
                            size: 25,
                          ),
                    ),
                  if (onSecondRightIconPressed != null) SizedBox(width: 22.0),
                  if (onSecondRightIconPressed != null)
                    GestureDetector(
                      onTap: onSecondRightIconPressed,
                      child: secondRightIcon ??
                          Icon(
                            Icons.person,
                            color: ColorSettings.pageTitleColor,
                            size: 25,
                          ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
      titleSpacing: 20,
      expandedHeight: LayoutSettings.minAppBarHeight * 1.7,
      collapsedHeight: LayoutSettings.minAppBarHeight,
      backgroundColor: ColorSettings.backgroundColor,
      elevation: 2.0,
      toolbarHeight: LayoutSettings.minAppBarHeight,
      pinned: pinned,
      bottom: bottom,
    );
  }
}
