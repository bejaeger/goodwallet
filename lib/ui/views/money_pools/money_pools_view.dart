import 'dart:math';

import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/money_pools/base/money_pool.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/money_pools/money_pools_viewmodel.dart';
import 'package:good_wallet/ui/widgets/call_to_action_button.dart';
import 'package:good_wallet/ui/widgets/custom_app_bar_small.dart';
import 'package:good_wallet/ui/widgets/money_pool_preview.dart';
import 'package:good_wallet/ui/widgets/section_header.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'package:stacked/stacked.dart';

class MoneyPoolsView extends StatelessWidget {
  final bool forceReload;
  const MoneyPoolsView({Key? key, this.forceReload = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MoneyPoolsViewModel>.reactive(
      viewModelBuilder: () => MoneyPoolsViewModel(),
      onModelReady: (model) => model.listenToAndFetchData(),
      builder: (context, model, child) => ConstrainedWidthWithScaffoldLayout(
        child: RefreshIndicator(
          onRefresh: () async => await model.refresh(),
          child: CustomScrollView(
            key: PageStorageKey('storage-key'),
            physics: AlwaysScrollableScrollPhysics(),
            slivers: [
              CustomSliverAppBarSmall(
                forceElevated: false,
                title: "Your Community",
                onSecondRightIconPressed: model.navigateToProfileView,
                secondRightIcon: Icon(
                  Icons.person,
                  color: ColorSettings.pageTitleColor,
                  size: 28,
                ),
                onRightIconPressed: model.showInformationDialog,
                rightIcon: Icon(Icons.help_outline,
                    color: ColorSettings.pageTitleColor, size: 28),
              ),
              model.isBusy
                  ? SliverToBoxAdapter(
                      child: Center(
                          child: Column(
                      children: [
                        verticalSpaceMedium,
                        CircularProgressIndicator(),
                      ],
                    )))
                  : SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          verticalSpaceSmall,
                          SectionHeader(
                            title: "Your Friends",
                            textButtonText: "See all",
                            onTextButtonTap: model.navigateToFriendsView,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: LayoutSettings.horizontalPadding),
                            child: Container(
                              height: 100,
                              width: screenWidth(context) * 0.8,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: min(model.friends.length + 1, 10),
                                itemBuilder: (context, index) {
                                  if (index >= min(model.friends.length, 9)) {
                                    return Row(
                                      children: [
                                        horizontalSpaceSmall,
                                        AddFriendCTARound(
                                            onPressed: model
                                                .navigateToFindFriendsView),
                                      ],
                                    );
                                  } else {
                                    return Row(
                                      children: [
                                        horizontalSpaceSmall,
                                        CallToActionButtonRoundInitials(
                                            color: MyColors.paletteBlue
                                                .withOpacity(0.9),
                                            onPressed: () => model
                                                .navigateToPublicProfileView(
                                                    model.friends[index].uid),
                                            name:
                                                model.friends[index].fullName),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                          verticalSpaceRegular,
                          SectionHeader(
                            title: "Your Community's Impact",
                          ),
                          verticalSpaceRegular,
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: LayoutSettings.horizontalPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LinearPercentIndicator(
                                  width: screenWidth(context, percentage: 0.7),
                                  lineHeight: 25.0,
                                  animation: true,
                                  animationDuration: 1000,
                                  // leading: Padding(
                                  //   padding: const EdgeInsets.only(right: 8.0),
                                  //   child: Text("\$0"),
                                  // ),
                                  trailing: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text("\$1000"),
                                  ),
                                  percent: 0.7,
                                  center: Text("\$700",
                                      style: textTheme(context)
                                          .bodyText1!
                                          .copyWith(
                                              color: MyColors.almostWhite)),
                                  linearStrokeCap: LinearStrokeCap.roundAll,
                                  progressColor:
                                      MyColors.paletteGreen.withOpacity(0.7),
                                ),
                                Text(
                                    "Total donations of all your friends combined!"),
                              ],
                            ),
                          ),
                          verticalSpaceMedium,
                          SectionHeader(
                            title: "Your Impact Pools",
                            textButtonText: "Create new",
                            onTextButtonTap:
                                model.navigateToCreateMoneyPoolView,
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
                                verticalSpaceRegular,
                              if (model.moneyPoolsInvitedTo.length > 0)
                                showInviteNotification(context, model),
                              // verticalSpaceSmall,
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        LayoutSettings.horizontalPadding),
                                child: ListView.builder(
                                    physics: ScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: model.moneyPools.length,
                                    itemBuilder: (context, index) => Column(
                                          children: [
                                            SizedBox(
                                              height: 160,
                                              child: MoneyPoolPreview(
                                                moneyPool:
                                                    model.moneyPools[index],
                                                onTap: (MoneyPool pool) => model
                                                    .navigateToSingleMoneyPoolView(
                                                        pool),
                                                onCreateMoneyPoolTapped: model
                                                    .navigateToCreateMoneyPoolView,
                                              ),
                                            ),
                                            verticalSpaceSmall
                                          ],
                                        )),
                              ),
                            ],
                          ),
                          verticalSpaceLarge,
                        ],
                      ),
                    ),
            ],
          ),
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
                        size: 22, color: ColorSettings.primaryColorLight),
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

class MoneyPoolAvailableFundCard extends StatelessWidget {
  final num currentFunds;
  final void Function()? onTopUpPressed;

  const MoneyPoolAvailableFundCard({
    Key? key,
    required this.currentFunds,
    required this.onTopUpPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: LayoutSettings.horizontalPadding),
      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        color: Colors.white,
        child: Container(
          width: screenWidthWithoutPadding(context) - 8.0,
          height: 135,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 8.0, left: 20.0, right: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Prepaid Funds",
                            style: textTheme(context).bodyText2!.copyWith(
                                  fontSize: 18,
                                ),
                          ),
                          verticalSpaceTiny,
                          Text(
                            formatAmount(currentFunds),
                            maxLines: 1,
                            style: textTheme(context).headline2!.copyWith(
                                  fontSize: 32,
                                ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Flexible(
                                child: Text(
                                  "Use to transfer without fees to money pools or Good Wallets",
                                  style: textTheme(context).bodyText2!.copyWith(
                                        fontSize: 14,
                                      ),
                                ),
                              ),
                              //Icon(Icons.help_outline_rounded, size: 14),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CallToActionIcon(
                      text: "Top Up",
                      showText: true,
                      onPressed: onTopUpPressed,
                      textColor: ColorSettings.blackHeadlineColor,
                      backgroundColor:
                          ColorSettings.whiteTextColor!.withOpacity(0.3),
                      icon: Icon(Icons.arrow_upward_rounded),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
