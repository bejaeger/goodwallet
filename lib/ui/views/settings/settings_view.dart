import 'package:flutter/material.dart';
import 'package:good_wallet/ui/views/settings/settings_viewmodel.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.reactive(
      viewModelBuilder: () => SettingsViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: ListView(
            children: [
              verticalSpaceMedium,
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Settings",
                          style: textTheme(context)
                              .bodyText2
                              .copyWith(fontWeight: FontWeight.w800)),
                    ],
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerLeft,
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                    onPressed: model.navigateBack,
                  ),
                ],
              ),
              verticalSpaceLarge,
              ListTile(
                title: Text("Logout", style: textTheme(context).headline6),
                onTap: model.logout,
              )
            ],
          ),
        ),
      ),
    );
  }
}
