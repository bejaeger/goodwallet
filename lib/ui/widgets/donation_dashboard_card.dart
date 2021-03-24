import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

// widget displaying a particular statistics of the good wallet
// making it look like a dashboard

class DonationDashboardCard extends StatelessWidget {
  final String subtext;
  final double value;
  final Icon icon;
  final Function callback;

  const DonationDashboardCard({
    Key key,
    @required this.subtext,
    @required this.value,
    @required this.icon,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 7 / 6,
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        color: Colors.white,
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  //Icon(Icons.chevron_right),
                ],
              ),
              verticalSpaceSmall,
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "\$ " + value.toString(),
                  style: textTheme(context)
                      .headline4
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(subtext,
                    style: textTheme(context).bodyText2.copyWith(fontSize: 15)),
              ),
              // verticalSpaceMedium,
              // LinearPercentIndicator(
              //   lineHeight: 12.0,
              //   percent: (value % 100) / 100,
              // ),
              // FittedBox(
              //   fit: BoxFit.scaleDown,
              //   child: Padding(
              //     padding: const EdgeInsets.only(top: 8.0),
              //     child: Text("reach your next 100\$",
              //         style: textTheme(context).bodyText2.copyWith(height: 1.1),
              //         textAlign: TextAlign.center),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
