import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/shared/style_settings.dart';
import 'package:good_wallet/ui/widgets/call_to_action_button.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

class ProjectSliverAppBar extends StatelessWidget {
  final String organizationName;
  final String title;
  final String? description;

  final double? titleSize;
  final bool isFavoriteProject;
  final String backgroundImageUrl;

  final void Function() onDonateButtonPressed;
  final void Function()? onRightIconPressed;
  final void Function()? onTopLeftIconPressed;

  const ProjectSliverAppBar({
    Key? key,
    required this.organizationName,
    required this.title,
    required this.isFavoriteProject,
    required this.backgroundImageUrl,
    this.description,
    this.titleSize,
    this.onRightIconPressed,
    required this.onDonateButtonPressed,
    required this.onTopLeftIconPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      iconTheme: IconThemeData(
        color: ColorSettings.blackHeadlineColor,
        //change your color here
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            padding: const EdgeInsets.all(LayoutSettings.horizontalPadding),
            icon: Icon(Icons.arrow_back_ios,
                size: 26, color: ColorSettings.blackHeadlineColor),
            onPressed: onTopLeftIconPressed,
          ),
          // Flexible(
          //   child: Text(
          //     "",
          //     overflow: TextOverflow.ellipsis,
          //     style: textTheme(context).headline5,
          //   ),
          // ),

          IconButton(
            padding: const EdgeInsets.all(LayoutSettings.horizontalPadding),
            icon: Icon(
                isFavoriteProject ? Icons.favorite : Icons.favorite_border,
                size: 26,
                color: isFavoriteProject
                    ? ColorSettings.primaryColor
                    : ColorSettings.blackHeadlineColor),
            onPressed: onRightIconPressed,
          ),
        ],
      ),
      titleSpacing: 0,
      expandedHeight: 280,
      toolbarHeight: LayoutSettings.minAppBarHeight,
      collapsedHeight: LayoutSettings.minAppBarHeight,
      backgroundColor: ColorSettings.backgroundColor,
      elevation: 0.0,
      pinned: true,
      stretch: false,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        titlePadding: EdgeInsets.only(
            left: LayoutSettings.horizontalPadding,
            right: 10,
            bottom: 10,
            top: 10),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: onDonateButtonPressed,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(0.0),
                elevation: 0.0,
                primary: ColorSettings.primaryColor.withOpacity(0.9),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 5.0, bottom: 5.0, left: 20.0, right: 20.0),
                child: Text("Donate"),
              ),
            ),
          ],
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(backgroundImageUrl, fit: BoxFit.cover),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.1, 0.25, 0.4, 1.0],
                  colors: [
                    ColorSettings.backgroundColor!.withOpacity(0.1),
                    ColorSettings.backgroundColor!.withOpacity(0.1),
                    //ColorSettings.backgroundColor!.withOpacity(0.1),
                    Colors.transparent,
                    Colors.transparent,
                    ColorSettings.backgroundColor!,
                  ],
                ),
              ),
            ),
            // Align(
            //   alignment: Alignment.bottomLeft,
            //   child: Padding(
            //     padding: const EdgeInsets.all(15.0),
            //     child: Text(
            //       title,
            //       style: textTheme(context).headline6,
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
