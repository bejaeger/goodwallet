import 'package:flutter/material.dart';
import 'package:good_wallet/enums/user_status.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/image_paths.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/profile/profile_viewmodel.dart';
import 'package:good_wallet/ui/widgets/donation_dashboard_card.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class ProfileViewMobile extends StatelessWidget {
  late dynamic _model;

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

  Widget _buildFullName(BuildContext context) {
    return Text(
      _model.currentUser.fullName,
      style: textTheme(context).headline4,
    );
  }

  Widget _buildStatus(BuildContext context) {
    return Text(
      "Member since 7/21",
    );
  }

  Widget _buildWallet(BuildContext context) {
    return GestureDetector(
      onTap: _model.navigateToTransactionsHistoryView,
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
                    "\$ " + (_model.userStats.currentBalance / 100).toString(),
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

  Widget _buildStatContainer(BuildContext context) {
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
              formatAmount(_model.userStats.donations),
              ColorSettings.primaryColor),
          _buildStatItem(
              context,
              "Total raised",
              formatAmount(_model.userStats.raised),
              ColorSettings.primaryColor),
          _buildStatItem(
              context,
              "Total gifted",
              formatAmount(_model.userStats.transferredToPeers),
              ColorSettings.primaryColor),

          // Row(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     Icon(Icons.favorite, size: 30),
          //     horizontalSpaceSmall,
          //     _buildStatItem(context, "Total donations",
          //         "\$ " + (_model.userWallet.donations / 100).toString()),
          //   ],
          // ),
          // Row(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     Icon(Icons.send_rounded, size: 30),
          //     horizontalSpaceSmall,
          //     _buildStatItem(
          //         context,
          //         "Total gifted",
          //         "\$ " +
          //             (_model.userWallet.transferredToPeers / 100).toString()),
          //     //_buildStatItem("", _scores),
          //   ],
          // ),
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
        _model = model;
        return ConstrainedWidthWithScaffoldLayout(
          child: !model.isUserSignedIn || model.isBusy
              ? Center(child: CircularProgressIndicator())
              : ListView(
                  children: [
                    Stack(
                      children: <Widget>[
                        _buildCoverImage(screenSize(context)),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 20.0, right: 20.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              alignment: Alignment.centerLeft,
                              icon: Icon(
                                Icons.close,
                                color: ColorSettings.greyTextColor,
                                size: 28,
                              ),
                              onPressed: model.navigateBack,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 20.0, right: 20.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: model.showNotImplementedSnackbar,
                              icon: Icon(Icons.settings,
                                  color: ColorSettings.greyTextColor, size: 25),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            SizedBox(height: screenHeight(context) / 5),
                            _buildProfileImage(),
                            _buildFullName(context),
                            _buildStatus(context),
                            _buildWallet(context),
                            _buildStatContainer(context),
                          ],
                        ),
                      ],
                    ),
                    verticalSpaceMediumLarge,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Column(
                        children: [
                          ProfileListItem(
                            title: "Donations History",
                            onPressed: model.navigateToDonationsHistoryView,
                          ),
                          verticalSpaceSmall,
                          ProfileListItem(
                            title: "Payment Methods",
                            onPressed: model.navigateToDonationsHistoryView,
                          ),
                          verticalSpaceSmall,
                          ProfileListItem(
                              title: "Invite Friends",
                              onPressed: model.showNotImplementedSnackbar),
                          verticalSpaceSmall,
                          ProfileListItem(
                              title: "Contacts",
                              onPressed: model.showNotImplementedSnackbar),
                          verticalSpaceSmall,
                          ProfileListItem(
                              title: "Achievements",
                              onPressed: model.showNotImplementedSnackbar),
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
                                      style: textTheme(context).headline5),
                                ),
                                onPressed: model.logout,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    verticalSpaceLarge,
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
      decoration: BoxDecoration(
        border: Border.all(width: 0.5),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        title: Text(title!,
            style: textTheme(context).headline6!.copyWith(fontSize: 20)),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: onPressed as void Function()?,
      ),
    );
  }
}
