import 'package:flutter/material.dart';
import 'package:good_wallet/enums/featured_app_type.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/image_icon_paths.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/home/home_viewmodel.dart';
import 'package:good_wallet/ui/widgets/call_to_action_button.dart';
import 'package:good_wallet/ui/widgets/carousel_card.dart';
import 'package:good_wallet/ui/widgets/custom_app_bar_small.dart';
import 'package:good_wallet/ui/widgets/good_wallet_card.dart';
import 'package:good_wallet/ui/widgets/pledge_button.dart';
import 'package:good_wallet/ui/widgets/section_header.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class HomeViewMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.listenToData(),
      builder: (context, model, child) => !model.isUserInitialized
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
              body: RefreshIndicator(
                onRefresh: () async => await model.fetchData(),
                child: CustomScrollView(
                  key: PageStorageKey('storage-key'),
                  physics: ScrollPhysics(),
                  slivers: [
                    CustomSliverAppBarSmall(
                      title: "Home",
                      onSecondRightIconPressed: model.navigateToProfileView,
                      secondRightIcon: Icon(
                        Icons.person,
                        size: 28,
                      ),
                      onRightIconPressed: model.showNotImplementedSnackbar,
                      rightIcon:
                          Icon(Icons.notifications_none_rounded, size: 28),
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
                                  GoodWalletCard(
                                    onCardTap:
                                        model.navigateToTransactionsHistoryView,
                                    onQRCodeTap: model.navigateToQRCodeView,
                                    onHistoryButtonPressed:
                                        model.navigateToTransactionsHistoryView,
                                    onDonateButtonPressed:
                                        model.showDonationBottomSheet,
                                    onCommitButtonPressed:
                                        model.navigateToTransferFundAmountView,
                                    currentBalance:
                                        model.userWallet.currentBalance,
                                    totalDonations: model.userWallet.donations,
                                    totalRaised: model.userWallet.raised,
                                    userInfo: model.getQRCodeUserInfoString(),
                                    showGoodometer: false,
                                  ),
                                  verticalSpaceRegular,
                                  Text("Services",
                                      style: textTheme(context).headline6),
                                  verticalSpaceRegular,
                                  SizedBox(
                                    width: screenWidthWithoutPadding(context),
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          CallToActionButtonRound(
                                            text: "Send money",
                                            onPressed:
                                                model.showSendMoneyBottomSheet,
                                            color: MyColors.lightRed
                                                .withOpacity(0.3),
                                            icon: Icon(Icons.send_rounded,
                                                color: MyColors.lightRed),
                                          ),
                                          CallToActionButtonRound(
                                            text: "Create money pool",
                                            onPressed: model
                                                .navigateToCreateMoneyPoolsView,
                                            color: MyColors.paletteTurquoise
                                                .withOpacity(0.3),
                                            icon: Image.asset(
                                                ImageIconPaths.circleOfPeople,
                                                color:
                                                    MyColors.paletteTurquoise),
                                          ),
                                          CallToActionButtonRound(
                                            text: "Invite friends",
                                            onPressed: model
                                                .showNotImplementedSnackbar,
                                            color:
                                                MyColors.gold.withOpacity(0.3),
                                            icon: Image.asset(
                                                ImageIconPaths.huggingPeople,
                                                color: MyColors.gold),
                                          ),
                                          CallToActionButtonRound(
                                            text: "Explore apps",
                                            onPressed: model
                                                .showNotImplementedSnackbar,
                                            color: MyColors.paletteBlue
                                                .withOpacity(0.3),
                                            icon: Image.asset(
                                              ImageIconPaths.appsAroundGlobus,
                                            ),
                                          ),
                                          // CallToActionButtonRound(
                                          //   text: "Send money",
                                          //   onPressed:
                                          //       model.showSendMoneyBottomSheet,
                                          //   color: MyColors.lightRed
                                          //       .withOpacity(0.3),
                                          //   icon: Icon(Icons.send_rounded,
                                          //       color: MyColors.lightRed),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: LayoutSettings.horizontalPadding),
                            ],
                          ),
                          //verticalSpaceTiny,
                          //_sendMoneyButton(context, model),
                          verticalSpaceTiny,
                          SectionHeader(
                              title: "Projects you supported",
                              onTextButtonTap:
                                  model.showNotImplementedSnackbar),
                          FeaturedProjectsCarousel(model: model),
                          // verticalSpaceMedium,
                          // SectionHeader(
                          //   title: "Stats",
                          //   //onTextButtonTap: model.showNotImplementedSnackbar,
                          // ),
                          // verticalSpaceTiny,
                          // StatisticsDisplay(model: model),
                          verticalSpaceRegular,
                          SectionHeader(
                            title: "Featured apps",
                            onTextButtonTap: model.showNotImplementedSnackbar,
                          ),
                          FeaturedAppsCarousel(model: model),
                          // verticalSpaceRegular,
                          // SectionHeader(
                          //     title: "Projects you supported",
                          //     onTextButtonTap:
                          //         model.showNotImplementedSnackbar),
                          // FeaturedProjectsCarousel(model: model),
                          // //FeaturedAppsCarousel(model: model),
                          // verticalSpaceMedium,
                          verticalSpaceMassive,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _sendMoneyButton(BuildContext context, dynamic model) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        constraints: BoxConstraints(
          minWidth: screenWidthWithoutPadding(context),
          maxWidth: screenWidthWithoutPadding(context),
          minHeight: 45,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(0.0),
              elevation: 0.0,
              primary: ColorSettings.primaryColorLight.withOpacity(0.9)),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12.0, bottom: 12.0, left: 20.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Send Money",
                    style: textTheme(context).headline5!.copyWith(
                        fontSize: 18, color: ColorSettings.whiteTextColor),
                  ),
                  Icon(Icons.send_rounded, color: ColorSettings.whiteTextColor)
                ],
              ),
            ),
          ),
          onPressed: model.showSendMoneyBottomSheet,
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
                style: textTheme(context).headline1!.copyWith(fontSize: 20)),
            Text("Total raised by our community",
                style: textTheme(context).bodyText1),
          ],
        ),
      ),
    );
  }
}

