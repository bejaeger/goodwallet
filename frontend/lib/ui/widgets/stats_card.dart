import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/widgets/call_to_action_button.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

class StatsCard extends StatelessWidget {
  final double height;
  final num statistic;
  final String? title;
  final String? subtitle;
  final String buttonText;
  final void Function()? onButtonPressed;
  final void Function()? onCardPressed;

  const StatsCard(
      {Key? key,
      required this.statistic,
      this.height: 130,
      this.title,
      this.subtitle,
      this.onButtonPressed,
      this.buttonText = "Donate",
      this.onCardPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardPressed,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 4,
        child: Container(
          height: height,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      if (title != null)
                        Text(
                          title!,
                          style: textTheme(context).bodyText2!.copyWith(
                                fontSize: 18,
                              ),
                        ), //verticalSpaceTiny,
                      Text(
                        formatAmount(statistic),
                        maxLines: 1,
                        style: textTheme(context).headline2!.copyWith(
                              fontSize: 28,
                            ),
                      ),
                      if (subtitle != null)
                        Text(
                          subtitle!,
                          maxLines: 1,
                          style: textTheme(context).bodyText2!.copyWith(
                                fontSize: 13,
                              ),
                        ),
                    ],
                  ),
                  Container(height: 30),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: onButtonPressed,
                  child: Container(
                      alignment: Alignment.center,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: ColorSettings.primaryColor.withOpacity(0.8),
                      ),
                      child: Text(buttonText,
                          style: textTheme(context)
                              .headline5!
                              .copyWith(fontSize: 16))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
