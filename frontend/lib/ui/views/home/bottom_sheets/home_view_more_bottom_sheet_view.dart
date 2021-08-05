import 'package:flutter/material.dart';
import 'package:good_wallet/ui/layout_widgets/bottom_sheet_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
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
              // description:
              //     "Give the gift of giving: Your sent funds become charitable-only",
              //title: "Pledge now, donate later",
              buttons: [
                // BottomSheetListEntry(
                //   completer: completer,
                //   responseData: model.navigateToExploreView,
                //   title: "Find friends",
                //   description: "Raise and give together",
                //   icon: Image.asset(ImageIconPaths.huggingPeople),
                // ),
                //Harguilar
                BottomSheetListEntry(
                  completer: completer,
                  responseData: model.navigateToCommitMoneyView,
                  title: "Commit money for good causes",
                  description: "Pledge money and give later",
                  icon: Image.asset(ImageIconPaths.agreeingHands,
                      color: ColorSettings.greyTextColor),
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
                  responseData: model.navigateToQRCodeView,
                  title: "Get paid to raise money",
                  description:
                      "Raise money for good causes by accepting payments into your wallet",
                  icon: Image.asset(ImageIconPaths.agreeingHands,
                      color: ColorSettings.primaryColor),
                ),
                BottomSheetListEntry(
                  completer: completer,
                  responseData: model.navigateToStripeView,
                  title: "Send Money With Stripe",
                  description: "Raise Money For people in need",
                  icon: Image.asset(ImageIconPaths.agreeingHands),
                ),

                // BottomSheetListEntry(
                //   completer: completer,
                //   responseData: model.showNotImplementedSnackbar,
                //   title: "Checkout our featured apps",
                //   description:
                //       "Raise effortlessly on multiple connected platforms",
                //   icon: Image.asset(ImageIconPaths.appsAroundGlobus),
                // ),
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
