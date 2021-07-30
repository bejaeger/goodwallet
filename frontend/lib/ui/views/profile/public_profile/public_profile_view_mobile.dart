import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/user/statistics/user_statistics.dart';
import 'package:good_wallet/datamodels/user/user.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/image_paths.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/profile/public_profile/public_profile_viewmodel.dart';
import 'package:good_wallet/ui/widgets/call_to_action_button.dart';
import 'package:good_wallet/ui/widgets/custom_app_bar_small.dart';
import 'package:good_wallet/ui/widgets/good_wallet_card.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:good_wallet/utils/string_utils.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class PublicProfileViewMobile extends StatelessWidget {
  final String uid;

  const PublicProfileViewMobile({Key? key, required this.uid})
      : super(key: key);

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      width: screenSize.width,
      height: screenSize.height / 3,
      child: Image.network(
        ImagePath.profileBackgroundURL,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildProfileImage(String name) {
    return Center(
      child: Container(
        width: 90.0,
        height: 90.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(90.0),
          child: CircleAvatar(
            radius: 24,
            backgroundColor: MyColors.paletteBlue,
            child: Text(getInitialsFromName(name),
                style: TextStyle(color: Colors.white, fontSize: 26)),
          ),
          //  Image.network(
          //   ImagePath.profilePicURL,
          //   fit: BoxFit.cover,
          // ),
        ),
      ),
    );
  }

  Widget _buildFullName(BuildContext context, User user) {
    return Text(
      user.fullName,
      style: textTheme(context).headline4,
    );
  }

  Widget _buildStatus(BuildContext context) {
    return Text(
      "Member since 7/21",
    );
  }

  Widget _buildStatItem(
      BuildContext context, String label, String count, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          count,
          style: textTheme(context).bodyText2!.copyWith(
              fontWeight: FontWeight.bold, fontSize: 18, color: color),
        ),
        Text(
          label,
          style: textTheme(context).bodyText2!.copyWith(color: color),
        ),
      ],
    );
  }

  Widget _buildStatContainer(BuildContext context, UserStatistics userStats) {
    return Container(
      height: 60.0,
      margin: EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          //stops: [0.0, 0.5, 1.0],
          colors: [
            MyColors.lightRed.withOpacity(0.15),
            //MyColors.paletteBlue.withOpacity(0.20),
            MyColors.lightRed.withOpacity(0.15)
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildStatItem(
              context,
              "Total donations",
              formatAmount(userStats.donationStatistics.totalDonations),
              ColorSettings.primaryColor),
          _buildStatItem(
              context,
              "Total raised",
              formatAmount(userStats.moneyTransferStatistics.totalRaised),
              ColorSettings.primaryColor),
          _buildStatItem(
              context,
              "Total gifted",
              formatAmount(userStats.moneyTransferStatistics.totalSentToPeers),
              ColorSettings.primaryColor),
        ],
      ),
    );
  }

  Widget _buildPrivateProfileDisclaimer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: SizedBox(
          width: screenWidth(context, percentage: 0.7),
          child: Center(child: Text("This profile is private"))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PublicProfileViewModel>.reactive(
      viewModelBuilder: () => PublicProfileViewModel(),
      onModelReady: (model) => model.fetchUserData(uid),
      builder: (context, model, child) {
        return ConstrainedWidthWithScaffoldLayout(
          child: ListView(
            children: [
              CustomAppBarSmall(
                title: "",
                forceElevated: false,
              ),
              model.isBusy
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            verticalSpaceSmall,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: LayoutSettings.horizontalPadding),
                                _buildProfileImage(model.user!.fullName),
                                horizontalSpaceMedium,
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildFullName(context, model.user!),
                                      _buildStatus(context),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            // if (model.otherUserStats != null)
                            //   _buildStatContainer(
                            //       context, model.otherUserStats!),
                          ],
                        ),
                        verticalSpaceRegular,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: LayoutSettings.horizontalPadding),
                            Flexible(
                              flex: 5,
                              child: CallToActionButtonRectangular(
                                  isOutlineButton: true,
                                  title: model.isFriend(uid)
                                      ? "Remove Friend"
                                      : "Add Friend",
                                  onPressed: () => model.addOrRemoveFriend(uid),
                                  maxWidth:
                                      screenWidth(context, percentage: 0.3),
                                  minHeight: 20,
                                  maxHeight: 40,
                                  fontSize: 16,
                                  color: model.isFriend(uid)
                                      ? MyColors.paletteGrey
                                      : MyColors.paletteBlue),
                            ),
                            Spacer(flex: 1),
                            Flexible(
                              flex: 5,
                              child: CallToActionButtonRectangular(
                                  title: "Send Money",
                                  onPressed: () =>
                                      model.navigateToTransferViewWithUser(
                                          model.user!),
                                  maxWidth:
                                      screenWidth(context, percentage: 0.3),
                                  minHeight: 20,
                                  maxHeight: 40,
                                  fontSize: 16,
                                  color: MyColors.paletteBlue),
                            ),
                          ],
                        ),
                        verticalSpaceMedium,
                        if (model.otherUserStats == null)
                          _buildPrivateProfileDisclaimer(context),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Column(
                            children: [
                              if (model.otherUserStats != null)
                                GoodWalletCard(
                                    onCardTap: () => model.showStatsDialog(
                                        model.user!, model.otherUserStats!),
                                    currentBalance:
                                        model.otherUserStats!.currentBalance,
                                    totalDonations: model.otherUserStats!
                                        .donationStatistics.totalDonations,
                                    totalRaised: model.otherUserStats!
                                        .moneyTransferStatistics.totalRaised,
                                    totalGifted: model
                                        .otherUserStats!
                                        .moneyTransferStatistics
                                        .totalSentToPeers,
                                    userInfo: model
                                        .getQRCodeUserInfoString(model.user!),
                                    onQRCodeTap: () => null,
                                    margins: 0.0,
                                    showQRCode: false,
                                    titleWidthPercentage: 0.6,
                                    highlightTotalDonations: true,
                                    title: model.user!.fullName +
                                        "'s Impact Card"),
                              verticalSpaceSmall,
                            ],
                          ),
                        ),
                        verticalSpaceLarge,
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }
}
