import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/user/user.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/style_settings.dart';
import 'package:good_wallet/ui/views/friends/friends_viewmodel.dart';
import 'package:good_wallet/ui/widgets/custom_app_bar_small.dart';
import 'package:good_wallet/ui/widgets/user_list_tile.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class FriendsView extends StatelessWidget {
  final List<User>? friends;
  const FriendsView({Key? key, this.friends}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FriendsViewModel>.reactive(
      viewModelBuilder: () => FriendsViewModel(),
      onModelReady: (model) => model.listenToFriends(friendsPreloaded: friends),
      builder: (context, model, child) => ConstrainedWidthWithScaffoldLayout(
        child: RefreshIndicator(
          onRefresh: () async =>
              await Future.delayed(Duration(milliseconds: 200)),
          child: ListView(
            children: [
              CustomAppBarSmall(
                title: "Your Friends",
                rightWidget: GestureDetector(
                  onTap: model.navigateToFindFriendsView,
                  child: Icon(Icons.person_add,
                      color: ColorSettings.pageTitleColor, size: 25),
                ),
              ),
              verticalSpaceRegular,
              model.isBusy
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: model.friends.length == 0
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextButton(
                                    onPressed: model.showNotImplementedSnackbar,
                                    child: Text("No friends found",
                                        style: textTheme(context).bodyText2)),
                              ],
                            )
                          : ListView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: model.friends.length,
                              itemBuilder: (context, index) {
                                final user = model.friends[index];
                                return UserListTile(
                                    name: user.fullName,
                                    uid: user.uid,
                                    email: user.email,
                                    onTilePressed: () => model
                                        .navigateToPublicProfileView(user.uid),
                                    popUpMenuEntries: [
                                      PopupMenuItem(
                                          value: {"uid": user.uid},
                                          child: Text("Remove friend")),
                                    ],
                                    onSelected: model.onSelected);
                              }),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
