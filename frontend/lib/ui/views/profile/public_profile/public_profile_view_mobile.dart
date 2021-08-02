import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/user/user.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/profile/public_profile/public_profile_viewmodel.dart';
import 'package:good_wallet/ui/widgets/call_to_action_button.dart';
import 'package:good_wallet/ui/widgets/custom_app_bar_small.dart';
import 'package:good_wallet/ui/widgets/good_wallet_card.dart';
import 'package:good_wallet/ui/widgets/section_header.dart';
import 'package:good_wallet/utils/string_utils.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class PublicProfileViewMobile extends StatelessWidget {
  final String uid;

  const PublicProfileViewMobile({Key? key, required this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PublicProfileViewModel>.reactive(
      viewModelBuilder: () => PublicProfileViewModel(),
      onModelReady: (model) async => await model.fetchUserData(uid),
      builder: (context, model, child) {
        return ConstrainedWidthWithScaffoldLayout(
          child: ListView(
            children: [
              CustomAppBarSmall(
                  title: model.isCurrentUsersProfile ? "Your Profile" : "",
                  forceElevated: false,
                  rightWidget: model.isCurrentUsersProfile
                      ? GestureDetector(
                          onTap: model.navigateToAccountView,
                          child: Icon(Icons.settings,
                              color: ColorSettings.pageTitleColor, size: 25))
                      : null),
              Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      verticalSpaceSmall,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: LayoutSettings.horizontalPadding),
                          _buildProfileImage(model.user!.fullName),
                          horizontalSpaceMedium,
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                  model.isBusy
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: LayoutSettings.horizontalPadding),
                                Flexible(
                                  flex: 5,
                                  child: CallToActionButtonRectangular(
                                      isOutlineButton: true,
                                      title: model.isCurrentUsersProfile
                                          ? "${model.friends.length} Friends"
                                          : model.isFriend(uid)
                                              ? "Remove Friend"
                                              : "Add Friend",
                                      onPressed: model.isCurrentUsersProfile
                                          ? () => model.navigateToFriendsView(
                                              friends: model.friends)
                                          : () => model.addOrRemoveFriend(uid),
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
                                if (!model.isCurrentUsersProfile)
                                  Flexible(
                                    flex: 5,
                                    child: CallToActionButtonRectangular(
                                        title: "Send Money",
                                        onPressed: () => model
                                            .navigateToTransferViewWithUser(
                                                model.user!),
                                        maxWidth: screenWidth(context,
                                            percentage: 0.3),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Column(
                                children: [
                                  if (model.otherUserStats != null)
                                    GoodWalletCard(
                                        onCardTap: () => model.showStatsDialog(
                                            model.user!, model.otherUserStats!),
                                        currentBalance: model
                                            .otherUserStats!.currentBalance,
                                        totalDonations: model.otherUserStats!
                                            .donationStatistics.totalDonations,
                                        totalRaised: model
                                            .otherUserStats!
                                            .moneyTransferStatistics
                                            .totalRaised,
                                        totalGifted: model
                                            .otherUserStats!
                                            .moneyTransferStatistics
                                            .totalSentToPeers,
                                        userInfo: model.getQRCodeUserInfoString(
                                            model.user!),
                                        onQRCodeTap: model.isCurrentUsersProfile
                                            ? model.navigateToQRCodeView
                                            : () => null,
                                        margins: 0.0,
                                        showQRCode: model.isCurrentUsersProfile,
                                        titleWidthPercentage: 0.6,
                                        highlightTotalDonations: true,
                                        title: model.isCurrentUsersProfile
                                            ? "Your Impact"
                                            : model.user!.fullName +
                                                "'s Impact"),
                                  verticalSpaceSmall,
                                ],
                              ),
                            ),
                            verticalSpaceMedium,
                            if (model.isCurrentUsersProfile)
                              Column(
                                children: [
                                  SectionHeader(title: "Favorite Charities"),
                                  Text("To be continued"),
                                ],
                              ),
                          ],
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

  Widget _buildPrivateProfileDisclaimer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: SizedBox(
          width: screenWidth(context, percentage: 0.7),
          child: Center(child: Text("This profile is private"))),
    );
  }
}
