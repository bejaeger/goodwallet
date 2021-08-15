import 'package:flutter/material.dart';
import 'package:good_wallet/constants/constants.dart';
import 'package:good_wallet/datamodels/money_pools/base/money_pool.dart';
import 'package:good_wallet/datamodels/money_pools/messages/message.dart';
import 'package:good_wallet/datamodels/money_pools/payouts/money_pool_payout.dart';
import 'package:good_wallet/datamodels/money_pools/users/contributing_user.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
import 'package:good_wallet/datamodels/user/public_user_info.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/custom_shape.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/money_pools/single_money_pool_view.form.dart';
import 'package:good_wallet/ui/views/money_pools/single_money_pool_viewmodel.dart';
import 'package:good_wallet/ui/widgets/money_pool_sliver_app_bar.dart';
import 'package:good_wallet/ui/widgets/horizontal_central_button.dart';
import 'package:good_wallet/ui/widgets/search_text_field.dart';
import 'package:good_wallet/ui/widgets/section_header.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:good_wallet/utils/string_utils.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'dart:math' as math; // import this

@FormView(fields: [
  FormTextField(name: 'message'),
])
class SingleMoneyPoolView extends StatelessWidget with $SingleMoneyPoolView {
  final MoneyPool moneyPool;

  SingleMoneyPoolView({Key? key, required this.moneyPool}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SingleMoneyPoolViewModel>.reactive(
        viewModelBuilder: () => SingleMoneyPoolViewModel(moneyPool: moneyPool),
        onModelReady: (model) async {
          listenToFormUpdated(model);
          model.listenToData();
        },
        builder: (context, model, child) {
          return ConstrainedWidthWithScaffoldLayout(
            resizeToAvoidBottomInset: true,
            child: RefreshIndicator(
              onRefresh: () async => await model.refresh(),
              child: CustomScrollView(
                //key: PageStorageKey('storage-key'),
                physics: ScrollPhysics(),
                slivers: [
                  MoneyPoolSliverAppBar(
                    title: model.moneyPool.name,
                    amount: model.moneyPool.total,
                    adminName: model.moneyPool.adminName,
                    nMembers: model.moneyPool.contributingUsers.length,
                    description: model.moneyPool.description,
                    onDeleteMoneyPool: () =>
                        model.deleteMoneyPool(model.moneyPool.moneyPoolId),
                    onInviteMemberPressed: model.showSearchViewAndInviteUser,
                    onMembersPressed: model.navigateToAllMembersView,
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: LayoutSettings.horizontalPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left:
                                        1.5 * LayoutSettings.horizontalPadding,
                                    right: LayoutSettings.horizontalPadding),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Name & description from " +
                                          moneyPool.adminName,
                                      textAlign: TextAlign.center,
                                      style: textTheme(context)
                                          .bodyText2!
                                          .copyWith(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      model.moneyPool.name,
                                      style: textTheme(context)
                                          .headline4!
                                          .copyWith(fontSize: 30),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              if (model.moneyPool.description != null &&
                                  model.moneyPool.description != "")
                                Container(
                                  decoration: BoxDecoration(
                                    // color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  padding: const EdgeInsets.only(
                                      top: 5.0,
                                      left: 1.5 *
                                          LayoutSettings.horizontalPadding,
                                      right: LayoutSettings.horizontalPadding),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Text(
                                      //   "DESCRIPTION",
                                      //   style: textTheme(context)
                                      //       .bodyText2!
                                      //       .copyWith(
                                      //           fontSize: 12,
                                      //           fontWeight: FontWeight.w600),
                                      // ),
                                      Text(
                                        "" + model.moneyPool.description! + "",
                                        textAlign: TextAlign.center,
                                        style: textTheme(context)
                                            .bodyText2!
                                            .copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: ColorSettings
                                                  .blackHeadlineColor,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              if (model.moneyPool.description != null)
                                verticalSpaceLarge,
                              Align(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    HorizontalCentralButton(
                                      color: ColorSettings.primaryColor
                                          .withOpacity(0.8),
                                      onPressed: () => model
                                          .navigateToTransferFundAmountView(
                                              model.moneyPool),
                                      title: "Contribute",
                                      minWidth: screenWidthPercentage(context,
                                          percentage: 0.6),
                                    ),

                                    verticalSpaceSmall,
                                    if (model.moneyPool.adminUID ==
                                        model.currentUser.uid)
                                      HorizontalCentralButton(
                                        color: MyColors.paletteBlue
                                            .withOpacity(0.8),
                                        onPressed: () => model
                                            .navigateToDisburseMoneyPoolView(),
                                        title: "Disburse",
                                        minWidth: screenWidthPercentage(context,
                                            percentage: 0.6),
                                      ),
                                    if (model.moneyPool.adminUID ==
                                        model.currentUser.uid)
                                      verticalSpaceMedium,
                                    if (model.moneyPool.adminUID !=
                                        model.currentUser.uid)
                                      verticalSpaceRegular,

                                    // Text(formatAmount(model.moneyPool.total),
                                    //     style: textTheme(context).headline2),
                                    // Text("Current total")
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // if (model.moneyPool.invitedUsers.length > 0)
                        //   SectionHeader(
                        //     title: "Invited Users",
                        //     trailingIcon: IconButton(
                        //       onPressed: () =>
                        //           model.showSearchViewAndInviteUser(),
                        //       icon: Icon(Icons.person_add,
                        //           size: 26,
                        //           color: ColorSettings.blackHeadlineColor),
                        //     ),
                        //   ),
                        // if (model.moneyPool.invitedUsers.length > 0)
                        //   InvitedUsersList(
                        //     invitedUsers: model.moneyPool.invitedUsers,
                        //   ),
                        // verticalSpaceRegular,
                        model.isBusy
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  verticalSpaceRegular,
                                  CircularProgressIndicator(),
                                ],
                              )
                            : Column(children: [
                                verticalSpaceMedium,
                                SectionHeader(
                                  title: "Latest Acitivities",
                                ),
                                verticalSpaceRegular,
                                GreySearchTextField(
                                  controller: messageController,
                                  focusNode: messageFocusNode,
                                  hintText: "Leave a note",
                                  suffixIcon: Icon(Icons.send,
                                      size: 24, color: Colors.grey[800]),
                                  onSuffixIconPressed: () async {
                                    await model.addMessageToMoneyPool();
                                    messageController.clear();
                                    messageFocusNode.unfocus();
                                  },
                                  showPrefixIcon: false,
                                ),
                                verticalSpaceSmall,
                                // verticalSpaceLarge,
                              ]),
                      ],
                    ),
                  ),
                  if (model.activities.length > 0 && !model.isBusy)
                    ActivitiesList(
                      activities: model.activities,
                      onMessagePressed: model.showMoneyPoolMessageDetailsDialog,
                      onMoneyPoolPayoutPressed:
                          model.showMoneyPoolPayoutDetailsDialog,
                      onMoneyPoolContributionPressed:
                          model.showMoneyTransferInfoDialog,
                      currentUserId: model.currentUser.uid,
                    ),
                  SliverToBoxAdapter(child: SizedBox(height: 100)),
                ],
              ),
            ),
          );
        });
  }
}

