import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/money_pools/money_pool_model.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/money_pools/manage_money_pools_viewmodel.dart';
import 'package:good_wallet/ui/widgets/alternative_screen_header.dart';
import 'package:good_wallet/ui/widgets/money_pool_preview.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import 'package:stacked/stacked.dart';

class ManageMoneyPoolsView extends StatelessWidget {
  const ManageMoneyPoolsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ManageMoneyPoolsViewModel>.reactive(
      viewModelBuilder: () => ManageMoneyPoolsViewModel(),
      onModelReady: (model) async => await model.fetchMoneyPools(),
      builder: (context, model, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: LayoutSettings.horizontalPadding),
          child: model.isBusy
              ? Center(child: CircularProgressIndicator())
              : Shimmer(
                  interval: Duration(hours: 1),
                  child: RefreshIndicator(
                    onRefresh: () async =>
                        await model.fetchMoneyPools(force: true),
                    child: ListView(
                      physics: AlwaysScrollableScrollPhysics(),
                      children: [
                        AlternativeScreenHeader(
                          title: "Your Money Pools",
                          onBackButtonPressed: model.navigateBack,
                          onRightButtonPressed: model.showInformationDialog,
                        ),
                        verticalSpaceMediumLarge,
                        if (model.moneyPools.isNotEmpty)
                          GridView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent:
                                        screenWidthWithoutPadding(context,
                                            percentage: 0.45),
                                    childAspectRatio: 1,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20),
                            itemCount: model.moneyPools.length,
                            itemBuilder: (context, index) {
                              return MoneyPoolPreview(
                                moneyPool: model.moneyPools[index],
                                onTap: (MoneyPoolModel pool) =>
                                    model.navigateToSingleMoneyPoolView(pool),
                                onCreateMoneyPoolTapped:
                                    model.navigateToCreateMoneyPoolView,
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
