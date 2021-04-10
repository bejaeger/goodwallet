import 'package:flutter/material.dart';
import 'package:good_wallet/enums/bottom_navigator_index.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/causes/causes_view_mobile.dart';
import 'package:good_wallet/ui/views/home/home_view_mobile.dart';
import 'package:good_wallet/ui/views/layout/layout_template_viewmodel.dart';
import 'package:good_wallet/ui/views/profile/profile_view_mobile.dart';
import 'package:good_wallet/ui/views/raise_money/raise_money_view.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class LayoutTemplateViewMobile extends StatelessWidget {
  final int? index;
  const LayoutTemplateViewMobile({Key? key, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LayoutTemplateViewModel>.reactive(
      viewModelBuilder: () => LayoutTemplateViewModel(),
      onModelReady: (model) {
        if (index != null) model.setIndex(index!);
        return null;
      },
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          //extendBodyBehindAppBar: true,
          extendBody: true,
          bottomNavigationBar:
              // Card(
              //   margin: EdgeInsets.all(0.0),
              //   elevation: 2.0,
              //   child: Container(
              //     height: LayoutSettings.bottomNavigationBarHeight,
              //     color: Colors.white,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceAround,
              //       children: <Widget>[
              //         Icon(Icons.home_rounded, size: 28),
              //         Icon(Icons.favorite, size: 28),
              //         Icon(Icons.person, size: 28),
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(
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
                  icon: Icon(Icons.home_rounded, size: 20),
                ),
                BottomNavigationBarItem(
                  label: 'Donate',
                  icon: Icon(Icons.favorite, size: 20),
                ),
                BottomNavigationBarItem(
                  label: 'Raise Money',
                  icon: Icon(Icons.arrow_upward, size: 20),
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
      return CausesViewMobile();
    } else if (index == BottomNavigatorIndex.RaiseMoney.index) {
      return RaiseMoneyView();
    } else {
      return HomeViewMobile();
    }
  }
}
