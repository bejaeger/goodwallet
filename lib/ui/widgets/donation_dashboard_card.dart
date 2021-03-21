import 'package:flutter/material.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

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
      aspectRatio: 7 / 9,
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        color: Colors.grey[100],
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "\$ " + value.toString(),
                      style: textTheme(context).headline2.copyWith(
                          //fontSize: 25,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(subtext,
                        style: textTheme(context)
                            .bodyText2
                            .copyWith(fontSize: 15)),
                  ),
                  verticalSpaceSmall,
                  CircularPercentIndicator(
                    //progressColor: Theme.of(context).,
                    radius: 80.0,
                    lineWidth: 12.0,
                    percent: (value % 100) / 100,
                    //header: new Text("From \$ 200"),
                    center: icon,
                    footer: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text("reach your next 100\$",
                            style: textTheme(context)
                                .bodyText2
                                .copyWith(height: 1.1),
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
