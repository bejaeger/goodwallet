import 'package:flutter/material.dart';
import 'package:good_wallet/enums/search_type.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/image_icon_paths.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/search_view/search_viewmodel.dart';
import 'package:good_wallet/ui/widgets/custom_app_bar_small.dart';
import 'package:good_wallet/utils/string_utils.dart';
import 'package:good_wallet/utils/debouncer.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class SearchView extends StatelessWidget {
  final SearchType searchType;
  final _debouncer = Debouncer(milliseconds: 10);

  SearchView({Key? key, this.searchType = SearchType.UserToTransferTo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
      viewModelBuilder: () => SearchViewModel(),
      builder: (context, model, child) => ConstrainedWidthWithScaffoldLayout(
        // Note: Maybe here we can use a NestedScrollView to achieve
        // nice effects with sliver?
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomAppBarSmall(
              height: LayoutSettings.minAppBarHeight,
              title: "Search User",
              rightWidget: IconButton(
                  icon: Icon(Icons.qr_code_scanner_rounded),
                  onPressed: model.navigateToScanQRCodeView),
            ),
            TextField(
              style: textTheme(context).bodyText2!.copyWith(
                  fontSize: 16, color: ColorSettings.blackHeadlineColor),
              autofocus: true,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.only(top: 15.0, left: 25.0, bottom: 15.0),
                hintText: 'Filter by name or email',
                hintStyle: textTheme(context).bodyText2,
              ),
              onChanged: (String pattern) async {
                // await model.queryUsers(pattern);
                _debouncer.run(() async {
                  await model.queryUsers(pattern);
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: model.userInfoList.length,
                itemBuilder: (BuildContext context, int index) {
                  return userListTile(model, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget userListTile(SearchViewModel model, int index) {
    return GestureDetector(
      onTap: () => model.selectUser(index, searchType),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: MyColors.paletteBlue,
            child: Text(getInitialsFromName(model.userInfoList[index].name),
                style: TextStyle(color: Colors.white, fontSize: 14)),
          ),
          title: Text(
            model.userInfoList[index].name,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
          subtitle: model.userInfoList[index].email != null
              ? Text(
                  model.userInfoList[index].email!.toLowerCase(),
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                )
              : Container(),
          trailing: PopupMenuButton(
            padding: const EdgeInsets.all(8.0),
            onSelected: (int index) {
              if (index == 0) {
                model.showNotImplementedSnackbar();
              } else if (index == 1) {
                model.showNotImplementedSnackbar();
              }
            },
            icon: Icon(
              Icons.more_vert_rounded,
              //color: ColorSettings.whiteTextColor,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Text("View profile"),
              ),
              PopupMenuItem(
                value: 1,
                child: Text("Add as friend"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
