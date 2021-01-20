import 'package:flutter/material.dart';
import 'package:good_wallet/enums/user_status.dart';
import 'package:good_wallet/viewmodels/layout_template_view_model.dart';
import 'package:good_wallet/viewmodels/wallet_view_model.dart';
import 'package:good_wallet/views/donation/donation_view.dart';
import 'package:good_wallet/views/finances/payment_cancel_view.dart';
import 'package:good_wallet/views/finances/payment_success_view.dart';
import 'package:good_wallet/views/navigation_bar_view.dart';
import 'package:good_wallet/views/send_money_view.dart';
import 'package:good_wallet/views/utils/ui_helpers.dart';
import 'package:good_wallet/views/wallet_view.dart';
import 'package:good_wallet/views/welcome_view.dart';
import 'package:stacked/stacked.dart';

// TODO: Rename to Layout Template
class LayoutTemplate extends StatelessWidget {
  final Widget childView;
  const LayoutTemplate({Key key, @required this.childView}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ViewModelBuilder<LayoutTemplateViewModel>.reactive(
      viewModelBuilder: () => LayoutTemplateViewModel(),
      builder: (context, model, child) => Scaffold(
        body: CenteredView(
          maxWidth: screenSize.width,
          child: model.userStatus == UserStatus.Unknown
              ? LinearProgressIndicator()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    NavigationBar(),
                    Expanded(child: childView),
                  ],
                ),
        ),
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key key,
    @required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return CenteredView(
      maxWidth: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: screenSize.height * 2),
          Text("Was geht ab! screensize = ${screenSize.width}"),
        ],
      ),
    );
  }
}
