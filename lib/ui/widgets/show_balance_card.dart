import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

class ShowBalanceCard extends StatelessWidget {
  final String title;
  final num balance;
  final void Function()? onHelpIconPressed;
  final String? shortDescription;
  final double height;

  const ShowBalanceCard({
    Key? key,
    required this.title,
    required this.balance,
    this.onHelpIconPressed,
    this.shortDescription,
    this.height = 135,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      color: Colors.white,
      child: Container(
        width: screenWidthWithoutPadding(context) - 8.0,
        height: height,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 20.0, right: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: textTheme(context).bodyText2!.copyWith(
                                fontSize: 17,
                              ),
                        ),
                        verticalSpaceTiny,
                        Text(
                          formatAmount(balance),
                          maxLines: 1,
                          style: textTheme(context).headline2!.copyWith(
                                fontSize: 28,
                              ),
                        ),
                        if (shortDescription != null)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Flexible(
                                child: Text(
                                  shortDescription!,
                                  style: textTheme(context).bodyText2!.copyWith(
                                        fontSize: 14,
                                      ),
                                ),
                              ),
                              //Icon(Icons.help_outline_rounded, size: 14),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
                if (onHelpIconPressed != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: Icon(Icons.help_outline_rounded),
                      onPressed: onHelpIconPressed,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
