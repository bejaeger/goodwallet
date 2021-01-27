import 'package:flutter/material.dart';
import 'package:good_wallet/enums/user_status.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:good_wallet/viewmodels/layout/layout_template_view_model.dart';
import 'package:good_wallet/views/layout/navigation_bar_view.dart';
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
                    model.showNavigationBar ? NavigationBar() : Container(),
                    Expanded(
                      child: SizedBox.expand(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            // image: DecorationImage(
                            //   image: AssetImage(
                            //       "assets/images/woman-holding-flower.jpg"),
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                          child: childView,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
