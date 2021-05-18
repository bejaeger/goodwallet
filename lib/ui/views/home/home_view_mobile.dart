import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:good_wallet/enums/featured_app_type.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/image_icon_paths.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/shared/money_transfers/money_transfer_style_helpers.dart';
import 'package:good_wallet/ui/shared/money_transfers/transfer_list_tile.dart';
import 'package:good_wallet/ui/views/home/home_viewmodel.dart';
import 'package:good_wallet/ui/widgets/call_to_action_button.dart';
import 'package:good_wallet/ui/widgets/carousel_card.dart';
import 'package:good_wallet/ui/widgets/custom_app_bar_small.dart';
import 'package:good_wallet/ui/widgets/good_wallet_card.dart';
import 'package:good_wallet/ui/widgets/section_header.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class HomeViewMobile extends StatelessWidget {
  final bool showDialog;
  const HomeViewMobile({Key? key, required this.showDialog}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        onModelReady: (model) async {
          if (showDialog)
            SchedulerBinding.instance?.addPostFrameCallback((timeStamp) async {
              await model.showDialog();
            });
          model.listenToData();
          return;
        },
        builder: (context, model, child) {
          return Scaffold(
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
                    rightIcon: Icon(Icons.notifications_none_rounded, size: 28),
                  ),
                  model.isBusy
                      ? SliverToBoxAdapter(
                          child: Center(child: CircularProgressIndicator()))
                      : SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width: LayoutSettings.horizontalPadding),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      verticalSpaceRegular,
                                      Text("Hi " + model.currentUser.fullName,
                                          style: textTheme(context).headline4),
                                      verticalSpaceRegular,
                                      callToActionButtons(context, model),
                                      verticalSpaceSmall,
                                      GoodWalletCard(
                                        onCardTap: model.navigateToQRCodeView,
                                        onQRCodeTap: model.navigateToQRCodeView,
                                        // onHistoryButtonPressed: model
                                        //     .navigateToTransactionsHistoryView,
                                        // onDonateButtonPressed:
                                        //     model.showDonationBottomSheet,
                                        // onCommitButtonPressed:
                                        //     model.navigateToCommitMoneyView,
                                        currentBalance:
                                            model.userStats.currentBalance,
                                        totalDonations: model.userStats
                                            .donationStatistics.totalDonations,
                                        totalRaised: model
                                            .userStats
                                            .moneyTransferStatistics
                                            .totalRaised,
                                        totalGifted: model
                                            .userStats
                                            .moneyTransferStatistics
                                            .totalSentToPeers,
                                        userInfo:
                                            model.getQRCodeUserInfoString(),
                                        showGoodometer: false,
                                      ),
                                      verticalSpaceRegular,
                                    ],
                                  ),
                                  SizedBox(
                                      width: LayoutSettings.horizontalPadding),
                                ],
                              ),
                              //verticalSpaceTiny,
                              //_sendMoneyButton(context, model),
                              verticalSpaceTiny,
                              SectionHeader(
                                  title: "Recent Activities",
                                  onTextButtonTap:
                                      model.navigateToTransfersHistoryView),
                              // TODO: Make widget out of the following three!
                              if (model.latestTransfers.length == 0)
                                Divider(
                                  color: Colors.grey[500],
                                  thickness: 0.5,
                                ),
                              if (model.latestTransfers.length == 0)
                                ListTile(
                                    title: Text(
                                        "Make a new donation or send money")),
                              if (model.latestTransfers.length == 0)
                                Divider(
                                  color: Colors.grey[500],
                                  thickness: 0.5,
                                ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        LayoutSettings.horizontalPadding),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount: model.latestTransfers.length > 3
                                      ? 3
                                      : model.latestTransfers.length,
                                  itemBuilder: (context, index) {
                                    var data = model.latestTransfers[index];
                                    return TransferListTile(
                                      dense: true,
                                      showBottomDivider: index < 3,
                                      showTopDivider: index == 0,
                                      transaction: data,
                                      style:
                                          getTransactionsCorrespondingToTypeHistoryEntryStyle(
                                              data: data,
                                              type: model
                                                  .inferTransactionType(data)),
                                      amount: data.transferDetails.amount,
                                    );
                                  },
                                ),
                              ),
                              // FeaturedProjectsCarousel(model: model),
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
                                onTextButtonTap:
                                    model.showNotImplementedSnackbar,
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
          );
        });
  }

  SizedBox callToActionButtons(BuildContext context, HomeViewModel model) {
    return SizedBox(
      width: screenWidthWithoutPadding(context),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CallToActionButtonRound(
              text: "Send money",
              onPressed: model.showSendMoneyBottomSheet,
              color: ColorSettings.primaryColorDark.withOpacity(0.8),
              icon:
                  Icon(Icons.send_rounded, color: ColorSettings.whiteTextColor),
            ),
            CallToActionButtonRound(
              text: "Commit money",
              onPressed: model.navigateToCommitMoneyView,
              color: ColorSettings.primaryColorDark.withOpacity(0.8),
              icon: Image.asset(ImageIconPaths.agreeingHands,
                  color: ColorSettings.whiteTextColor),
            ),
            CallToActionButtonRound(
              text: "Donate",
              onPressed: model.showDonationBottomSheet,
              color: ColorSettings.primaryColorDark.withOpacity(0.8),
              icon: Icon(Icons.favorite_rounded,
                  color: ColorSettings.whiteTextColor),
            ),
            CallToActionButtonRound(
              text: "More",
              onPressed: model.showHomeViewMoreBottomSheet,
              color: MyColors.paletteBlue.withOpacity(0.5),
              icon: Icon(Icons.more_vert_rounded,
                  color: ColorSettings.whiteTextColor),
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
