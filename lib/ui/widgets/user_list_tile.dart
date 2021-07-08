// User list tile e.g. for search view or friends list view

import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/utils/string_utils.dart';

class UserListTile extends StatelessWidget {
  final String name;
  final String email;
  final String uid;
  final void Function()? onTilePressed;
  final List<PopupMenuItem<Map<String, dynamic>>>? popUpMenuEntries;
  final void Function(Map<String, dynamic>)? onSelected;

  const UserListTile(
      {Key? key,
      required this.name,
      required this.email,
      required this.uid,
      this.onTilePressed,
      this.popUpMenuEntries,
      this.onSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTilePressed,
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: MyColors.paletteBlue,
            child: Text(getInitialsFromName(name),
                style: TextStyle(color: Colors.white, fontSize: 14)),
          ),
          title: Text(
            name,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
          subtitle: email != null
              ? Text(
                  email.toLowerCase(),
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                )
              : Container(),
          trailing: onSelected == null || popUpMenuEntries == null
              ? null
              : PopupMenuButton<Map<String, dynamic>>(
                  padding: const EdgeInsets.all(8.0),
                  onSelected: (Map<String, dynamic> map) {
                    onSelected!(map);
                  },
                  icon: Icon(
                    Icons.more_vert_rounded,
                    //color: ColorSettings.whiteTextColor,
                  ),
                  itemBuilder: (context) => popUpMenuEntries!,
                ),
        ),
      ),
    );
  }
}
