import 'package:flutter/material.dart';
import 'package:good_wallet/enums/search_type.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/widgets/custom_app_bar_small.dart';
import 'package:good_wallet/ui/widgets/search_text_field.dart';
import 'package:good_wallet/ui/widgets/user_list_tile.dart';
import 'package:good_wallet/utils/string_utils.dart';
import 'package:good_wallet/utils/debouncer.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import 'explore_viewmodel.dart';

class ExploreView extends StatelessWidget {
  final SearchType searchType;
  final bool autofocus;
  final _debouncer = Debouncer(milliseconds: 10);

  ExploreView(
      {Key? key, this.searchType = SearchType.Explore, this.autofocus = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = searchType == SearchType.UserToTransferTo
        ? "Send Money To"
        : searchType == SearchType.UserToInviteToMP
            ? "Invite User"
            : searchType == SearchType.FindFriends
                ? "Search Friends"
                : "Explore";
    final textFieldFocusNode = FocusNode();
    return ViewModelBuilder<ExploreViewModel>.reactive(
      viewModelBuilder: () => ExploreViewModel(),
      builder: (context, model, child) => ConstrainedWidthWithScaffoldLayout(
        child: CustomScrollView(
          key: PageStorageKey('storage-key'),
          physics: AlwaysScrollableScrollPhysics(),
          slivers: [
            CustomSliverAppBarSmall(
                forceElevated: false,
                title: title,
                onSecondRightIconPressed: searchType == SearchType.Explore
                    ? model.navigateToProfileView
                    : null,
                secondRightIcon: searchType == SearchType.Explore
                    ? Icon(
                        Icons.person,
                        color: ColorSettings.pageTitleColor,
                        size: 28,
                      )
                    : null),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  verticalSpaceSmall,
                  GreySearchTextField(
                    focusNode: textFieldFocusNode,
                    autofocus: autofocus,
                    onSuffixIconPressed: () {
                      textFieldFocusNode.unfocus();
                      model.navigateToScanQRCodeView();
                    },
                    onChanged: (String pattern) async {
                      // await model.queryUsers(pattern);
                      _debouncer.run(() async {
                        await model.queryUsers(pattern);
                      });
                    },
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 6.0)),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final user = model.userInfoList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: LayoutSettings.horizontalPadding * 0.5),
                    child: UserListTile(
                      name: user.name,
                      email: user.email,
                      uid: user.uid,
                      onSelected: model.onSelected,
                      popUpMenuEntries: [
                        PopupMenuItem(
                            value: {"uid": user.uid},
                            child: Text("View Profile")),
                      ],
                      onTilePressed: () {
                        textFieldFocusNode.unfocus();
                        model.selectUserAndProceed(index, searchType);
                      },
                    ),
                  );
                },
                childCount: model.userInfoList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//    Widget userListTile(ExploreViewModel model, int index, FocusNode focusNode) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//           horizontal: LayoutSettings.horizontalPadding * 0.5),
//       child: GestureDetector(
//         onTap: () {
//           focusNode.unfocus();
//           model.selectUserAndProceed(index, searchType);
//         },
//         child: Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16.0),
//           ),
//           child: ListTile(
//             leading: CircleAvatar(
//               radius: 20,
//               backgroundColor: MyColors.paletteBlue,
//               child: Text(getInitialsFromName(user.name),
//                   style: TextStyle(color: Colors.white, fontSize: 14)),
//             ),
//             title: Text(
//               user.name,
//               style: TextStyle(
//                 fontSize: 16.0,
//                 color: Colors.black,
//               ),
//             ),
//             subtitle: user.email != null
//                 ? Text(
//                     user.email!.toLowerCase(),
//                     style: TextStyle(
//                       fontSize: 14.0,
//                       color: Colors.grey,
//                     ),
//                   )
//                 : Container(),
//             trailing: PopupMenuButton(
//               padding: const EdgeInsets.all(8.0),
//               onSelected: model.onSelected,
//                             icon: Icon(
//                 Icons.more_vert_rounded,
//                 //color: ColorSettings.whiteTextColor,
//               ),
//               itemBuilder: (context) => [
//                 PopupMenuItem(
//                   value: 0,
//                   child: Text("View profile"),
//                 ),
//                 PopupMenuItem(
//                   value: 1,
//                   child: model.isFriend(user.uid)
//                       ? Text("Remove friend")
//                       : Text("Add friend"),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