class StatisticsDisplay extends StatelessWidget {
  final dynamic model;

  const StatisticsDisplay({Key? key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: LayoutSettings.horizontalPadding),
      child: Container(
        width: screenWidthWithoutPadding(context, percentage: 0.8),
        height: 200,
        color: MyColors.paletteGrey,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: screenWidthPercentage(context, percentage: 0.7),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "This should be a nice graph like stats view for the user to see a breakdown of his fundraising acitivies as well as donations. E.g. breakdown of total donations: From own commitment, from money pool, from featured Apps!",
                      style: textTheme(context).bodyText1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeaturedProjectsCarousel extends StatelessWidget {
  final dynamic model;

  const FeaturedProjectsCarousel({Key? key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            SizedBox(width: LayoutSettings.horizontalPadding),
            CarouselCard(
              title: "Climate Action",
              explanation:
                  "Continue to help turning the wheels and fight climate change",
              onTap: model.showNotImplementedSnackbar,
              //
            ),
            SizedBox(width: LayoutSettings.horizontalPadding),
            CarouselCard(
              title: "Health and Development",
              explanation: "Have an impact and help people in need",
              onTap: model.showNotImplementedSnackbar,
              backgroundColor: MyColors.paletteTurquoise,
            ),
            SizedBox(width: LayoutSettings.horizontalPadding),
            CarouselCard(
              title: "Poverty",
              explanation: "Help people in need",
              onTap: model.showNotImplementedSnackbar,
              backgroundColor: MyColors.palettePurple,
            ),
            SizedBox(width: LayoutSettings.horizontalPadding),
          ],
        ));
  }
}

class FeaturedAppsCarousel extends StatelessWidget {
  final dynamic model;

  const FeaturedAppsCarousel({Key? key, this.model}) : super(key: key);
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
            onTap: model.showNotImplementedSnackbar,
            backgroundColor: MyColors.paletteTurquoise,
          ),
          SizedBox(width: LayoutSettings.horizontalPadding),
          CarouselCard(
            title: "Your Application",
            explanation:
                "This could be your application that leverages the Good Wallet to do good",
            onTap: model.showNotImplementedSnackbar,
            backgroundColor: MyColors.palettePurple,
          ),
          SizedBox(width: LayoutSettings.horizontalPadding),
        ],
      ),
    );
  }
}
