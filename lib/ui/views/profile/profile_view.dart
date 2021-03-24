import 'package:flutter/material.dart';
import 'package:good_wallet/enums/user_status.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/profile/profile_viewmodel.dart';
import 'package:good_wallet/ui/widgets/donation_dashboard_card.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      builder: (context, model, child) => Scaffold(
        body: !model.isSignedIn
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: ListView(
                  children: [
                    verticalSpaceMedium,
                    SizedBox(
                      height: 30,
                      child: Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Profile",
                                  style: textTheme(context).bodyText2.copyWith(
                                      fontWeight: FontWeight.w800,
                                      color: ColorSettings.blackTextColor)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                padding: EdgeInsets.zero,
                                alignment: Alignment.centerLeft,
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.black,
                                ),
                                onPressed: model.navigateBack,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    verticalSpaceMedium,
                    Text(model.currentUser.fullName,
                        style: textTheme(context).headline2),
                    verticalSpaceLarge,
                    Text("Your contributions",
                        style: textTheme(context).headline6),
                    verticalSpaceSmall,
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: screenWidth(context) -
                              2 * LayoutSettings.horizontalPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                DonationDashboardCard(
                                  value: model.donations / 100,
                                  subtext: "Given to good causes",
                                  icon: Icon(
                                    Icons.favorite,
                                    size: 30,
                                  ),
                                ),
                                // verticalSpaceSmall,
                                // PledgeButton(
                                //     title: "+ Donate",
                                //     onPressed: model
                                //         .navigateToDonationView),
                              ],
                            ),
                          ),
                          Spacer(flex: 1),
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                DonationDashboardCard(
                                  value: model.implicitDonations / 100,
                                  subtext: "Pledged for friends",
                                  icon: Icon(
                                    Icons.people,
                                    size: 30,
                                  ),
                                ),
                                // verticalSpaceSmall,
                                // PledgeButton(
                                //     title: "+ Send money",
                                //     onPressed: model
                                //         .showSendMoneyBottomSheet),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    verticalSpaceMedium,
                    Text("Community Contribution",
                        style: textTheme(context).headline6),
                    verticalSpaceMedium,
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: screenWidth(context) -
                              2 * LayoutSettings.horizontalPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("\$ 10028", style: textTheme(context).headline4),
                        ],
                      ),
                    ),
                    spacedDivider,
                    ListTile(
                      title: Text("Logout",
                          style: textTheme(context).headline6.copyWith(
                              color: ColorSettings.blackHeadlineColor)),
                      onTap: model.logout,
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
