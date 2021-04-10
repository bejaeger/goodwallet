import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/raise_money/raise_money_viewmodel.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class RaiseMoneyView extends StatelessWidget {
  const RaiseMoneyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RaiseMoneyViewModel>.reactive(
      viewModelBuilder: () => RaiseMoneyViewModel(),
      builder: (context, model, child) => Scaffold(
        body: CustomScrollView(
          key: PageStorageKey('storage-key'),
          physics: AlwaysScrollableScrollPhysics(),
          slivers: [
            // Todo: create custom SliverAppPersistentHeader
            // SliverPersistentHeader(
            //   delegate: HomeCustomAppBarView(
            //     maxExtent: screenHeight(context) * 0.3,
            //     minExtent: LayoutSettings.minAppBarHeight,
            //     //minExtentCustom: LayoutSettings.minAppBarHeight,
            //   ),
            //   pinned: true,
            // ),
            SliverAppBar(
              automaticallyImplyLeading: false,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Raise Money",
                          style: textTheme(context)
                              .headline3!
                              .copyWith(fontSize: 25)),
                      GestureDetector(
                        onTap: model.navigateToProfileView,
                        child: Icon(
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
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: LayoutSettings.horizontalPadding),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpaceMedium,
                        Text("Money Pools",
                            style: textTheme(context).headline6),
                        verticalSpaceMedium,
                        Text("Featured Apps",
                            style: textTheme(context).headline6),
                      ],
                    ),
                    SizedBox(width: LayoutSettings.horizontalPadding),
                  ],
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
