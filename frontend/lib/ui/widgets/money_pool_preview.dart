import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:good_wallet/datamodels/money_pools/base/money_pool.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/image_paths.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

class MoneyPoolPreview extends StatelessWidget {
  final MoneyPool moneyPool;
  final void Function(MoneyPool pool) onTap;
  final void Function() onCreateMoneyPoolTapped;
  final bool squaredLayout;
  final double height;
  final double? width;
  final double elevation;
  final bool showCreateNew;
  final String imagePath;
  final int maxLinesTitle;

  MoneyPoolPreview(
      {Key? key,
      required this.moneyPool,
      required this.onTap,
      required this.onCreateMoneyPoolTapped,
      this.squaredLayout = false,
      this.height = 240,
      this.width,
      this.elevation = 2.0,
      this.maxLinesTitle = 2,
      this.showCreateNew = false,
      this.imagePath = ImagePath.fourPeopleLaughing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int nMembers = moneyPool.contributingUserIds.length;
    if (!showCreateNew) {
      return GestureDetector(
        onTap: () => onTap(moneyPool),
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
          child: Container(
            height: height,
            width: width ?? screenWidth(context, percentage: 0.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: Colors.black12,
                  spreadRadius: 1,
                  offset: Offset(1, 2),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: height / 2,
                  decoration: BoxDecoration(
                    //color: Colors.red,
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: AssetImage(imagePath),
                        alignment: Alignment.topCenter,
                        fit: BoxFit.fitWidth),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        moneyPool.name,
                        maxLines: maxLinesTitle,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme(context)
                            .headline6!
                            .copyWith(fontSize: 18),
                      ),
                      verticalSpaceSmall,
                      Row(
                        children: [
                          Icon(Icons.attach_money,
                              color: ColorSettings.blackHeadlineColor),
                          horizontalSpaceSmall,
                          Text(formatAmount(moneyPool.total,
                              showDollarSign: false)),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.groups,
                              color: ColorSettings.blackHeadlineColor),
                          horizontalSpaceSmall,
                          Text(nMembers == 1
                              ? "$nMembers Member"
                              : "$nMembers Members"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: onCreateMoneyPoolTapped,
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
          child: Card(
            //color: Color(0xFFfed8b1),
            margin: const EdgeInsets.all(0.0),
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
              side: BorderSide(width: 1, color: Colors.grey[500]!),
            ),
            child: Container(
              height: height,
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
        ),
      );
    }
  }
}
