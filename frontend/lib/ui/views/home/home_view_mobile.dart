import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:good_wallet/datamodels/money_pools/base/money_pool.dart';
import 'package:good_wallet/datamodels/user/user.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/image_icon_paths.dart';
import 'package:good_wallet/ui/shared/image_paths.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/shared/money_transfers/money_transfer_style_helpers.dart';
import 'package:good_wallet/ui/shared/money_transfers/transfer_list_tile.dart';
import 'package:good_wallet/ui/views/home/home_viewmodel.dart';
import 'package:good_wallet/ui/widgets/call_to_action_button.dart';
import 'package:good_wallet/ui/widgets/custom_app_bar_small.dart';
import 'package:good_wallet/ui/widgets/money_pool_preview.dart';
import 'package:good_wallet/ui/widgets/section_header.dart';
import 'package:good_wallet/ui/widgets/stats_card.dart';
import 'package:good_wallet/utils/string_utils.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeViewMobile extends StatelessWidget {
  final bool showDialog;
  const HomeViewMobile({Key? key, required this.showDialog}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        onModelReady: (model) async {
          if (model.currentUser.newUser) {
            model.setNewUserPropertyToFalse();
            SchedulerBinding.instance?.addPostFrameCallback((timeStamp) async {
              await model.showFirstLoginDialog();
            });
          }
          model.listenToData();
        },
        builder: (context, model, child) {
          return Scaffold(
            floatingActionButton: Container(
              height: 75,
              width: 75,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, bottom: 12),
                child: FloatingActionButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(90),
                      side: BorderSide(
                          width: 2, color: ColorSettings.primaryColor)),
                  elevation: 15,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.send_rounded,
                      size: 28,
                      color: ColorSettings.primaryColor.withOpacity(1)),
                  onPressed: model.showSendMoneyBottomSheet,
                ),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            body: RefreshIndicator(
              onRefresh: () async => await model.fetchData(),
              child: CustomScrollView(
                key: PageStorageKey('storage-key'),
                physics: ScrollPhysics(),
                slivers: [
                  CustomSliverAppBar(
                    expandedHeight: 100,
                    titleSize: 25,
                    title: "Hi " + getFirstName(model.currentUser.fullName),
                    // onSecondRightIconPressed: model.navigateToProfileViewMobile,
                    // secondRightIcon: Icon(
                    //   Icons.person,
                    //   color: ColorSettings.pageTitleColor,
                    //   size: 28,
                    // ),
                    onRightIconPressed: model.navigateToNotificationsView,
                    rightIcon: Icon(Icons.notifications_none_rounded,
                        color: ColorSettings.pageTitleColor, size: 28),
                  ),
                  model.isBusy
                      ? SliverToBoxAdapter(
                          child: SizedBox(
                              height: 500,
                              child:
                                  Center(child: CircularProgressIndicator())))
                      : SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              verticalSpaceSmall,
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: LayoutSettings.horizontalPadding,
                                  right: LayoutSettings.horizontalPadding,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: StatsCard(
                                          statistic:
                                              model.userStats.currentBalance,
                                          subtitle: "Your Balance",
                                          buttonText: "Pledge",
                                          onCardPressed:
                                              model.showRaisedFundsStatsDialog,
                                          onButtonPressed: model
                                              .showHomeViewMoreBottomSheet),
                                    ),
                                    horizontalSpaceRegular,
                                    Expanded(
                                      child: StatsCard(
                                        statistic: model.userStats
                                            .donationStatistics.totalDonations,
                                        subtitle: "Total Donations",
                                        onCardPressed:
                                            model.showDonationStatsDialog,
                                        onButtonPressed:
                                            model.showDonationBottomSheet,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              verticalSpaceRegular,
                              SectionHeader(
                                title: "Impact Pools",
                                onTextButtonTap: model.navigateToMoneyPoolsView,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // MoneyPoolAvailableFundCard(
                                  //   currentFunds: 0.0,
                                  //   onTopUpPressed:
                                  //       model.navigateToTransferFundAmountView,
                                  // ),
                                  if (model.moneyPoolsInvitedTo.length > 0)
                                    showInviteNotification(context, model),
                                  if (model.moneyPoolsInvitedTo.length > 0)
                                    verticalSpaceSmall,
                                  if (model.moneyPools.length > 0)
                                    Container(
                                      height: 260,
                                      child: MoneyPoolsList(
                                          moneyPools: model.moneyPools,
                                          onMoneyPoolPressed: model
                                              .navigateToSingleMoneyPoolView,
                                          onCreateNewPressed: model
                                              .navigateToCreateMoneyPoolView),
                                    ),
                                  if (model.moneyPools.length == 0)
                                    LargeButton(
                                        imageUrl:
                                            ImagePath.profileBackgroundURL,
                                        title: "Create An Impact Pool",
                                        onPressed: model
                                            .navigateToCreateMoneyPoolView),

                                  verticalSpaceSmall,
                                ],
                              ),
                              if (model.latestTransfers.length > 0)
                                SectionHeader(
                                    title: "Recent Activities",
                                    onTextButtonTap:
                                        model.navigateToTransfersHistoryView),
                              if (model.latestTransfers.length > 0)
                                verticalSpaceTiny,
                              if (model.latestTransfers.length > 0)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal:
                                          LayoutSettings.horizontalPadding +
                                              5.0),
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border:
                                          Border.all(color: Colors.grey[400]!),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 5.0),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: ScrollPhysics(),
                                        itemCount:
                                            model.latestTransfers.length > 3
                                                ? 3
                                                : model.latestTransfers.length,
                                        itemBuilder: (context, index) {
                                          var data =
                                              model.latestTransfers[index];
                                          return TransferListTile(
                                            onTap: () => model
                                                .showMoneyTransferInfoDialog(
                                                    data),
                                            dense: true,
                                            showBottomDivider: index < 2 &&
                                                model.latestTransfers.length >
                                                    2,
                                            showTopDivider: false,
                                            transaction: data,
                                            style:
                                                getTransactionsCorrespondingToTypeHistoryEntryStyle(
                                                    data: data,
                                                    type: data.type,
                                                    uid: model.currentUser.uid),
                                            amount: data.transferDetails.amount,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              verticalSpaceRegular,
                              SectionHeader(
                                title: "Friends",
                                onTextButtonTap: model.navigateToFriendsView,
                              ),
                              verticalSpaceTiny,
                              if (model.friends.length == 0)
                                LargeButton(
                                  onPressed: model.navigateToFindFriendsView,
                                  title: "Add Your First Friend",
                                  backgroundColor: MyColors.niceLightRed,
                                  imagePath: ImagePath.peopleHoldingHands,
                                ),
                              if (model.friends.length > 0)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal:
                                          LayoutSettings.horizontalPadding),
                                  child: Container(
                                    height: 100,
                                    width: screenWidth(context) * 0.8,
                                    child: FriendsList(
                                        friends: model.friends,
                                        onPressed:
                                            model.navigateToPublicProfileView,
                                        onAddFriendPressed:
                                            model.navigateToFindFriendsView),
                                  ),
                                ),
                              // _sendMoneyButton(context, model),
                              verticalSpaceSmall,

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
              text: "Gift",
              onPressed: model.showSendMoneyBottomSheet,
              color: ColorSettings.primaryColorDark.withOpacity(0.7),
              icon:
                  Icon(Icons.send_rounded, color: ColorSettings.whiteTextColor),
            ),
            CallToActionButtonRound(
              text: "Commit",
              onPressed: model.navigateToCommitMoneyView,
              color: ColorSettings.primaryColorDark.withOpacity(0.7),
              icon: Image.asset(ImageIconPaths.agreeingHands,
                  color: ColorSettings.whiteTextColor),
            ),
            CallToActionButtonRound(
              text: "Donate",
              onPressed: model.showDonationBottomSheet,
              color: ColorSettings.primaryColorDark.withOpacity(0.7),
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
          minHeight: 35,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(0.0),
              elevation: 0.0,
              primary: ColorSettings.primaryColor.withOpacity(0.8)),
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
                    "Gift Money",
                    style: textTheme(context).headline5!.copyWith(
                        fontSize: 16, color: ColorSettings.whiteTextColor),
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

  Widget showInviteNotification(BuildContext context, dynamic model) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: model.moneyPoolsInvitedTo.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async => await model.showInvitationBottomSheet(index),
          child: Padding(
            padding: const EdgeInsets.only(
                left: LayoutSettings.horizontalPadding,
                right: LayoutSettings.horizontalPadding),
            child: Stack(
              children: [
                Center(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    color: MyColors.paletteBlue.withOpacity(0.8),
                    elevation: 4.0,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width:
                                screenWidthPercentage(context, percentage: 0.7),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("You've been invited!",
                                    style: textTheme(context)
                                        .headline1!
                                        .copyWith(fontSize: 18)),
                                verticalSpaceTiny,
                                Text(
                                    "${model.moneyPoolsInvitedTo[index].adminName} invited you to join '${model.moneyPoolsInvitedTo[index].name}'",
                                    style: textTheme(context)
                                        .headline1!
                                        .copyWith(fontSize: 15)),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios,
                              color: ColorSettings.whiteTextColor, size: 20),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Stack(children: [
                    Icon(Icons.circle,
                        size: 22, color: ColorSettings.primaryColor),
                    Text(
                      "  1",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: ColorSettings.whiteTextColor),
                    ),
                  ]),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class LargeButton extends StatelessWidget {
  final void Function() onPressed;
  final String title;
  final String? imageUrl;
  final String? imagePath;
  final Color backgroundColor;
  const LargeButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.backgroundColor = MyColors.niceOrange,
    this.imageUrl,
    this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: LayoutSettings.horizontalPadding),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: backgroundColor,
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                color: Colors.black12,
                spreadRadius: 1,
                offset: Offset(1, 2),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (imageUrl != null)
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: FadeInImage.memoryNetwork(
                        fadeInDuration: Duration(milliseconds: 200),
                        placeholder: kTransparentImage,
                        image: imageUrl!,
                        fit: BoxFit.fitHeight),
                  ),
                ),
              if (imagePath != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: AssetImage(
                          imagePath!,
                        ),
                      ),
                    ),
                  ),
                ),
              Text(
                title,
                style: textTheme(context)
                    .headline5!
                    .copyWith(fontSize: 18, color: Colors.white),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

class MoneyPoolsList extends StatelessWidget {
  final List<MoneyPool> moneyPools;
  final void Function(MoneyPool) onMoneyPoolPressed;
  final void Function() onCreateNewPressed;
  MoneyPoolsList({
    Key? key,
    required this.moneyPools,
    required this.onMoneyPoolPressed,
    required this.onCreateNewPressed,
  }) : super(key: key);

  List<String> images = [
    ImagePath.fourPeopleLaughing,
    ImagePath.threePeopleAtTable,
    ImagePath.twoPeopleOnCouch,
  ];

  Random random = new Random();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: ScrollPhysics(),
        itemCount: moneyPools.length + 1,
        itemBuilder: (context, index) {
          double width = (screenWidthWithoutPadding(context) - 25) / 2 - 15;
          if (index >= moneyPools.length) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MoneyPoolPreview(
                  imagePath: images[random.nextInt(3)],
                  height: 240,
                  width: width,
                  squaredLayout: true,
                  showCreateNew: true,
                  moneyPool: moneyPools[0],
                  onTap: onMoneyPoolPressed,
                  onCreateMoneyPoolTapped: onCreateNewPressed,
                ),
                horizontalSpaceMedium,
              ],
            );
          } else {
            //int indexReal = index - 1;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (index == 0) horizontalSpaceMedium,
                MoneyPoolPreview(
                  imagePath: images[random.nextInt(3)],
                  height: 240,
                  width: width,
                  moneyPool: moneyPools[index],
                  squaredLayout: true,
                  onTap: onMoneyPoolPressed,
                  onCreateMoneyPoolTapped: onCreateNewPressed,
                ),
                horizontalSpaceMedium,
              ],
            );
          }
        });
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

class FriendsList extends StatelessWidget {
  final List<User> friends;
  final void Function(String) onPressed;
  final void Function() onAddFriendPressed;

  const FriendsList({
    Key? key,
    required this.friends,
    required this.onPressed,
    required this.onAddFriendPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: min(friends.length + 1, 10),
      itemBuilder: (context, index) {
        if (index == min(friends.length, 9)) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              horizontalSpaceSmall,
              AddFriendCTARound(onPressed: onAddFriendPressed),
            ],
          );
        } else {
          return Row(
            children: [
              horizontalSpaceSmall,
              CallToActionButtonRoundInitials(
                  color: MyColors.niceColors[index % 4],
                  onPressed: () => onPressed(friends[index].uid),
                  name: friends[index].fullName),
            ],
          );
        }
      },
    );
  }
}