class InvitedUsersList extends StatelessWidget {
  final List<PublicUserInfo> invitedUsers;
  const InvitedUsersList({Key? key, required this.invitedUsers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: LayoutSettings.horizontalPadding),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[400]!),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
          child: ListView.builder(
            itemCount: invitedUsers.length,
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              bool isInvitedUser = index >= invitedUsers.length ? false : true;
              dynamic user = invitedUsers[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: MyColors.paletteBlue,
                      child: Text(getInitialsFromName(user.name),
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                    ),
                    title: Text(
                      user.name,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    trailing: Text("Pending invitation")),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ActivitiesList extends StatelessWidget {
  final String currentUserId;
  final List<dynamic> activities;
  final void Function(Message) onMessagePressed;
  final void Function(MoneyPoolPayout) onMoneyPoolPayoutPressed;
  final void Function(MoneyPoolContribution) onMoneyPoolContributionPressed;

  const ActivitiesList(
      {Key? key,
      required this.activities,
      required this.onMessagePressed,
      required this.onMoneyPoolPayoutPressed,
      required this.onMoneyPoolContributionPressed,
      required this.currentUserId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      //physics: ScrollPhysics(),
      //shrinkWrap: true,
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          var activity = activities[index];
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: LayoutSettings.horizontalPadding * 0.7),
            child: ActivityWidget(
              activity: activity,
              onMessagePressed: onMessagePressed,
              onMoneyPoolPayoutPressed: onMoneyPoolPayoutPressed,
              onMoneyPoolContributionPressed: onMoneyPoolContributionPressed,
              currentUserId: currentUserId,
            ),
          );
        },
        childCount: activities.length,
      ),
    );
  }
}

