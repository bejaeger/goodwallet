import 'package:flutter/material.dart';
import 'package:good_wallet/ui/layout_widgets/bottom_sheet_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/image_icon_paths.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/home/bottom_sheets/give_bottom_sheet_viewmodel.dart';
import 'package:good_wallet/ui/views/profile/public_profile/public_profile_view_mobile.dart';
import 'package:good_wallet/ui/widgets/carousel_card.dart';
import 'package:good_wallet/ui/widgets/section_header.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class GiveBottomSheetView extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;

  const GiveBottomSheetView({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GiveBottomSheetViewModel>.reactive(
      viewModelBuilder: () =>
          GiveBottomSheetViewModel(latestDonations: request.customData),
      builder: (context, model, child) => model.isBusy
          ? Center(child: CircularProgressIndicator())
          : BottomSheetLayout(
              title: "Give to your favorite cause",
              widgetBeforeButtons: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // if (model.latestDonations.length > 0)
                  //   SectionHeader(
                  //     title: "Supported projects",
                  //     //onTextButtonTap: model.navigateToCausesView,
                  //     //textButtonText: "All projects",
                  //   ),
                  // verticalSpaceSmall,
                  if (model.supportedProjects.length > 0)
                    Container(
                      height: 140,
                      width: screenWidthPercentage(context, percentage: 1),
                      child: ProjectsList(
                        projects: model.supportedProjects,
                        onProjectPressed: model.navigateToSingleProjectScreen,
                      ),
                    ),
                ],
              ),
              buttons: [
                // BottomSheetListEntry(
                //   completer: completer,
                //   responseData: model.navigateToCausesView,
                //   title: "Explore all projects",
                //   icon: Icon(Icons.favorite,
                //       size: 32, color: MyColors.primaryRed),
                // ),
                BottomSheetListEntry(
                  completer: completer,
                  responseData: model.navigateToCausesView,
                  title: "Browse all social projects",
                  // description:
                  //     "Schedule donation and invite friends to contribute",
                  icon: Image.asset(ImageIconPaths.appsAroundGlobus),
                ),
              ],
            ),
    );
  }
}
