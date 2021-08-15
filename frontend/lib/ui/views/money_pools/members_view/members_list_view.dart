import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/money_pools/users/contributing_user.dart';
import 'package:good_wallet/datamodels/user/public_user_info.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/widgets/custom_app_bar_small.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:good_wallet/utils/string_utils.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

class MembersListView extends StatelessWidget {
  final List<PublicUserInfo>? invitedUsers;
  final List<ContributingUser> contributingUsers;
  final String currentUserId;
  final String adminId;
  final String adminName;

  final void Function()? onInviteMemberPressed;

  const MembersListView({
    Key? key,
    this.invitedUsers,
    required this.contributingUsers,
    required this.currentUserId,
    required this.adminId,
    this.onInviteMemberPressed,
    required this.adminName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int childCount = invitedUsers == null
        ? contributingUsers.length
        : invitedUsers!.length + contributingUsers.length;
    return ConstrainedWidthWithScaffoldLayout(
      child: CustomScrollView(
        key: PageStorageKey('storage-key'),
        slivers: [
          CustomSliverAppBarSmall(
            title: "All Members",
            rightIcon: Icon(Icons.person_add,
                size: 26, color: ColorSettings.blackHeadlineColor),
            onRightIconPressed: onInviteMemberPressed,
          ),
          SliverList(
            //physics: ScrollPhysics(),
            //shrinkWrap: true,
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                bool isInvitedUser = invitedUsers == null
                    ? false
                    : index >= invitedUsers!.length
                        ? false
                        : true;
                dynamic user = invitedUsers == null
                    ? contributingUsers[index]
                    : isInvitedUser
                        ? invitedUsers![index]
                        : contributingUsers[index - invitedUsers!.length];
                var displayName = user.uid == currentUserId ? "You" : user.name;
                return Column(
                  children: [
                    verticalSpaceSmall,
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: LayoutSettings.horizontalPadding),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[400]!),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 10),
                          child: ListTile(
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
                                adminId == user.uid ? Text("Admin") : null,
                            trailing: isInvitedUser
                                ? Text("Pending invitation")
                                : Text(formatAmount(user.contribution)),
                          ),
                        ),
                      ),
                    ),
                    if (index == childCount - 1)
                      Column(
                        children: [
                          verticalSpaceRegular,
                          Divider(),
                          verticalSpaceRegular,
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              "Impact Pool started by " + adminName,
                            ),
                          ),
                        ],
                      ),
                  ],
                );
              },
              childCount: childCount,
            ),
          ),
        ],
      ),
    );
  }
}
