import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/money_pools/money_pool_model.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/money_pools/manage_money_pools_viewmodel.dart';
import 'package:good_wallet/ui/widgets/alternative_screen_header.dart';
import 'package:good_wallet/ui/widgets/custom_sliver_app_bar_small.dart';
import 'package:good_wallet/ui/widgets/money_pool_preview.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import 'package:stacked/stacked.dart';

class ManageMoneyPoolsView extends StatelessWidget {
  final bool forceReload;
  const ManageMoneyPoolsView({Key? key, this.forceReload = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ManageMoneyPoolsViewModel>.reactive(
      viewModelBuilder: () => ManageMoneyPoolsViewModel(),
      onModelReady: (model) async {
        model.fetchMoneyPools(force: forceReload);
      },
      builder: (context, model, child) => Scaffold(
        body: RefreshIndicator(
          onRefresh: () async => await model.fetchMoneyPools(force: true),
          child: CustomScrollView(
            key: PageStorageKey('storage-key'),
            physics: AlwaysScrollableScrollPhysics(),
            slivers: [
              CustomSliverAppBarSmall(
                title: "Your Money Pools",
                onRightIconPressed: model.showInformationDialog,
                rightIcon: Icon(Icons.help_outline),
              ),
              model.isBusy
                  ? SliverList(
                      delegate: SliverChildListDelegate([Container()]),
                    )
                  : SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          verticalSpaceLarge,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        LayoutSettings.horizontalPadding),
                                child: GridView.builder(
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
                                  itemCount: model.moneyPools.length + 1,
                                  itemBuilder: (context, index) {
                                    var showCreateNew =
                                        index == model.moneyPools.length
                                            ? true
                                            : false;
                                    return MoneyPoolPreview(
                                      moneyPool: showCreateNew
                                          ? null
                                          : model.moneyPools[index],
                                      onTap: (MoneyPoolModel pool) => model
                                          .navigateToSingleMoneyPoolView(pool),
                                      onCreateMoneyPoolTapped:
                                          model.navigateToCreateMoneyPoolView,
                                    );
                                  },
                                ),
                              ),
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
  }
}
