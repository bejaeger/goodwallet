import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/money_pools/money_pool_model.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/money_pools/single_money_pool_viewmodel.dart';
import 'package:good_wallet/ui/widgets/alternative_screen_header_image.dart';
import 'package:good_wallet/ui/widgets/horizontal_central_button.dart';
import 'package:good_wallet/ui/widgets/section_header.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class SingleMoneyPoolView extends StatelessWidget {
  final MoneyPoolModel moneyPool;
  const SingleMoneyPoolView({Key? key, required this.moneyPool})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SingleMoneyPoolViewModel>.reactive(
      viewModelBuilder: () => SingleMoneyPoolViewModel(),
      builder: (context, model, child) => ConstrainedWidthWithScaffoldLayout(
        child: model.isBusy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: <Widget>[
                  AlternativeScreenHeaderImage(
                    // TODO: Add picture if it's added by the user!
                    backgroundWidget: Container(
                      color: MyColors.paletteTurquoise.withOpacity(0.9),
                    ),
                    title: moneyPool.name,
                    onTopLeftButtonPressed: model.navigateBack,
                    topLeftWidget: Icon(Icons.close_rounded,
                        size: 28, color: ColorSettings.whiteTextColor),
                    topRightWidget: PopupMenuButton(
                      icon: Icon(
                        Icons.menu,
                        size: 28,
                        color: ColorSettings.whiteTextColor,
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          child: Text("Share"),
                        ),
                        PopupMenuItem(
                          value: 2,
                          child: TextButton(
                            onPressed: () async => await model
                                .deleteMoneyPool(moneyPool.moneyPoolId!),
                            child: Text("Delete"),
                          ),
                        ),
                      ],
                    ),
                    bottomRightWidget: IconButton(
                      color: ColorSettings.whiteTextColor,
                      icon: Icon(Icons.add_a_photo_outlined, size: 20.0),
                      onPressed: model.showNotImplementedSnackbar,
                    ),
                  ),
                  verticalSpaceSmall,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: LayoutSettings.horizontalPadding),
                    child: Text("Money pool started by ${moneyPool.adminName}"),
                  ),
                  verticalSpaceMedium,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: LayoutSettings.horizontalPadding),
                    child: Column(
                      children: [
                        HorizontalCentralButton(
                          onPressed: model.showNotImplementedSnackbar,
                          title: "Contribute",
                          minWidth:
                              screenWidthPercentage(context, percentage: 0.6),
                        ),
                        verticalSpaceRegular,
                        Text(moneyPool.total.toString(),
                            style: textTheme(context).headline2),
                        Text("Current amount")
                      ],
                    ),
                  ),
                  verticalSpaceLarge,
                  SectionHeader(
                    title: "Members",
                    trailingIcon: IconButton(
                      onPressed: model.showNotImplementedSnackbar,
                      icon: Icon(
                        Icons.add_circle_outline_rounded,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
