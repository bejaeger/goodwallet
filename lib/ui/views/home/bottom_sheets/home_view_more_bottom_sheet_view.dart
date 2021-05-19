import 'package:flutter/material.dart';
import 'package:good_wallet/ui/layout_widgets/bottom_sheet_layout.dart';
import 'package:good_wallet/ui/shared/image_icon_paths.dart';
import 'package:good_wallet/ui/views/home/bottom_sheets/home_view_more_bottom_sheet_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewMoreBottomSheetView extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;

  const HomeViewMoreBottomSheetView({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewMoreBottomSheetViewModel>.reactive(
      viewModelBuilder: () => HomeViewMoreBottomSheetViewModel(),
      builder: (context, model, child) => model.isBusy
          ? Center(child: CircularProgressIndicator())
          : BottomSheetLayout(
              buttons: [
                BottomSheetListEntry(
                  completer: completer,
                  responseData: model.showNotImplementedSnackbar,
                  title: "Invite friends",
                  description: "Raise via the Good Wallet referral fund",
                  icon: Image.asset(ImageIconPaths.huggingPeople),
                ),
                BottomSheetListEntry(
                  completer: completer,
                  responseData: model.showNotImplementedSnackbar,
                  title: "Top-up prepaid fund",
                  description:
                      "To send micro-payments without extra transaction fee",
                  icon: Image.asset(ImageIconPaths.holdingHands),
                ),
                BottomSheetListEntry(
                  completer: completer,
                  responseData: model.showNotImplementedSnackbar,
                  title: "Checkout our featured apps",
                  description:
                      "Raise effortlessly on multiple connected platforms",
                  icon: Image.asset(ImageIconPaths.appsAroundGlobus),
                ),
                //     BottomSheetListEntry(
                //       completer: completer,
                //       responseData: model.navigateToCausesView,
                //       title: "Explore all featured projects",
                //       icon: Icon(Icons.favorite,
                //           size: 32, color: MyColors.primaryRed),
                //     ),
                //   ],
                // ),
              ],
            ),
    );
  }
}
