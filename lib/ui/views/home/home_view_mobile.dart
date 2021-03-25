import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/home/home_viewmodel.dart';
import 'package:good_wallet/ui/views/home/home_custom_app_bar_view.dart';
import 'package:good_wallet/ui/widgets/donation_dashboard_card.dart';
import 'package:good_wallet/ui/widgets/pledge_button.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class HomeViewMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => !model.isUserInitialized
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
              body: CustomScrollView(
                key: PageStorageKey('storage-key'),
                physics: AlwaysScrollableScrollPhysics(),
                slivers: [
                  // Todo: create custom SliverAppPersistentHeader
                  SliverPersistentHeader(
                    delegate: HomeCustomAppBarView(
                      maxExtent: screenHeight(context) * 0.3,
                      minExtent: LayoutSettings.minAppBarHeight,
                      //minExtentCustom: LayoutSettings.minAppBarHeight,
                    ),
                    pinned: true,
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: LayoutSettings.horizontalPadding),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                verticalSpaceLarge,
                                Text("Hi " + model.currentUser.fullName,
                                    style: textTheme(context).headline4),
                                verticalSpaceSmall,
                                Text(
                                    "\$ " +
                                        (model.userWallet.currentBalance / 100)
                                            .toString(),
                                    style: textTheme(context).headline2),
                                Text("Your current balance to be donated"),
                                verticalSpaceMedium,
                                SizedBox(
                                  width: screenWidth(context) -
                                      2 * LayoutSettings.horizontalPadding,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      PledgeCircularButton(
                                        title: "Raise money",
                                        onPressed:
                                            model.showRaiseMoneyBottomSheet,
                                        icon: Icon(Icons.add,
                                            color:
                                                ColorSettings.whiteTextColor),
                                      ),
                                      PledgeCircularButton(
                                        title: "Donate",
                                        onPressed: model.navigateToDonationView,
                                        icon: Icon(Icons.favorite,
                                            color:
                                                ColorSettings.whiteTextColor),
                                      ),
                                      PledgeCircularButton(
                                        title: "Send money",
                                        onPressed:
                                            model.showSendMoneyBottomSheet,
                                        icon: Icon(Icons.send,
                                            color:
                                                ColorSettings.whiteTextColor),
                                      ),
                                    ],
                                  ),
                                ),
                                verticalSpaceLarge,
                                Text("Your contributions",
                                    style: textTheme(context).headline6),
                                verticalSpaceSmall,
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxWidth: screenWidth(context) -
                                          2 * LayoutSettings.horizontalPadding),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            DonationDashboardCard(
                                              value:
                                                  model.userWallet.donations /
                                                      100,
                                              subtext: "Given to good causes",
                                              icon: Icon(
                                                Icons.favorite,
                                                size: 30,
                                              ),
                                            ),
                                            // verticalSpaceSmall,
                                            // PledgeButton(
                                            //     title: "+ Donate",
                                            //     onPressed: model
                                            //         .navigateToDonationView),
                                          ],
                                        ),
                                      ),
                                      Spacer(flex: 1),
                                      Expanded(
                                        flex: 5,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            DonationDashboardCard(
                                              value: model.userWallet
                                                      .transferredToPeers /
                                                  100,
                                              subtext: "Pledged for friends",
                                              icon: Icon(
                                                Icons.people,
                                                size: 30,
                                              ),
                                            ),
                                            // verticalSpaceSmall,
                                            // PledgeButton(
                                            //     title: "+ Send money",
                                            //     onPressed: model
                                            //         .showSendMoneyBottomSheet),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                verticalSpaceLarge,
                                Text("Featured apps",
                                    style: textTheme(context).headline6),
                                verticalSpaceLarge,
                                Text("Recent activities",
                                    style: textTheme(context).headline6),
                                verticalSpaceMassive,
                              ],
                            ),
                            SizedBox(width: LayoutSettings.horizontalPadding),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
