import 'package:flutter/material.dart';
import 'package:good_wallet/enums/user_status.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/startup_logic/startup_logic_viewmodel.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class StartUpLogicView extends StatelessWidget {
  const StartUpLogicView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpLogicViewModel>.reactive(
      viewModelBuilder: () => StartUpLogicViewModel(),
      onModelReady: (model) {
        model.handleStartUpLogic();
      },
      builder: (context, model, child) => model.showLoadingScreen()
          ? Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("The Good Wallet",
                        style: textTheme(context).headline2),
                    verticalSpaceMedium,
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            )
          : Scaffold(
              body: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.all(LayoutSettings.horizontalPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Failure to log in",
                          style: textTheme(context).headline2),
                      verticalSpaceMedium,
                      Text(
                          "Unfortunately, there was an error when logging. Please contact our support"),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
