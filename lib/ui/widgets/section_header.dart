// Heading for section with text button on the right
//
//
//

import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

class SectionHeader extends StatelessWidget {
  final void Function()? onTextButtonTap;
  final String title;
  final String textButtonText;
  final Widget? trailingIcon;

  const SectionHeader(
      {Key? key,
      required this.title,
      this.onTextButtonTap,
      this.textButtonText = "See all",
      this.trailingIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: LayoutSettings.horizontalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: textTheme(context).headline6),
          if (onTextButtonTap != null)
            TextButton(
              onPressed: onTextButtonTap,
              child: Text(
                textButtonText,
              ),
            ),
          if (trailingIcon != null) trailingIcon!,
        ],
      ),
    );
  }
}