class ActivityWidget extends StatelessWidget {
  final String currentUserId;
  final dynamic activity;
  final void Function(Message) onMessagePressed;
  final void Function(MoneyPoolPayout) onMoneyPoolPayoutPressed;
  final void Function(MoneyPoolContribution) onMoneyPoolContributionPressed;

  const ActivityWidget(
      {Key? key,
      required this.activity,
      required this.onMessagePressed,
      required this.onMoneyPoolPayoutPressed,
      required this.onMoneyPoolContributionPressed,
      required this.currentUserId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (_) {
      int messageCount = 0;

      if (activity is Message) {
        messageCount += 1;
        if (messageCount == kNumberOfMessagesLimit) {
          return SizedBox(
            width: screenWidth(context, percentage: 0.7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                verticalSpaceRegular,
                Text(
                    "Note, number of messages that are displayed is limited to 50 in this version of the app. Only showing payments below."),
                verticalSpaceRegular,
              ],
            ),
          );
        }
        return activity.uid == currentUserId
            ? SentMessageNote(
                message: activity, onPressed: () => onMessagePressed(activity))
            : ReceivedMessageNote(
                message: activity, onPressed: () => onMessagePressed(activity));
      } else if (activity is MoneyPoolPayout) {
        return MoneyPoolPayoutNote(
            payout: activity,
            onPressed: () => onMoneyPoolPayoutPressed(activity));
      } else if (activity is MoneyPoolContribution) {
        return ContributionNote(
            contribution: activity,
            onPressed: () => onMoneyPoolContributionPressed(activity));
      } else {
        return Container();
      }
    });
  }
}

class SentMessageNote extends StatelessWidget {
  final Message message;
  final void Function()? onPressed;
  const SentMessageNote({
    Key? key,
    required this.message,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Flexible(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.only(bottom: 14, left: 14, right: 14, top: 10),
            decoration: BoxDecoration(
              color: Colors.cyan[900],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
            ),
            child: Text(
              message.message,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ),
        CustomPaint(painter: CustomShape(Colors.cyan[900]!)),
      ],
    ));

    return Padding(
      padding: EdgeInsets.only(right: 18.0, left: 50, top: 10, bottom: 5),
      child: GestureDetector(
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            messageTextGroup,
          ],
        ),
      ),
    );
  }
}

