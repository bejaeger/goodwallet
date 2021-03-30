import 'package:flutter/material.dart';
import 'package:good_wallet/enums/user_status.dart';
import 'package:good_wallet/ui/views/layout/layout_template_view_mobile.dart';
import 'package:good_wallet/ui/views/layout/layout_template_viewmodel.dart';
import 'package:good_wallet/ui/views/layout/navigation_bar_view.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class LayoutTemplate extends StatelessWidget {
  final Widget childView;
  const LayoutTemplate({Key key, @required this.childView}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ViewModelBuilder<LayoutTemplateViewModel>.reactive(
      viewModelBuilder: () => LayoutTemplateViewModel(),
      builder: (context, model, child) => isDesktop(context)
          ? Scaffold(
              body: CenteredView(
                maxWidth: screenSize.width,
                child: model.userStatus == UserStatus.Unknown
                    ? LinearProgressIndicator()
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          NavigationBar(),
                          Expanded(
                            child: SizedBox.expand(
                              // child: Container(
                              //   decoration: BoxDecoration(
                              //     // gradient: LinearGradient(
                              //     //     colors: [
                              //     //       Color(0xFFDDDDDD),
                              //     //       Colors.white,
                              //     //       Colors.white,
                              //     //       Color(0xFFDDDDDD)
                              //     //     ],
                              //     //     begin: Alignment.topCenter,
                              //     //     end: Alignment.bottomCenter,
                              //     //     stops: [0, 0.3, 0.7, 1]),
                              //   ),
                              child: childView,
                              // ),
                            ),
                          ),
                        ],
                      ),
              ),
            )
          : Scaffold(
            body: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: screenWidth(context),
                  ),
                  child: LayoutTemplateViewMobile()),
            ),
          ),
    );
  }
}
