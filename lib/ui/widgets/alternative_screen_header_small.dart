import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

class AlternativeScreenHeaderSmall extends StatelessWidget {
  final String title;
  final void Function() onBackButtonPressed;
  final void Function()? onHelpIconPressed;

  const AlternativeScreenHeaderSmall(
      {Key? key,
      required this.title,
      required this.onBackButtonPressed,
      this.onHelpIconPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          alignment: Alignment.centerLeft,
          icon: Icon(
            Icons.arrow_back_ios,
            color: ColorSettings.blackHeadlineColor,
          ),
          onPressed: onBackButtonPressed,
        ),
        Text(
          title,
          style: textTheme(context).bodyText2!.copyWith(fontSize: 16),
        ),
        Icon(Icons.help_outline_rounded,
            color: ColorSettings.blackHeadlineColor),
      ],
    );
  }
}
