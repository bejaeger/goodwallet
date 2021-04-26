import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/money_pools/money_pool_model.dart';
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
import 'package:stacked/stacked.dart';

class SingleMoneyPoolView extends StatelessWidget {
  final MoneyPoolModel moneyPool;
  const SingleMoneyPoolView({Key? key, required this.moneyPool})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SingleMoneyPoolViewModel>.reactive(
      viewModelBuilder: () => SingleMoneyPoolViewModel(),
      onModelReady: (model) async {
        model.setMoneyPool(moneyPool);
        model.fetchUserContributions();
      },
      builder: (context, model, child) => ConstrainedWidthWithScaffoldLayout(
        child: ListView(
          physics: ScrollPhysics(),
          children: <Widget>[
            AlternativeScreenHeaderImage(
              // TODO: Add picture if it's added by the user!
              backgroundWidget: Container(
                color: MyColors.paletteTurquoise.withOpacity(0.9),
              ),
              imageHeight: 220,
              title: moneyPool.name!,
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
                      onPressed: () async =>
                          await model.deleteMoneyPool(moneyPool.moneyPoolId!),
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
              child: Text("Money pool started by ${moneyPool.adminName}"),
            ),
            verticalSpaceMedium,
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: LayoutSettings.horizontalPadding),
              child: Column(
                children: [
                  HorizontalCentralButton(
                    onPressed: model.showNotImplementedSnackbar,
                    title: "Contribute",
                    minWidth: screenWidthPercentage(context, percentage: 0.6),
                  ),
                  verticalSpaceRegular,
                  Text(moneyPool.total.toString(),
                      style: textTheme(context).headline2),
                  Text("Current amount")
                ],
              ),
            ),
            verticalSpaceLarge,
            SectionHeader(
              title: "Members",
              trailingIcon: IconButton(
                onPressed: () => model.showSearchViewAndInviteUser(moneyPool),
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
                    itemCount: model.invitedUsers.length +
                        model.contributingUsers.length,
                    itemBuilder: (context, index) {
                      bool isInvitedUser =
                          index >= model.invitedUsers.length ? false : true;
                      dynamic user = isInvitedUser
                          ? model.invitedUsers[index]
                          : model.contributingUsers[
                              index - model.invitedUsers.length];
                      var displayName =
                          user.uid == model.currentUser.id ? "You" : user.name;
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundColor: MyColors.paletteBlue,
                          child: Text(getInitialsFromName(user.name),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14)),
                        ),
                        title: Text(
                          displayName,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                        trailing: isInvitedUser
                            ? Text("Pending invitation")
                            : Text(formatAmount(user.contribution)),
                      );
                    },
                  ),
            verticalSpaceLarge,
          ],
        ),
      ),
    );
  }
}
