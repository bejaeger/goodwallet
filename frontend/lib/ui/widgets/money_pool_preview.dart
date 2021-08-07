import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/money_pools/base/money_pool.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

class MoneyPoolPreview extends StatelessWidget {
  final MoneyPool? moneyPool;
  final void Function(MoneyPool pool) onTap;
  final void Function() onCreateMoneyPoolTapped;
  final bool squaredLayout;
  final double? height;
  final double? width;

  const MoneyPoolPreview({
    Key? key,
    required this.moneyPool,
    required this.onTap,
    required this.onCreateMoneyPoolTapped,
    this.squaredLayout = false,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (moneyPool != null) {
      return GestureDetector(
        onTap: () => onTap(moneyPool!),
        child: Card(
          //color: Color(0xFFfed8b1),
          margin: const EdgeInsets.all(0.0),
          elevation: 2.0,
          //color: MyColors.paletteBlue.withOpacity(0.8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: BorderSide(width: 1, color: Colors.grey[500]!),
          ),
          child: Container(
            width: width,
            height: height ?? null,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  verticalSpaceSmall,
                  Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                moneyPool!.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme(context)
                                    .headline6!
                                    .copyWith(fontSize: 18),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 10.0, right: 40.0),
                              //   child: Divider(
                              //     thickness: 2,
                              //     color: ColorSettings.greyTextColor,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios,
                            color: ColorSettings.blackTextColor, size: 20),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(formatAmount(moneyPool!.total),
                            style: textTheme(context)
                                .headline4!
                                .copyWith(fontSize: squaredLayout ? 20 : 28)),
                        Text("Raised", style: textTheme(context).bodyText2),
                      ],
                    ),
                  ),
                  // Align(
                  //   alignment: Alignment.topRight,
                  //   child: Icon(Icons.arrow_forward_ios,
                  //       color: ColorSettings.blackTextColor, size: 20),
                  // ),
                  if (!squaredLayout)
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                          moneyPool!.contributingUserIds.length == 1
                              ? "${moneyPool!.contributingUserIds.length} member"
                              : "${moneyPool!.contributingUserIds.length} members",
                          style: textTheme(context).bodyText2),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: onCreateMoneyPoolTapped,
        child: Card(
          //color: Color(0xFFfed8b1),
          margin: const EdgeInsets.all(0.0),
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: BorderSide(width: 1, color: Colors.grey[500]!),
          ),
          child: Container(
            height: height ?? null,
            width: squaredLayout
                ? width
                : width != null
                    ? width
                    : screenWidthWithoutPadding(context, percentage: 0.45),
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(16.0),
            //   border: Border.all(color: ColorSettings.primaryColor, width: 2),
            // ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Icon(Icons.add,
                      size: squaredLayout ? 32 : 40,
                      color: ColorSettings.primaryColor),
                ),
                verticalSpaceSmall,
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: squaredLayout
                        ? null
                        : FittedBox(
                            child: Text("Create money pool",
                                style: textTheme(context).headline6!.copyWith(
                                    fontSize: squaredLayout ? 14 : 24)),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