class ContributionNote extends StatelessWidget {
  final MoneyPoolContribution contribution;
  final void Function()? onPressed;
  const ContributionNote(
      {Key? key, required this.contribution, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title =
        "Contribution from ${contribution.transferDetails.senderName}";
    String amountString = formatAmount(contribution.transferDetails.amount);
    String subtitle = formatDateShort(contribution.createdAt?.toDate());

    return MoneyPoolNote(
      title: title,
      amountString: amountString,
      subtitle: subtitle,
      activity: contribution,
      onPressed: onPressed,
      iconRight: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey[400],
          ),
          CircleAvatar(
            radius: 27.8,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.favorite,
              size: 40,
              color: ColorSettings.primaryColor.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}

class MoneyPoolPayoutNote extends StatelessWidget {
  final MoneyPoolPayout payout;
  final void Function()? onPressed;
  const MoneyPoolPayoutNote(
      {Key? key, required this.payout, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = "Pool paid out to users";
    double amount = 0;
    payout.transfersDetails.forEach((element) {
      amount += element.amount;
    });
    String amountString = formatAmount(amount);
    String subtitle = formatDateShort(payout.createdAt?.toDate());
    return MoneyPoolNote(
      title: title,
      amountString: amountString,
      subtitle: subtitle,
      activity: payout,
      onPressed: onPressed,
      iconLeft: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey[400],
          ),
          CircleAvatar(
            radius: 27.8,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.volunteer_activism,
              size: 40,
              color: ColorSettings.primaryColor.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}

class MoneyPoolNote extends StatelessWidget {
  final String title;
  final String amountString;
  final String? subtitle;
  final dynamic activity;
  final void Function()? onPressed;
  final Widget? iconLeft;
  final Widget? iconRight;

  const MoneyPoolNote(
      {Key? key,
      required this.activity,
      this.onPressed,
      required this.title,
      required this.amountString,
      this.subtitle,
      this.iconLeft,
      this.iconRight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (iconLeft == null)
              ? horizontalSpaceLarge
              : Flexible(
                  flex: 1,
                  child: Column(
                    children: [
                      verticalSpaceTiny,
                      iconLeft!,
                    ],
                  ),
                ),
          if (iconLeft != null) horizontalSpaceTiny,
          Flexible(
            flex: 4,
            child: GestureDetector(
              onTap: onPressed,
              child: Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(width: 1, color: Colors.grey[400]!)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text(title,
                                style: textTheme(context)
                                    .bodyText2!
                                    .copyWith(fontSize: 18)),
                          ),
                          Icon(Icons.arrow_forward_ios,
                              color: ColorSettings.blackTextColor, size: 22),
                        ],
                      ),
                      Text(amountString,
                          style: textTheme(context)
                              .headline4!
                              .copyWith(fontSize: 28)),
                      if (subtitle != null)
                        Text(subtitle!,
                            style: textTheme(context)
                                .bodyText2!
                                .copyWith(fontSize: 14)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (iconRight != null) horizontalSpaceTiny,
          (iconRight == null)
              ? horizontalSpaceLarge
              : Flexible(
                  flex: 1,
                  child: Column(
                    children: [
                      verticalSpaceTiny,
                      iconRight!,
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

class ReceivedMessageNote extends StatelessWidget {
  final Message message;
  final void Function()? onPressed;
  const ReceivedMessageNote({
    Key? key,
    required this.message,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Flexible(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(math.pi),
          child: CustomPaint(
            painter: CustomShape(Colors.grey[300]!),
          ),
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.only(bottom: 14, left: 14, right: 14, top: 10),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(18),
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message.name,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  message.message,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ],
    ));

    return Padding(
      padding: EdgeInsets.only(right: 50.0, left: 18, top: 10, bottom: 5),
      child: GestureDetector(
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            messageTextGroup,
          ],
        ),
      ),
    );
  }
}

class MoneyPoolContributionNote extends StatelessWidget {
  final void Function()? onPressed;
  const MoneyPoolContributionNote({
    Key? key,
    required this.contribution,
    required this.onPressed,
  }) : super(key: key);

  final MoneyTransfer contribution;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: onPressed,
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: MyColors.paletteBlue,
          child: Text(
              getInitialsFromName(contribution.transferDetails.senderName),
              style: TextStyle(color: Colors.white, fontSize: 14)),
        ),
        title: Text(
          contribution.transferDetails.senderName,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          DateFormat.MMMEd().format(contribution.createdAt.toDate()),
          style: textTheme(context).bodyText2!.copyWith(
                fontSize: 15,
              ),
        ),
        trailing: Text(formatAmount(contribution.transferDetails.amount)));
  }
}

/*
class MoneyPoolSliverAppBar extends StatelessWidget {
  final String title;
  final double? titleSize;
  final void Function()? onRightIconPressed;
  final void Function()? onTopLeftButtonPressed;
  final void Function()? onSecondRightIconPressed;
  final Widget? rightIcon;
  final Widget? secondRightIcon;
  final bool pinned;
  final PreferredSize? bottom;

  const MoneyPoolSliverAppBar(
      {Key? key,
      required this.title,
      this.titleSize,
      this.onRightIconPressed,
      this.rightIcon,
      this.pinned = true,
      this.bottom,
      this.onSecondRightIconPressed,
      this.secondRightIcon,
      this.onTopLeftButtonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(
            left: LayoutSettings.horizontalPadding,
            right: 80,
            bottom: 10,
            top: 10),
        title: Text(
          title,
          style: textTheme(context)
              .headline3!
              .copyWith(fontSize: 25, color: ColorSettings.blackHeadlineColor),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: ColorSettings.whiteTextColor,
                  size: 25,
                ),
                onPressed: onTopLeftButtonPressed,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (onRightIconPressed != null)
                    GestureDetector(
                      onTap: onRightIconPressed,
                      child: rightIcon ??
                          Icon(
                            Icons.person,
                            color: ColorSettings.pageTitleColor,
                            size: 25,
                          ),
                    ),
                  if (onSecondRightIconPressed != null) SizedBox(width: 22.0),
                  if (onSecondRightIconPressed != null)
                    GestureDetector(
                      onTap: onSecondRightIconPressed,
                      child: secondRightIcon ??
                          Icon(
                            Icons.person,
                            color: ColorSettings.pageTitleColor,
                            size: 25,
                          ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
      titleSpacing: 20,
      expandedHeight: LayoutSettings.minAppBarHeight * 1.7,
      collapsedHeight: LayoutSettings.minAppBarHeight,
      backgroundColor: ColorSettings.backgroundColor,
      elevation: 2.0,
      toolbarHeight: LayoutSettings.minAppBarHeight,
      pinned: pinned,
      bottom: bottom,
    );
  }
}

*/
