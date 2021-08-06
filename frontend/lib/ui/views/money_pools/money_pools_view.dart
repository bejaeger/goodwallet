import 'dart:math';

import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/money_pools/base/money_pool.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/money_pools/money_pools_viewmodel.dart';
import 'package:good_wallet/ui/widgets/custom_app_bar_small.dart';
import 'package:good_wallet/ui/widgets/money_pool_preview.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

import 'package:stacked/stacked.dart';

class MoneyPoolsView extends StatelessWidget {
  final bool forceReload;
  const MoneyPoolsView({Key? key, this.forceReload = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MoneyPoolsViewModel>.reactive(
      viewModelBuilder: () => MoneyPoolsViewModel(),
      onModelReady: (model) => model.listenToAndFetchData(),
      builder: (context, model, child) => ConstrainedWidthWithScaffoldLayout(
        child: RefreshIndicator(
          onRefresh: () async => await model.refresh(),
          child: CustomScrollView(
            key: PageStorageKey('storage-key'),
            physics: AlwaysScrollableScrollPhysics(),
            slivers: [
              CustomSliverAppBarSmall(
                forceElevated: false,
                title: "Your Impact Pools",
                onRightIconPressed: model.showInformationDialog,
                rightIcon: Icon(Icons.help_outline,
                    color: ColorSettings.pageTitleColor, size: 28),
                onSecondRightIconPressed: model.navigateToCreateMoneyPoolView,
                secondRightIcon: Icon(Icons.add_box_outlined,
                    color: ColorSettings.pageTitleColor, size: 28),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 15)),
              model.isBusy
                  ? SliverToBoxAdapter(
                      child: Center(
                          child: Column(
                      children: [
                        verticalSpaceMedium,
                        CircularProgressIndicator(),
                      ],
                    )))
                  : SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: LayoutSettings.horizontalPadding),
                            child: MoneyPoolsList(
                                moneyPools: model.moneyPools,
                                onMoneyPoolPressed:
                                    model.navigateToSingleMoneyPoolView,
                                onCreateNewPressed:
                                    model.navigateToCreateMoneyPoolView),
                          )
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class MoneyPoolsList extends StatelessWidget {
  final List<MoneyPool> moneyPools;
  final void Function(MoneyPool) onMoneyPoolPressed;
  final void Function() onCreateNewPressed;
  const MoneyPoolsList({
    Key? key,
    required this.moneyPools,
    required this.onMoneyPoolPressed,
    required this.onCreateNewPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        itemCount: moneyPools.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MoneyPoolPreview(
                height: 140,
                moneyPool: moneyPools[index],
                onTap: onMoneyPoolPressed,
                onCreateMoneyPoolTapped: onCreateNewPressed,
              ),
              verticalSpaceSmall,
            ],
          );
        });
  }
}
