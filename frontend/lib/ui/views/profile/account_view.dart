import 'package:flutter/material.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/profile/account_viewmodel.dart';
import 'package:good_wallet/ui/widgets/custom_app_bar_small.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class AccountView extends StatelessWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AccountViewModel>.reactive(
        viewModelBuilder: () => AccountViewModel(),
        builder: (context, model, child) {
          return ConstrainedWidthWithScaffoldLayout(
            child: ListView(
              children: [
                CustomAppBarSmall(
                  title: "Your Account",
                  forceElevated: false,
                ),
                verticalSpaceMedium,
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: LayoutSettings.horizontalPadding),
                  child: Column(
                    children: [
                      ProfileListItem(
                        title: "Settings",
                        onPressed: model.navigateToSettingsView,
                      ),
                      verticalSpaceMedium,
                      SizedBox(
                          width: screenWidth(context, percentage: 0.7),
                          child: Text(
                              "The following is not yet implemented but shown to get a grasp of what we plan to add")),
                      verticalSpaceMedium,
                      ProfileListItem(
                        title: "Payment Methods",
                        onPressed: model.showNotImplementedSnackbar,
                      ),
                      ProfileListItem(
                        title: "Prepaid Fund",
                        onPressed: model.showNotImplementedSnackbar,
                      ),
                      verticalSpaceSmall,
                      ProfileListItem(
                          title: "Set Giving Goals",
                          onPressed: model.showNotImplementedSnackbar),
                      verticalSpaceSmall,
                      ProfileListItem(
                          title: "Achievements",
                          onPressed: model.showNotImplementedSnackbar),
                      verticalSpaceMedium,
                      LogoutButton(onPressed: model.logout),
                      verticalSpaceMedium,
                      spacedDivider,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("from"),
                          verticalSpaceTiny,
                          Text("THE GOOD WALLET FOUNDATION",
                              style: textTheme(context).bodyText1!.copyWith(
                                  color: ColorSettings.blackHeadlineColor,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class LogoutButton extends StatelessWidget {
  final void Function() onPressed;
  const LogoutButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: screenWidthPercentage(context, percentage: 0.6),
        ),
        child: ElevatedButton(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Logout", style: textTheme(context).headline5),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}

class ProfileListItem extends StatelessWidget {
  final Function? onPressed;
  final String? title;
  const ProfileListItem({Key? key, this.onPressed, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   border: Border.all(width: 0.5),
      //   borderRadius: BorderRadius.circular(10.0),
      // ),
      child: ListTile(
        title: Text(title!,
            style: textTheme(context).headline6!.copyWith(fontSize: 18)),
        trailing: Icon(Icons.arrow_forward_ios, size: 18),
        onTap: onPressed as void Function()?,
      ),
    );
  }
}
