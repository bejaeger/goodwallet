import 'package:flutter/material.dart';
import 'package:good_wallet/enums/featured_app_type.dart';
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
                                Card(
                                  elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  color: Colors.white,
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        top: 15.0, bottom: 15.0, left: 10.0),
                                    width: screenWidthWithoutPadding(context) -
                                        8.0,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "\$ " +
                                                (model.userWallet
                                                            .currentBalance /
                                                        100)
                                                    .toString(),
                                            style:
                                                textTheme(context).headline2),
                                        Text(
                                            "Your current balance to be donated"),
                                      ],
                                    ),
                                  ),
                                ),
                                verticalSpaceMedium,
                                SizedBox(
                                  width: screenWidthWithoutPadding(context),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      PledgeCircularButton(
                                        title: "Raise money",
                                        onPressed:
                                            model.showRaiseMoneyBottomSheet,
                                        buttonColor: MyColors.paletteBlue
                                            .withOpacity(0.90),
                                        icon: Icon(Icons.add,
                                            color:
                                                ColorSettings.whiteTextColor),
                                      ),
                                      PledgeCircularButton(
                                        title: "Donate",
                                        onPressed: model.navigateToDonationView,
                                        buttonColor: ColorSettings.primaryColor
                                            .withOpacity(1.0),
                                        icon: Icon(Icons.favorite,
                                            color:
                                                ColorSettings.whiteTextColor),
                                      ),
                                      PledgeCircularButton(
                                        title: "Send money",
                                        onPressed:
                                            model.showSendMoneyBottomSheet,
                                        buttonColor: ColorSettings
                                            .primaryColorLight
                                            .withOpacity(1.0),
                                        icon: Icon(Icons.send_rounded,
                                            color:
                                                ColorSettings.whiteTextColor),
                                      ),
                                    ],
                                  ),
                                ),
                                verticalSpaceMediumLarge,
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
                                        flex: 10,
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
                                                color:
                                                    ColorSettings.primaryColor,
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
                                        flex: 10,
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
                                                Icons.send_rounded,
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
                              ],
                            ),
                            SizedBox(width: LayoutSettings.horizontalPadding),
                          ],
                        ),
                        verticalSpaceMediumLarge,
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: LayoutSettings.horizontalPadding),
                          child: Text("Featured apps",
                              style: textTheme(context).headline6),
                        ),
                        verticalSpaceSmall,
                        FeaturedAppsCarousel(model: model),
                        verticalSpaceMediumLarge,
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: LayoutSettings.horizontalPadding),
                          child: Text("Recent activities",
                              style: textTheme(context).headline6),
                        ),
                        verticalSpaceMassive,
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class FeaturedAppsCarousel extends StatelessWidget {
  final dynamic model;

  const FeaturedAppsCarousel({Key key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            SizedBox(width: LayoutSettings.horizontalPadding),
            CarouselCard(
              title: "Marketplace",
              explanation: "Sell items in exchange for Good Dollars",
              onTap: () => model
                  .navigateToSingleFeaturedAppView(FeaturedAppType.Marketplace),
            ),
            SizedBox(width: LayoutSettings.horizontalPadding),
            CarouselCard(
              title: "Sportsbetting",
              explanation: "Bet with friends and win Good Gollars",
              onTap: () => null,
              backgroundColor: MyColors.paletteTurquoise,
            ),
            SizedBox(width: LayoutSettings.horizontalPadding),
            CarouselCard(
              title: "Your Application",
              explanation:
                  "This could be your application that leverages the Good Wallet to do good",
              onTap: () => null,
              backgroundColor: MyColors.palettePurple,
            ),
            SizedBox(width: LayoutSettings.horizontalPadding),
          ],
        ));
  }
}

class CarouselCard extends StatelessWidget {
  final String title;
  final Function onTap;
  final String explanation;
  final Color backgroundColor;

  const CarouselCard(
      {Key key,
      @required this.title,
      @required this.onTap,
      @required this.explanation,
      this.backgroundColor = MyColors.paletteBlue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidthPercentage(context, percentage: 0.8),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 2.0,
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [backgroundColor, backgroundColor.withOpacity(0.7)],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                        width: screenWidthPercentage(context, percentage: 0.45),
                        child: Text(explanation,
                            style: textTheme(context)
                                .bodyText1
                                .copyWith(fontSize: 16))),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Icon(Icons.arrow_forward_ios,
                        color: ColorSettings.whiteTextColor, size: 20),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(title, style: textTheme(context).headline5),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
