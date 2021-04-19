import 'package:flutter/material.dart';
import 'package:good_wallet/enums/bottom_navigator_index.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/causes/causes_view_mobile.dart';
import 'package:good_wallet/ui/views/home/home_view_mobile.dart';
import 'package:good_wallet/ui/views/layout/layout_template_viewmodel.dart';
import 'package:good_wallet/ui/views/raise_money/raise_money_view.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:stacked/stacked.dart';

class LayoutTemplateViewMobile extends StatefulWidget {
  final int? index;

  const LayoutTemplateViewMobile({Key? key, this.index}) : super(key: key);

  @override
  _LayoutTemplateViewMobileState createState() =>
      _LayoutTemplateViewMobileState();
}

class _LayoutTemplateViewMobileState extends State<LayoutTemplateViewMobile> {
  late PersistentTabController _controller;

  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: widget.index ?? 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LayoutTemplateViewModel>.reactive(
        viewModelBuilder: () => LayoutTemplateViewModel(),
        builder: (context, model, child) {
          return SafeArea(
            child: Align(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 600),
                child: PersistentTabView(
                  context,
                  controller: _controller,
                  screens: _buildScreens(),
                  items: _navBarsItems(),
                  confineInSafeArea: true,
                  backgroundColor: Colors.white, // Default is Colors.white.
                  handleAndroidBackButtonPress: true, // Default is true.
                  resizeToAvoidBottomInset:
                      true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
                  stateManagement: true, // Default is true.
                  hideNavigationBarWhenKeyboardShows:
                      true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
                  decoration: NavBarDecoration(
                    borderRadius: BorderRadius.circular(16.0),
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
            ),
          );
        });
  }

  List<Widget> _buildScreens() {
    return [HomeViewMobile(), CausesViewMobile(), RaiseMoneyView()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home_rounded),
        title: ("Home"),
        activeColorPrimary: ColorSettings.primaryColorLight,
        inactiveColorPrimary: ColorSettings.greyTextColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.favorite,
        ),
        title: ("Donate"),
        activeColorPrimary: ColorSettings.primaryColorLight,
        inactiveColorPrimary: ColorSettings.greyTextColor!,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.arrow_upward),
        title: ("Raise Money"),
        activeColorPrimary: ColorSettings.primaryColorLight,
        inactiveColorPrimary: ColorSettings.greyTextColor,
      ),
    ];
  }
}
