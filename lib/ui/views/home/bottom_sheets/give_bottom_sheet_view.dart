import 'package:flutter/material.dart';
import 'package:good_wallet/ui/layout_widgets/bottom_sheet_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/home/bottom_sheets/give_bottom_sheet_viewmodel.dart';
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
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: request.customData.length,
                        itemBuilder: (context, index) => Row(
                              children: [
                                SizedBox(
                                    width: LayoutSettings.horizontalPadding),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0),
                                    color: MyColors.paletteTurquoise,
                                  ),
                                  width: screenWidthPercentage(context,
                                      percentage: 0.8),
                                  child: Center(
                                    child: Text(
                                        request.customData[index].projectName,
                                        style: textTheme(context).headline5),
                                  ),
                                ),
                              ],
                            )),
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
