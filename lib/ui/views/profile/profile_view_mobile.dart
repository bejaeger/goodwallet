import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/user/statistics/user_statistics.dart';
import 'package:good_wallet/datamodels/user/user.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/image_paths.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/shared/style_settings.dart';
import 'package:good_wallet/ui/views/profile/profile_viewmodel.dart';
import 'package:good_wallet/ui/widgets/custom_app_bar_small.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class ProfileViewMobile extends StatelessWidget {
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

  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 130.0,
        height: 130.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(90.0),
          child: Image.network(
            ImagePath.profilePicURL,
            fit: BoxFit.cover,
          ),
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

  Widget _buildWallet(BuildContext context, void Function()? onPressed,
      UserStatistics userStats) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: Colors.white,
        elevation: 2.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          width: 125,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.account_balance_wallet,
                      color: ColorSettings.blackTextColor),
                  // Text("Balance:",
                  //     style: textTheme(context)
                  //         .bodyText2
                  //         .copyWith(fontWeight: FontWeight.bold, fontSize: 18)),
                  horizontalSpaceSmall,
                  Text(
                    "\$ " + (userStats.currentBalance / 100).toString(),
                    style: textTheme(context)
                        .bodyText2!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
              //Text("Current balance"),
            ],
          ),
        ),
      ),
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

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      onModelReady: (model) {
        return null;
      },
      builder: (context, model, child) {
        return ConstrainedWidthWithScaffoldLayout(
          child: !model.isUserSignedIn || model.isBusy
              ? Center(child: CircularProgressIndicator())
              : CustomScrollView(
                  key: PageStorageKey('storage-key'),
                  physics: ScrollPhysics(),
                  slivers: [
                    CustomSliverAppBarSmall(
                      title: "Account",
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              verticalSpaceRegular,
                              _buildProfileImage(),
                              _buildFullName(context, model.currentUser),
                              _buildStatus(context),
                              // _buildWallet(
                              //     context,
                              //     model.navigateToTransactionsHistoryView,
                              //     model.userStats),
                              //_buildStatContainer(context, model.userStats),
                            ],
                          ),
                          verticalSpaceRegular,
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: LayoutSettings.horizontalPadding),
                            child: Column(
                              children: [
                                ProfileListItem(
                                  title: "Transfer History",
                                  onPressed:
                                      model.navigateToDonationsHistoryView,
                                ),
                                verticalSpaceSmall,
                                ProfileListItem(
                                  title: "Settings",
                                  onPressed: model.navigateToSettingsView,
                                ),
                                verticalSpaceSmall,
                                ProfileListItem(
                                  title: "Friends",
                                  onPressed: model.navigateToFriendsView,
                                ),
                                verticalSpaceMedium,
                                spacedDivider,
                                Center(
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minWidth: screenWidthPercentage(context,
                                          percentage: 0.6),
                                    ),
                                    child: ElevatedButton(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Logout",
                                            style:
                                                textTheme(context).headline5),
                                      ),
                                      onPressed: model.logout,
                                    ),
                                  ),
                                ),
                                verticalSpaceMedium,
                                spacedDivider,
                                SizedBox(
                                    width:
                                        screenWidth(context, percentage: 0.7),
                                    child: Text(
                                        "The following is not yet implemented but shown to get a grasp of what we plan to do")),
                                verticalSpaceMedium,
                                ProfileListItem(
                                  title: "Payment Methods",
                                  onPressed: model.showNotImplementedSnackbar,
                                ),
                                ProfileListItem(
                                  title: "Prepaid Fund",
                                  onPressed: model.navigateToFriendsView,
                                ),
                                verticalSpaceSmall,
                                ProfileListItem(
                                    title: "Set Giving Goals",
                                    onPressed:
                                        model.showNotImplementedSnackbar),
                                verticalSpaceSmall,
                                ProfileListItem(
                                    title: "Achievements",
                                    onPressed:
                                        model.showNotImplementedSnackbar),
                                spacedDivider,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("from"),
                                    verticalSpaceTiny,
                                    Text("THE GOOD WALLET FOUNDATION",
                                        style: textTheme(context)
                                            .bodyText1!
                                            .copyWith(
                                                color: ColorSettings
                                                    .blackHeadlineColor,
                                                fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          verticalSpaceLarge,
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

class ProfileListItem extends StatelessWidget {
  final Function? onPressed;
  final String? title;
  const ProfileListItem({Key? key, this.onPressed, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   border: Border.all(width: 0.5),
      //   borderRadius: BorderRadius.circular(10.0),
      // ),
      child: ListTile(
        title: Text(title!,
            style: textTheme(context).headline6!.copyWith(fontSize: 18)),
        trailing: Icon(Icons.arrow_forward_ios, size: 18),
        onTap: onPressed as void Function()?,
      ),
    );
  }
}
