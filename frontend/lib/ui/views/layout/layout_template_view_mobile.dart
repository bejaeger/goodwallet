import 'package:flutter/material.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/shared/style_settings.dart';
import 'package:good_wallet/ui/views/explore_view/explore_view.dart';
import 'package:good_wallet/ui/views/home/home_view_mobile.dart';
import 'package:good_wallet/ui/views/layout/layout_template_viewmodel.dart';
import 'package:good_wallet/ui/views/money_pools/money_pools_view.dart';
import 'package:good_wallet/ui/views/profile/public_profile/public_profile_view_mobile.dart';
import 'package:good_wallet/ui/views/projects/projects_view.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:stacked/stacked.dart';

class LayoutTemplateViewMobile extends StatefulWidget {
  final int? initialBottomNavBarIndex;
  final int? initialTabBarIndex;
  final bool showDialog;

  const LayoutTemplateViewMobile(
      {Key? key,
      this.initialBottomNavBarIndex,
      this.initialTabBarIndex = 0,
      this.showDialog = false})
      : super(key: key);

  @override
  _LayoutTemplateViewMobileState createState() =>
      _LayoutTemplateViewMobileState();
}

class _LayoutTemplateViewMobileState extends State<LayoutTemplateViewMobile> {
  late PersistentTabController _controller;

  @override
  void initState() {
    _controller = PersistentTabController(
        initialIndex: widget.initialBottomNavBarIndex ?? 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LayoutTemplateViewModel>.reactive(
        viewModelBuilder: () => LayoutTemplateViewModel(),
        builder: (context, model, child) {
          return SafeArea(
            child: ConstrainedWidthLayout(
              child: PersistentTabView(
                context,
                controller: _controller,
                screens: _buildScreens(model),
                items: _navBarsItems(model),
                confineInSafeArea: true,
                backgroundColor: Colors.white, // Default is Colors.white.
                handleAndroidBackButtonPress: true, // Default is true.
                resizeToAvoidBottomInset:
                    true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
                stateManagement: true, // Default is true.
                hideNavigationBarWhenKeyboardShows:
                    true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
                decoration: NavBarDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: ColorSettings.greyTextColor!,
                      blurRadius: 12.0, // soften the shadow
                      spreadRadius: 3, //extend the shadow
                      offset: Offset(
                        0, // Move to right 10  horizontally
                        15.0, // Move to bottom 10 Vertically
                      ),
                    )
                  ],
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16.0),
                      topLeft: Radius.circular(16.0)),
                  colorBehindNavBar: Colors.white,
                ),
                popAllScreensOnTapOfSelectedTab: true,
                popActionScreens: PopActionScreensType.all,
                itemAnimationProperties: ItemAnimationProperties(
                  // Navigation Bar's items animation properties.
                  duration: Duration(milliseconds: 300),
                  curve: Curves.ease,
                ),
                screenTransitionAnimation: ScreenTransitionAnimation(
                  // Screen transition animation on change of selected tab.
                  animateTabTransition: true,
                  curve: Curves.ease,
                  duration: Duration(milliseconds: 300),
                ),
                navBarHeight: LayoutSettings.bottomNavigationBarHeight,
                navBarStyle: NavBarStyle
                    .style8, // Choose the nav bar style with this property.
              ),
            ),
          );
        });
  }

  List<Widget> _buildScreens(dynamic model) {
    return [
      HomeViewMobile(showDialog: widget.showDialog),
      ProjectsView(),
      //CausesFilterViewMobile(initialIndex: widget.initialTabBarIndex),
      //MoneyPoolsView(),
      ExploreView(),
      PublicProfileViewMobile(uid: model.currentUser.uid),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems(dynamic model) {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home_rounded),

        //title: ("Home"),
        iconSize: Style.bottomNavigationBarIconSize,
        activeColorPrimary: ColorSettings.primaryColor,
        inactiveColorPrimary: ColorSettings.greyTextColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.favorite,
        ),
        iconSize: Style.bottomNavigationBarIconSize,
        //title: ("Projects"),
        activeColorPrimary: ColorSettings.primaryColor,
        inactiveColorPrimary: ColorSettings.greyTextColor!,
      ),
      // PersistentBottomNavBarItem(
      //   iconSize: Style.bottomNavigationBarIconSize,

      //   icon: Stack(
      //     children: <Widget>[
      //       Center(
      //         child: Icon(Icons.people),
      //       ),
      //       if (model.numberInvitedMoneyPoolsSubject > 0)
      //         Stack(
      //           children: [
      //             Align(
      //               alignment: Alignment(0.25, 0.5),
      //               child: Icon(Icons.circle,
      //                   size: 15, color: ColorSettings.primaryColorLight),
      //             ),
      //             Align(
      //               alignment: Alignment(0.24, 0.0),
      //               child: Text(
      //                 model.numberInvitedMoneyPoolsSubject.toString(),
      //                 style: TextStyle(
      //                     fontSize: 8,
      //                     fontWeight: FontWeight.bold,
      //                     color: ColorSettings.whiteTextColor),
      //               ),
      //             ),
      //           ],
      //         ),
      //     ],
      //   ),
      //   //title: ("Money Pools"),
      //   activeColorPrimary: ColorSettings.primaryColor,
      //   inactiveColorPrimary: ColorSettings.greyTextColor,
      // ),

      PersistentBottomNavBarItem(
        iconSize: Style.bottomNavigationBarIconSize,

        icon: Icon(
          Icons.search_rounded,
        ),
        //title: ("Profile"),
        activeColorPrimary: ColorSettings.primaryColor,
        inactiveColorPrimary: ColorSettings.greyTextColor!,
      ),

      PersistentBottomNavBarItem(
        iconSize: Style.bottomNavigationBarIconSize,
        icon: Icon(
          Icons.person,
        ),
        //title: ("Profile"),
        activeColorPrimary: ColorSettings.primaryColor,
        inactiveColorPrimary: ColorSettings.greyTextColor!,
      ),
    ];
  }
}
