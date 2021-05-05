import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/money_pools/base/money_pool.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/money_pools/single_money_pool_viewmodel.dart';
import 'package:good_wallet/ui/widgets/alternative_screen_header_image.dart';
import 'package:good_wallet/ui/widgets/horizontal_central_button.dart';
import 'package:good_wallet/ui/widgets/section_header.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:good_wallet/utils/datamodel_helpers.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class SingleMoneyPoolView extends StatelessWidget {
  final MoneyPool moneyPool;
  const SingleMoneyPoolView({Key? key, required this.moneyPool})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SingleMoneyPoolViewModel>.reactive(
      viewModelBuilder: () => SingleMoneyPoolViewModel(moneyPool: moneyPool),
      onModelReady: (model) async {
        await model.fetchUserContributions();
        await model.fetchPayouts();
      },
      builder: (context, model, child) => ConstrainedWidthWithScaffoldLayout(
        child: RefreshIndicator(
          onRefresh: () async => await model.updateMoneyPool(),
          child: ListView(
            key: PageStorageKey('storage-key'),
            physics: AlwaysScrollableScrollPhysics(),
            children: <Widget>[
              AlternativeScreenHeaderImage(
                // TODO: Add picture if it's added by the user!
                backgroundWidget: Container(
                  color: MyColors.paletteTurquoise.withOpacity(0.9),
                ),
                imageHeight: 200,
                title: model.moneyPool.name,
                onTopLeftButtonPressed: model.navigateBack,
                topLeftWidget: Icon(Icons.close_rounded,
                    size: 28, color: ColorSettings.whiteTextColor),
                topRightWidget: PopupMenuButton(
                  icon: Icon(
                    Icons.menu,
                    size: 28,
                    color: ColorSettings.whiteTextColor,
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: TextButton(
                          onPressed: model.showNotImplementedSnackbar,
                          child: Text("Share")),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: TextButton(
                        onPressed: () async => await model
                            .deleteMoneyPool(model.moneyPool.moneyPoolId),
                        child: Text("Delete"),
                      ),
                    ),
                  ],
                ),
                bottomRightWidget: IconButton(
                  color: ColorSettings.whiteTextColor,
                  icon: Icon(Icons.add_a_photo_outlined, size: 20.0),
                  onPressed: model.showNotImplementedSnackbar,
                ),
              ),
              verticalSpaceSmall,
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: LayoutSettings.horizontalPadding),
                child:
                    Text("Money pool started by ${model.moneyPool.adminName}"),
              ),
              verticalSpaceMedium,
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: LayoutSettings.horizontalPadding),
                child: Column(
                  children: [
                    HorizontalCentralButton(
                      onPressed: () => model
                          .navigateToTransferFundAmountView(model.moneyPool),
                      title: "Contribute",
                      minWidth: screenWidthPercentage(context, percentage: 0.6),
                    ),
                    verticalSpaceSmall,
                    if (model.moneyPool.adminUID == model.currentUser.id)
                      HorizontalCentralButton(
                        color: MyColors.paletteBlue.withOpacity(0.9),
                        onPressed: () =>
                            model.navigateToDisburseMoneyPoolView(),
                        title: "Disburse",
                        minWidth:
                            screenWidthPercentage(context, percentage: 0.6),
                      ),
                    if (model.moneyPool.adminUID == model.currentUser.id)
                      verticalSpaceRegular,
                    Text(formatAmount(model.moneyPool.total),
                        style: textTheme(context).headline2),
                    Text("Current total")
                  ],
                ),
              ),
              verticalSpaceMedium,
              SectionHeader(
                title: "Members",
                trailingIcon: IconButton(
                  onPressed: () => model.showSearchViewAndInviteUser(),
                  icon: Icon(
                    Icons.add_circle_outline_rounded,
                  ),
                ),
              ),
              model.isBusy
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: model.moneyPool.invitedUsers.length +
                          model.moneyPool.contributingUsers.length,
                      itemBuilder: (context, index) {
                        bool isInvitedUser =
                            index >= model.moneyPool.invitedUsers.length
                                ? false
                                : true;
                        dynamic user = isInvitedUser
                            ? model.moneyPool.invitedUsers[index]
                            : model.moneyPool.contributingUsers[
                                index - model.moneyPool.invitedUsers.length];
                        var displayName = user.uid == model.currentUser.id
                            ? "You"
                            : user.name;
                        return ListTile(
                          leading: CircleAvatar(
                            radius: 20,
                            backgroundColor: MyColors.paletteBlue,
                            child: Text(getInitialsFromName(user.name),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14)),
                          ),
                          title: Text(
                            displayName,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          subtitle:
                              model.moneyPool.adminUID == model.currentUser.id
                                  ? Text("Admin")
                                  : null,
                          trailing: isInvitedUser
                              ? Text("Pending invitation")
                              : Text(formatAmount(user.contribution)),
                        );
                      },
                    ),
              verticalSpaceRegular,
              if (model.payouts.length > 0)
                SectionHeader(
                  title: "Payouts",
                ),
              if (model.payouts.length > 0) verticalSpaceSmall,
              if (model.payouts.length > 0)
                ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: model.payouts.length,
                  itemBuilder: (context, index) {
                    var payout = model.payouts[index];
                    return Container(
                      color: MyColors.paletteGreen.withOpacity(0.3),
                      child: ListTile(
                          leading: CircleAvatar(
                            radius: 20,
                            backgroundColor: MyColors.paletteGreen,
                            child: Text("P",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14)),
                          ),
                          title: Text(
                            "Paid out money pool",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            "DATE",
                            style: textTheme(context).bodyText2!.copyWith(
                                  fontSize: 15,
                                ),
                          ),
                          trailing: Text("Details")),
                    );
                  },
                ),
              if (model.payouts.length > 0) verticalSpaceRegular,
              if (model.contributions.length > 0)
                SectionHeader(
                  title: "Contributions",
                ),
              if (model.contributions.length > 0)
                ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: model.contributions.length,
                  itemBuilder: (context, index) {
                    var contribution = model.contributions[index];
                    return ListTile(
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundColor: MyColors.paletteBlue,
                          child: Text(
                              getInitialsFromName(
                                  contribution.transactionDetails.senderName),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14)),
                        ),
                        title: Text(
                          contribution.transactionDetails.senderName,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          DateFormat.MMMEd()
                              .format(contribution.createdAt.toDate()),
                          style: textTheme(context).bodyText2!.copyWith(
                                fontSize: 15,
                              ),
                        ),
                        trailing: Text(formatAmount(
                            contribution.transactionDetails.amount)));
                  },
                ),
              verticalSpaceLarge,
            ],
          ),
        ),
      ),
    );
  }
}
