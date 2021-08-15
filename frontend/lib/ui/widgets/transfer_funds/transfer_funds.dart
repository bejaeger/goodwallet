import 'package:flutter/material.dart';
import 'package:good_wallet/enums/transfer_type.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/image_icon_paths.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:good_wallet/utils/string_utils.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

import '../small_button_with_background.dart';

Widget bankInstituteIcon(BuildContext context) {
  return Column(
    children: [
      Image.asset(
        ImageIconPaths.bankInstitution,
        width: 40,
        height: 40,
        fit: BoxFit.contain,
      ),
      Text("Bank", style: textTheme(context).headline6),
    ],
  );
}

Widget goodWalletIcon(BuildContext context, [num? balance]) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Good", style: textTheme(context).headline4),
      Text("Wallet", style: textTheme(context).headline4),
      if (balance != null)
        Text("Available: " + formatAmount(balance),
            style: textTheme(context).bodyText2),

    ],
  );
}

Widget prepaidFundIcon(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Prepaid", style: textTheme(context).headline4),
      Text("Balance", style: textTheme(context).headline4),
    ],
  );
}

Widget avatarWithUserName(BuildContext context, void Function()? onTap,
    {required String recipientName}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        //Text("Gift money to", style: textTheme(context).headline4),
        //verticalSpaceSmall,
        CircleAvatar(
          radius: 28,
          backgroundColor: MyColors.paletteBlue,
          child: Text(getInitialsFromName(recipientName),
              style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
        verticalSpaceSmall,
        Text(recipientName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textTheme(context).headline6!.copyWith(fontSize: 15)),
      ],
    ),
  );
}

Widget projectSummary(BuildContext context, void Function()? onTap,
    {required String recipientName}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: MyColors.primaryRed,
          child: Text(getInitialsFromName(recipientName),
              style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
        verticalSpaceSmall,
        SizedBox(
          width: screenWidthWithoutPadding(context, percentage: 0.35),
          child: Text(recipientName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textTheme(context).headline6!.copyWith(fontSize: 14)),
        ),
      ],
    ),
  );
}

Widget moneyPoolSummary(BuildContext context, {required String name}) {
  return Column(
    children: [
      CircleAvatar(
        radius: 28,
        backgroundColor: MyColors.paletteGreen,
        child: Text(getInitialsFromName(name),
            style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
      verticalSpaceSmall,
      SizedBox(
        width: screenWidthWithoutPadding(context, percentage: 0.35),
        child: Text(name,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: textTheme(context).headline6!.copyWith(fontSize: 14)),
      ),
    ],
  );
}

Widget hashTagCommitForGood(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Wallet", style: textTheme(context).headline4),
      Text("Good", style: textTheme(context).headline4),
    ],
  );
}

Widget topUp(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Prepaid", style: textTheme(context).headline4),
      Text("fund", style: textTheme(context).headline4),
    ],
  );
}
