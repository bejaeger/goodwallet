import 'package:flutter/material.dart';
import 'package:good_wallet/ui/layout_widgets/bottom_sheet_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/image_icon_paths.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/home/bottom_sheets/give_bottom_sheet_viewmodel.dart';
import 'package:good_wallet/ui/widgets/causes/global_giving_project_card.dart';
import 'package:good_wallet/ui/widgets/section_header.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class GiveBottomSheetView extends StatelessWidget {
  final SheetRequest? request;
  final Function(SheetResponse)? completer;

  const GiveBottomSheetView({
    Key? key,
    this.request,
    this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GiveBottomSheetViewModel>.reactive(
      viewModelBuilder: () => GiveBottomSheetViewModel(),
      builder: (context, model, child) => model.isBusy
          ? Center(child: CircularProgressIndicator())
          : BottomSheetLayout(
              title: "Give",
              widgetBeforeButtons: Column(
                children: [
                  SectionHeader(
                    title: "Recently supported",
                    onTextButtonTap: model.navigateToAllPreviousDonations,
                  ),
                  Container(
                    height: 120,
                    width: screenWidthPercentage(context, percentage: 1),
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(width: LayoutSettings.horizontalPadding),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: MyColors.paletteTurquoise,
                          ),
                          width:
                              screenWidthPercentage(context, percentage: 0.8),
                          child: Center(
                            child: Text("Project 1",
                                style: textTheme(context).headline5),
                          ),
                        ),
                        SizedBox(width: LayoutSettings.horizontalPadding),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: MyColors.paletteBlue,
                          ),
                          width:
                              screenWidthPercentage(context, percentage: 0.8),
                          child: Center(
                            child: Text("Project 2",
                                style: textTheme(context).headline5),
                          ),
                        ),
                        SizedBox(width: LayoutSettings.horizontalPadding),
                      ],
                    ),
                  ),
                ],
              ),
              buttons: [
                BottomSheetListEntry(
                  completer: completer,
                  responseData: model.navigateToCausesView,
                  title: "Disaster relief",
                  icon: Icon(Icons.local_hospital_rounded,
                      size: 32, color: MyColors.lightRed),
                ),
                BottomSheetListEntry(
                  completer: completer,
                  responseData: model.navigateToCausesView,
                  title: "Explore all featured projects",
                  icon: Icon(Icons.favorite,
                      size: 32, color: MyColors.primaryRed),
                ),
              ],
            ),
    );
  }
}
