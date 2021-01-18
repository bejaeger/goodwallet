import 'package:flutter/material.dart';
import 'package:good_wallet/services/authentification/authentification_service.dart';
import 'package:good_wallet/viewmodels/navigation_bar_view_model.dart';
import 'package:good_wallet/views/navigation_bar_view.dart';
import 'package:good_wallet/views/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

// TODO: Rename to Layout Template
class LayoutTemplate extends StatelessWidget {
  final Widget child;
  const LayoutTemplate({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: CenteredView(
        maxWidth: screenSize.width,
        child: Column(
          children: <Widget>[
            NavigationBar(),
            Expanded(child: child),
            //  : CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
