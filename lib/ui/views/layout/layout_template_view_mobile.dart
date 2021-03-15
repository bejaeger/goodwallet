import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:good_wallet/style/page_transiation_mobile.dart';
import 'package:good_wallet/ui/views/goodcauses/causes_view_mobile.dart';
import 'package:good_wallet/ui/views/home/home_view_mobile.dart';
import 'package:good_wallet/ui/views/layout/layout_template_viewmodel.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class LayoutTemplateViewMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LayoutTemplateViewModel>.reactive(
      viewModelBuilder: () => LayoutTemplateViewModel(),
      builder: (context, model, child) => Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: getBkgColor(context),
          currentIndex: model.currentIndex,
          onTap: model.setIndex,
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.wallet_giftcard),
            ),
            BottomNavigationBarItem(
              label: 'Give',
              icon: Icon(Icons.favorite),
            ),
          ],
        ),
        body: getViewForIndex(model.currentIndex),
        // MyPageTransitionSwitcher(
        //   reverse: model.reverse,
        //   child: getViewForIndex(model.currentIndex),
      ),
    );
  }

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return HomeViewMobile();
      case 1:
        return GoodCausesViewMobile();
      default:
        return HomeViewMobile();
    }
  }
}
