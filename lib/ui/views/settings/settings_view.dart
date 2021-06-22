import 'package:flutter/material.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/views/settings/settings_viewmodel.dart';
import 'package:good_wallet/ui/widgets/custom_app_bar_small.dart';
import 'package:good_wallet/ui/widgets/section_header.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.reactive(
      viewModelBuilder: () => SettingsViewModel(),
      builder: (context, model, child) => ConstrainedWidthWithScaffoldLayout(
        child: model.isBusy
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  CustomAppBarSmall(title: "Settings"),
                  verticalSpaceRegular,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text("Public Information",
                        //     style: textTheme(context).headline6),
                        verticalSpaceMedium,
                        SettingsSwitchListItem(
                            title: "Public Donation Statistics",
                            value: model.currentUser.userSettings
                                .showDetailedStatistics,
                            subtitle:
                                "Should other users see your donation activity?",
                            onChanged: model.updateUserSettingsShowStats)
                      ],
                    ),
                  ),
                  verticalSpaceLarge,
                ],
              ),
      ),
    );
  }
}

class SettingsSwitchListItem extends StatelessWidget {
  final void Function(bool value) onChanged;
  final String title;
  final String subtitle;
  final bool value;
  const SettingsSwitchListItem(
      {Key? key,
      required this.title,
      required this.value,
      required this.subtitle,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.5),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SwitchListTile(
        activeColor: ColorSettings.primaryColor,
        value: value,
        onChanged: (bool value) => onChanged(value),
        title: Text(title,
            style: textTheme(context).headline6!.copyWith(fontSize: 18)),
        subtitle: Text(subtitle),
        //onChanged: (bool value) {  },
      ),
    );
  }
}
