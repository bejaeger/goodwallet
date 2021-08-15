import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/user/statistics/supported_project_statistics.dart';
import 'package:good_wallet/datamodels/user/user.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/profile/public_profile/public_profile_viewmodel.dart';
import 'package:good_wallet/ui/widgets/call_to_action_button.dart';
import 'package:good_wallet/ui/widgets/causes/global_giving_project_card.dart';
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
      onModelReady: (model) async => await model.listenAndFetchData(uid),
      builder: (context, model, child) {
        return ConstrainedWidthWithScaffoldLayout(
          child: CustomScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            slivers: [
              CustomSliverAppBarSmall(
                title: model.isCurrentUsersProfile ? "Your Profile" : "",
                forceElevated: false,
                onRightIconPressed: model.navigateToAccountView,
                rightIcon: Icon(Icons.settings,
                    color: ColorSettings.pageTitleColor, size: 25),
              ),
              // rightWidget: model.isCurrentUsersProfile
              //     ? GestureDetector(
              //         onTap: model.navigateToAccountView,
              //         child: Icon(Icons.settings,
              //             color: ColorSettings.pageTitleColor, size: 25))
              //     : null),
              model.isBusy
                  ? SliverToBoxAdapter(
                      child: Column(
                        children: [
                          verticalSpaceMedium,
                          CircularProgressIndicator()
                        ],
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildListDelegate(
                        [
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
                                        if (model.getUserCreationTime() != null)
                                        _buildStatus(context, model.getUserCreationTime()!),
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
                          Column(
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
                                            : () =>
                                                model.addOrRemoveFriend(uid),
                                        maxWidth: screenWidth(context,
                                            percentage: 0.3),
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
                                  if (model.isCurrentUsersProfile)
                                    Flexible(
                                      flex: 5,
                                      child: CallToActionButtonRectangular(
                                          title:
                                              "${model.moneyPools.length} Impact Pools",
                                          onPressed: () => model
                                              .navigateToAllMoneyPoolsView(),
                                          maxWidth: screenWidth(context,
                                              percentage: 0.33),
                                          minHeight: 20,
                                          maxHeight: 40,
                                          fontSize: 16,
                                          color: MyColors.paletteBlue),
                                    ),
                                ],
                              ),
                              verticalSpaceMedium,
                              if (model.otherUserStats == null &&
                                  !model.isCurrentUsersProfile)
                                _buildPrivateProfileDisclaimer(context),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0),
                                child: Column(
                                  children: [
                                    if (model.otherUserStats != null)
                                      GoodWalletCard(
                                          onCardTap: () => model.showStatsDialog(
                                              model.user!,
                                              model.otherUserStats!),
                                          currentBalance: model
                                              .otherUserStats!.currentBalance,
                                          totalDonations: model
                                              .otherUserStats!
                                              .donationStatistics
                                              .totalDonations,
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
                                          onQRCodeTap:
                                              model.isCurrentUsersProfile
                                                  ? model.navigateToQRCodeView
                                                  : () => null,
                                          margins: 0.0,
                                          showQRCode:
                                              model.isCurrentUsersProfile,
                                          titleWidthPercentage: 0.6,
                                          highlightTotalDonations: true,
                                          title: model.isCurrentUsersProfile
                                              ? "Your Impact"
                                              : model.user!.fullName + "'s Impact"),
                                    verticalSpaceSmall,
                                  ],
                                ),
                              ),
                              verticalSpaceMedium,
                              if (model.isCurrentUsersProfile)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SectionHeader(
                                        title: "Your supported projects"),
                                    verticalSpaceRegular,
                                    Container(
                                      height: 160,
                                      child: ProjectsList(
                                        projects: model.supportedProjects,
                                        onProjectPressed:
                                            model.navigateToSingleProjectScreen,
                                      ),
                                    )
                                  ],
                                ),
                            ],
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

  Widget _buildStatus(BuildContext context, DateTime userCreationTime) {
    return Text(
      "Member since "+formatDateVeryShort(userCreationTime),
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

class ProjectsList extends StatelessWidget {
  final List<SupportedProjectStatistics> projects;
  final void Function(String) onProjectPressed;
  final void Function()? onAllProjectsPressed;

  const ProjectsList(
      {Key? key,
      required this.projects,
      required this.onProjectPressed,
      this.onAllProjectsPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return projects.length == 0
        ? Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: LayoutSettings.horizontalPadding),
            child: Text(" Make your first donation"),
          )
        : GridView.builder(
            scrollDirection: Axis.horizontal,
            physics: ScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.only(
                left: LayoutSettings.horizontalPadding,
                right: LayoutSettings.horizontalPadding,
                bottom: 8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1,
              //crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              crossAxisCount: 1,
            ),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return GlobalGivingProjectCardWithFunding(
                totalDonated: projects[index].totalDonations,
                displayArea: false,
                project: projects[index],
                onTap: () => onProjectPressed(projects[index].projectInfo.id),
              );
            });
  }
}
