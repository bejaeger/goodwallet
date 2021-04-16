import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

class CustomSliverAppBarSmall extends StatelessWidget {
  final String title;
  final void Function()? onRightIconPressed;
  final Widget? rightIcon;

  const CustomSliverAppBarSmall(
      {Key? key, required this.title, this.onRightIconPressed, this.rightIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: textTheme(context).headline3!.copyWith(fontSize: 25)),
              if (onRightIconPressed != null)
                GestureDetector(
                  onTap: onRightIconPressed,
                  child: rightIcon ??
                      Icon(
                        Icons.person,
                        color: ColorSettings.whiteTextColor,
                        size: 25,
                      ),
                ),
            ],
          ),
        ],
      ),
      titleSpacing: 20,
      expandedHeight: LayoutSettings.minAppBarHeight * 1,
      collapsedHeight: LayoutSettings.minAppBarHeight,
      backgroundColor: ColorSettings.primaryColor, //Colors.white,
      elevation: 2.0,
      toolbarHeight: LayoutSettings.minAppBarHeight,
      pinned: true,
    );
  }
}
