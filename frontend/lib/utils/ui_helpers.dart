import 'dart:math';

import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:intl/intl.dart';

const Widget horizontalSpaceTiny = SizedBox(width: 5.0);
const Widget horizontalSpaceSmall = SizedBox(width: 10.0);
const Widget horizontalSpaceRegular = SizedBox(width: 18.0);
const Widget horizontalSpaceMedium = SizedBox(width: 25.0);
const Widget horizontalSpaceLarge = SizedBox(width: 50.0);

const Widget verticalSpaceTiny = SizedBox(height: 5.0);
const Widget verticalSpaceSmall = SizedBox(height: 10.0);
const Widget verticalSpaceRegular = SizedBox(height: 18.0);
const Widget verticalSpaceMedium = SizedBox(height: 25.0);
const Widget verticalSpaceMediumLarge = SizedBox(height: 40.0);
const Widget verticalSpaceLarge = SizedBox(height: 50.0);
const Widget verticalSpaceMassive = SizedBox(height: 120.0);

Widget spacedDivider = Column(
  children: const <Widget>[
    verticalSpaceMedium,
    const Divider(color: Colors.blueGrey, height: 5.0),
    verticalSpaceMedium,
  ],
);

Color getBkgColor(context) => Theme.of(context).backgroundColor;

Widget verticalSpace(double height) => SizedBox(height: height);

double screenWidth(BuildContext context, {double percentage = 1}) =>
    min(MediaQuery.of(context).size.width, LayoutSettings.maxAppWidth) *
    percentage;

double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;
Size screenSize(BuildContext context) => MediaQuery.of(context).size;

double screenHeightFraction(BuildContext context,
        {int dividedBy = 1, double offsetBy = 0}) =>
    (screenHeight(context) - offsetBy) / dividedBy;

double screenWidthFraction(BuildContext context,
        {int dividedBy = 1, double offsetBy = 0}) =>
    (screenWidth(context) - offsetBy) / dividedBy;

double halfScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 2);

double thirdScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 3);

double screenHeightPercentage(BuildContext context, {double percentage = 1}) =>
    screenHeight(context) * percentage;

double screenWidthPercentage(BuildContext context, {double percentage = 1}) =>
    screenWidth(context) * percentage;

double screenWidthWithoutPadding(BuildContext context, {double? percentage}) =>
    percentage != null
        ? (screenWidth(context) - 2 * LayoutSettings.horizontalPadding) *
            percentage
        : screenWidth(context) - 2 * LayoutSettings.horizontalPadding;

isDesktop(BuildContext context) => MediaQuery.of(context).size.width > 600;
TextTheme textTheme(BuildContext context) => Theme.of(context).textTheme;

String formatDate(DateTime timestamp) {
  return DateFormat.MMMEd().format(timestamp);
}

String formatDateShort(DateTime? timestamp) {
  if (timestamp != null) {
    return DateFormat.MMMd().add_jm().format(timestamp);
  } else {
    return "";
  }
}

String formatDateVeryShort(DateTime timestamp) {
  return DateFormat.yM().format(timestamp);
}

String formatDateDetails(DateTime timestamp) {
  return DateFormat.yMd().add_jm().format(timestamp);
}

class CenteredView extends StatelessWidget {
  final maxWidth;
  final Widget? child;
  const CenteredView({Key? key, this.child, this.maxWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
