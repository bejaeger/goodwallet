import 'package:flutter/material.dart';
import 'package:good_wallet/enums/featured_app_type.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/home/home_viewmodel.dart';
import 'package:good_wallet/ui/widgets/carousel_card.dart';
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
                            Text("Home",
                                style: textTheme(context)
                                    .headline3
                                    .copyWith(fontSize: 25)),
                            // GestureDetector(
                            //     onTap: model.navigateToSettingsView,
                            //     child: Icon(
                            //       Icons.settings,
                            //       color: ColorSettings.whiteTextColor,
                            //       size: 25,
                            //     ),),
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
                    delegate: SliverChildListDelegate(
                      [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: LayoutSettings.horizontalPadding),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                verticalSpaceMedium,
                                Text("Hi " + model.currentUser.fullName,
                                    style: textTheme(context).headline4),
                                verticalSpaceSmall,
                                GestureDetector(
                                  onTap:
                                      model.navigateToTransactionsHistoryView,
                                  child: Card(
                                    elevation: 2.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    color: Colors.white,
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          top: 15.0, bottom: 15.0, left: 10.0),
                                      width:
                                          screenWidthWithoutPadding(context) -
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
                                              style: textTheme(context)
                                                  .headline2
                                                  .copyWith(fontSize: 28)),
                                          Text(
                                              "Your current balance to be donated"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                verticalSpaceRegular,
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
                              ],
                            ),
                            SizedBox(width: LayoutSettings.horizontalPadding),
                          ],
                        ),
                        verticalSpaceMedium,
                        _goodometerDisplay(context, model),
                        verticalSpaceMedium,
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: LayoutSettings.horizontalPadding),
                          child: Text("Favorite projects",
                              style: textTheme(context).headline6),
                        ),
                        verticalSpaceSmall,
                        FeaturedProjectsCarousel(model: model),
                        verticalSpaceMedium,
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: LayoutSettings.horizontalPadding),
                          child: Text("Featured apps",
                              style: textTheme(context).headline6),
                        ),
                        verticalSpaceSmall,
                        FeaturedAppsCarousel(model: model),
                        verticalSpaceMedium,
                        verticalSpaceMassive,
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Container _goodometerDisplay(BuildContext context, HomeViewModel model) {
    return Container(
      width: screenWidth(context),
      color: ColorSettings.primaryColorLight.withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.only(
            top: 8.0,
            left: LayoutSettings.horizontalPadding,
            bottom: 8.0,
            right: LayoutSettings.horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Goodometer: \$ 10789",
                style: textTheme(context).headline1.copyWith(fontSize: 20)),
            Text("Total raised by our community",
                style: textTheme(context).bodyText1),
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

class FeaturedProjectsCarousel extends StatelessWidget {
  final dynamic model;

  const FeaturedProjectsCarousel({Key key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            SizedBox(width: LayoutSettings.horizontalPadding),
            CarouselCard(
              title: "Health and Development",
              explanation: "Have an impact and change the world for the better",
              onTap: () => model
                  .navigateToSingleFeaturedAppView(FeaturedAppType.Marketplace),
            ),
            SizedBox(width: LayoutSettings.horizontalPadding),
            CarouselCard(
              title: "Climate Action",
              explanation: "Help turning the wheels and fight climate change",
              onTap: () => null,
              backgroundColor: MyColors.paletteTurquoise,
            ),
            SizedBox(width: LayoutSettings.horizontalPadding),
            CarouselCard(
              title: "Poverty",
              explanation: "Help people in need",
              onTap: () => null,
              backgroundColor: MyColors.palettePurple,
            ),
            SizedBox(width: LayoutSettings.horizontalPadding),
          ],
        ));
  }
}
