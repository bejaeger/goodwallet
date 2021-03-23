import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:good_wallet/enums/bottom_navigator_index.dart';
import 'package:good_wallet/style/page_transiation_mobile.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/goodcauses/causes_view_mobile.dart';
import 'package:good_wallet/ui/views/home/home_view_mobile.dart';
import 'package:good_wallet/ui/views/layout/layout_template_viewmodel.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class LayoutTemplateViewMobile extends StatelessWidget {
  final int index;
  const LayoutTemplateViewMobile({Key key, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LayoutTemplateViewModel>.reactive(
      viewModelBuilder: () => LayoutTemplateViewModel(),
      onModelReady: (model) {
        print("Rebuild LayoutTemplateViewModel!");
        if (index != null) model.setIndex(index);
        return null;
      },
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          //extendBodyBehindAppBar: true,
          extendBody: true,
          bottomNavigationBar: SizedBox(
            height: LayoutSettings.bottomNavigationBarHeight,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: getBkgColor(context),
              elevation: 5.0,
              currentIndex: model.currentIndex,
              onTap: model.setIndex,
              items: [
                BottomNavigationBarItem(
                  label: 'Home',
                  icon: Icon(Icons.home_filled, size: 20),
                ),
                BottomNavigationBarItem(
                  label: 'Give',
                  icon: Icon(Icons.favorite, size: 20),
                ),
              ],
            ),
          ),
          body: getViewForIndex(
              model.currentIndex), // getViewForIndex(model.currentIndex),
          // body: MyPageTransitionSwitcher(
          //   reverse: model.reverse,
          //   child: getViewForIndex(model.currentIndex),
          //),
        ),
      ),
    );
  }

  Widget getViewForIndex(int index) {
    if (index == BottomNavigatorIndex.Home.index) {
      return HomeViewMobile();
    } else if (index == BottomNavigatorIndex.Give.index) {
      return GoodCausesViewMobile();
    } else {
      return HomeViewMobile();
    }
  }
}
