import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/custom_shape.dart';
import 'package:good_wallet/ui/shared/image_paths.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/shared/style_settings.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

class MoneyPoolSliverAppBar extends StatelessWidget {
  final String title;
  final String? description;
  final String adminName;

  final num amount;
  final double? titleSize;
  final void Function()? onRightIconPressed;
  final void Function()? onSecondRightIconPressed;
  final void Function()? onDeleteMoneyPool;
  final void Function()? onInviteMemberPressed;
  final void Function()? onMembersPressed;

  final int nMembers;

  final Widget? rightIcon;
  final Widget? secondRightIcon;
  final bool pinned;
  final PreferredSize? bottom;

  const MoneyPoolSliverAppBar({
    Key? key,
    required this.title,
    required this.amount,
    required this.adminName,
    this.description,
    this.titleSize,
    this.onRightIconPressed,
    this.rightIcon,
    this.pinned = false,
    this.bottom,
    this.onSecondRightIconPressed,
    this.secondRightIcon,
    this.onDeleteMoneyPool,
    this.onInviteMemberPressed,
    required this.nMembers,
    this.onMembersPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: MyAppBar(onDeleteMoneyPool: onDeleteMoneyPool, title: title),
      titleSpacing: 10,
      expandedHeight: LayoutSettings.moneyPoolSliverAppBarExpandedHeight,
      collapsedHeight: LayoutSettings.minAppBarHeight,
      backgroundColor: Colors.transparent, //MyColors.paletteBlue,
      elevation: 2.0,
      toolbarHeight: LayoutSettings.minAppBarHeight,
      pinned: pinned,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: MyFlexiableAppBar(
          nMembers: nMembers,
          title: title,
          amount: amount,
          description: description,
          adminName: adminName,
          onInviteMemberPressed: onInviteMemberPressed,
          onMembersPressed: onMembersPressed,
        ),
      ),
    );
  }
}

class MyAppBar extends StatelessWidget {
  final void Function()? onDeleteMoneyPool;
  final String title;
  const MyAppBar({required this.onDeleteMoneyPool, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: Text(
            "",
            overflow: TextOverflow.ellipsis,
            style: textTheme(context)
                .headline5!
                .copyWith(fontSize: Style.pageHeaderSize),
          ),
        ),
        PopupMenuButton(
          icon: Icon(
            Icons.menu,
            size: 28,
            color: ColorSettings.whiteTextColor,
          ),
          itemBuilder: (context) => [
            // PopupMenuItem(
            //   value: 1,
            //   child: TextButton(
            //       onPressed: model.showNotImplementedSnackbar,
            //       child: Text("Share")),
            // ),
            PopupMenuItem(
              value: 1,
              child: TextButton(
                onPressed: onDeleteMoneyPool,
                child: Text("Delete"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class MyFlexiableAppBar extends StatelessWidget {
  final String title;
  final String? description;
  final String adminName;
  final int nMembers;

  final void Function()? onMembersPressed;
  final void Function()? onInviteMemberPressed;

  final num amount;
  const MyFlexiableAppBar(
      {required this.title,
      required this.amount,
      required this.adminName,
      this.description,
      this.onMembersPressed,
      this.onInviteMemberPressed,
      required this.nMembers});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Container(
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.only(
        //         bottomLeft: Radius.circular(30),
        //         bottomRight: Radius.circular(30)),
        //     gradient: LinearGradient(
        //       begin: Alignment.topCenter,
        //       end: Alignment.bottomCenter,
        //       stops: [0.0, 0.3, 1.0],
        //       colors: [
        //         MyColors.paletteBlue.withOpacity(0.9),
        //         MyColors.paletteBlue.withOpacity(0.9),
        //         MyColors.paletteBlue.withOpacity(0.9),
        //       ],
        //     ),
        //   ),
        // ),
        CustomPaint(painter: CustomShape2(Colors.cyan[800]!)),
        // Container(
        //   decoration: BoxDecoration(
        //     //color: Colors.red,
        //     image: DecorationImage(
        //         image: AssetImage(ImagePath.fourPeopleLaughing),
        //         alignment: Alignment.topCenter,
        //         fit: BoxFit.fitWidth),
        //   ),
        // ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
              children: [
                SizedBox(
                  height:
                      LayoutSettings.moneyPoolSliverAppBarExpandedHeight / 4,
                ),
                Text(formatAmount(amount),
                    style: TextStyle(
                        color: ColorSettings.whiteTextColor,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w800,
                        fontSize: 45.0)),
                Text("Current total",
                    style: textTheme(context)
                        .bodyText1!
                        .copyWith(color: Colors.white60)),
                verticalSpaceMedium,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SmallMoneyPoolButton(
                        onPressed: onMembersPressed,
                        title: nMembers == 1
                            ? "$nMembers Member"
                            : "$nMembers Members"),
                    horizontalSpaceRegular,
                    SmallMoneyPoolButton(
                      icon: Icons.person_add,
                      title: "Invite",
                      onPressed: onInviteMemberPressed,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class SmallMoneyPoolButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final IconData? icon;

  const SmallMoneyPoolButton({
    Key? key,
    this.onPressed,
    required this.title,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white.withOpacity(0.1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
          child: Row(
            children: <Widget>[
              if (icon != null)
                Container(
                  child: Icon(
                    icon!,
                    color: ColorSettings.whiteTextColor,
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
                      color: Colors.white,
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
