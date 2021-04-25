//
// Widget to be used as alternative to AppBar as header...
// Just playing around with it
//

import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

class AlternativeScreenHeader extends StatelessWidget {
  final void Function() onBackButtonPressed;
  final void Function()? onRightButtonPressed;
  final String title;
  final String? description;
  final bool alignCenter;

  const AlternativeScreenHeader(
      {Key? key,
      required this.title,
      this.description,
      required this.onBackButtonPressed,
      this.onRightButtonPressed,
      this.alignCenter = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          alignCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              alignment: Alignment.centerLeft,
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: onBackButtonPressed,
            ),
            if (onRightButtonPressed != null)
              IconButton(
                icon: Icon(
                  Icons.help_outline_rounded,
                  color: ColorSettings.blackHeadlineColor,
                ),
                onPressed: onRightButtonPressed!,
              ),
          ],
        ),
        Column(
          crossAxisAlignment: alignCenter
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            verticalSpaceRegular,
            Text(
              title,
              style: textTheme(context).headline2,
            ),
            verticalSpaceSmall,
            if (description != null)
              Align(
                alignment:
                    alignCenter ? Alignment.center : Alignment.centerLeft,
                child: SizedBox(
                  width: screenWidthWithoutPadding(context, percentage: 0.7),
                  child: Text(
                    description!,
                    textAlign: alignCenter ? TextAlign.center : TextAlign.left,
                  ),
                ),
              ),
            verticalSpaceRegular,
          ],
        ),
      ],
    );
  }
}
