import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/widgets/call_to_action_button.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked_services/stacked_services.dart';

class ConfirmationBottomSheetLayout extends StatelessWidget {
  final String title;
  final Widget? centerWidget;

  final void Function()? onAcceptPressed;
  final void Function()? onCancelPressed;

  const ConfirmationBottomSheetLayout({
    Key? key,
    required this.title,
    this.onAcceptPressed,
    this.onCancelPressed,
    this.centerWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.only(
            top: 2,
            left: LayoutSettings.horizontalPadding,
            right: LayoutSettings.horizontalPadding),
        constraints: BoxConstraints(maxWidth: screenWidth(context)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 40,
              child: Divider(
                thickness: 4,
                color: Colors.grey[400],
              ),
            ),
            verticalSpaceSmall,
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorSettings.blackTextColor,
                  ),
                ),
                verticalSpaceMedium,
                if (centerWidget != null) centerWidget!,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CallToActionButtonRectangular(
                      title: "Accept",
                      color: MyColors.paletteGreen.withOpacity(0.9),
                      onPressed: onAcceptPressed,
                      maxWidth:
                          screenWidthWithoutPadding(context, percentage: 0.45),
                      minWidth:
                          screenWidthWithoutPadding(context, percentage: 0.45),
                    ),
                    CallToActionButtonRectangular(
                      title: "Decline",
                      color: ColorSettings.primaryColor,
                      onPressed: onCancelPressed,
                      maxWidth:
                          screenWidthWithoutPadding(context, percentage: 0.45),
                      minWidth:
                          screenWidthWithoutPadding(context, percentage: 0.45),
                    ),
                  ],
                ),
              ],
            ),
            verticalSpaceMedium,
          ],
        ),
      ),
    );
  }
}
