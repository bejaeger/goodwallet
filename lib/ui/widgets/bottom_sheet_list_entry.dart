import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

// widget for one entry in the bottom sheet

class BottomSheetListEntry extends StatelessWidget {
  final String title;
  final String description;
  final dynamic responseData;
  final Icon icon;

  const BottomSheetListEntry({
    Key key,
    @required this.completer,
    @required this.responseData,
    @required this.title,
    @required this.icon,
    this.description,
  }) : super(key: key);

  final Function(SheetResponse p1) completer;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => completer(SheetResponse(responseData: responseData)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.black,
          child: icon,
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
        subtitle: description != null ? Text(description) : null,
      ),
    );
  }
}
