import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/money_pools/money_pool_model.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

class MoneyPoolPreview extends StatelessWidget {
  final MoneyPoolModel? moneyPool;
  final void Function(MoneyPoolModel pool) onTap;
  final void Function() onCreateMoneyPoolTapped;

  const MoneyPoolPreview({
    Key? key,
    required this.moneyPool,
    required this.onTap,
    required this.onCreateMoneyPoolTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (moneyPool != null) {
      return GestureDetector(
        onTap: () => onTap(moneyPool!),
        child: Card(
          margin: const EdgeInsets.all(0.0),
          elevation: 4.0,
          color: ColorSettings.primaryColor.withOpacity(0.8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Stack(
            children: [
              verticalSpaceSmall,
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        moneyPool!.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme(context)
                            .headline5!
                            .copyWith(fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 40.0),
                      child: Divider(
                        thickness: 2,
                        color: ColorSettings.greyTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(formatAmount(moneyPool!.total),
                        style: textTheme(context).headline3),
                    Text("Collected", style: textTheme(context).bodyText1),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: onCreateMoneyPoolTapped,
        child: Card(
          margin: const EdgeInsets.all(0.0),
          elevation: 4.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Container(
            width: screenWidthWithoutPadding(context, percentage: 0.45),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: ColorSettings.primaryColor, width: 2),
            ),
            child: AspectRatio(
              aspectRatio: 1,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Icon(Icons.add,
                        size: 40, color: ColorSettings.primaryColor),
                  ),
                  verticalSpaceSmall,
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Text("Create money pool",
                            style: textTheme(context).headline6!),
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
