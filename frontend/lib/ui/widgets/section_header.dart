// Heading for section with text button on the right
//
//
//

import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

class SectionHeader extends StatelessWidget {
  final void Function()? onTextButtonTap;
  final String title;
  final String textButtonText;
  final Widget? trailingIcon;
  final double titleSize;

  const SectionHeader(
      {Key? key,
      required this.title,
      this.onTextButtonTap,
      this.textButtonText = "SEE ALL",
      this.trailingIcon,
      this.titleSize = 20})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: LayoutSettings.horizontalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: textTheme(context).headline6!.copyWith(
                  fontSize: titleSize,
                  color: ColorSettings.blackHeadlineColor)),
          if (onTextButtonTap != null)
            IconButton(
                onPressed: onTextButtonTap,
                icon: Icon(
                  Icons.more_horiz,
                  size: 28,
                  color: ColorSettings.blackHeadlineColor,
                )),
          // TextButton(
          //   onPressed: onTextButtonTap,
          //   child: Text(
          //     textButtonText,
          //     style: textTheme(context)
          //         .headline6!
          //         .copyWith(color: ColorSettings.greyTextColor, fontSize: 14),
          //   ),
          // ),
          if (trailingIcon != null) trailingIcon!,
        ],
      ),
    );
  }
}
