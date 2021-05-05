import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/money_pools/base/money_pool.dart';
import 'package:good_wallet/enums/featured_app_type.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/home/home_view_mobile.dart';
import 'package:good_wallet/ui/views/raise_money/raise_money_viewmodel.dart';
import 'package:good_wallet/ui/widgets/carousel_card.dart';
import 'package:good_wallet/ui/widgets/custom_app_bar_small.dart';
import 'package:good_wallet/ui/widgets/money_pool_preview.dart';
import 'package:good_wallet/ui/widgets/section_header.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

///////////////////////////////////////////
///// Might be deprecated
////////////////////////////////////////////

class RaiseMoneyView extends StatelessWidget {
  const RaiseMoneyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RaiseMoneyViewModel>.reactive(
      viewModelBuilder: () => RaiseMoneyViewModel(),
      onModelReady: (model) async => model.fetchMoneyPools(force: true),
      builder: (context, model, child) => Scaffold(
        body: RefreshIndicator(
          onRefresh: () async => await model.fetchMoneyPools(force: true),
          child: CustomScrollView(
            key: PageStorageKey('storage-key'),
            physics: BouncingScrollPhysics(),
            slivers: [
              CustomSliverAppBarSmall(
                title: "Raise Money",
                onRightIconPressed: model.navigateToProfileView,
              ),
              model.isBusy
                  ? SliverList(
                      delegate: SliverChildListDelegate([Container()]),
                    )
                  : SliverList(
                      delegate: SliverChildListDelegate([
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            verticalSpaceMedium,
                            SectionHeader(
                              title: "Money pools",
                              onTextButtonTap:
                                  model.navigateToManageMoneyPoolView,
                            ),
                            MoneyPoolsGridView(model: model),
                            verticalSpaceMedium,
                            SectionHeader(
                              title: "Featured apps",
                              onTextButtonTap: model.showNotImplementedSnackbar,
                            ),
                            FeaturedAppsCarousel(model: model),
                            verticalSpaceMassive,
                          ],
                        ),
                      ]),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class MoneyPoolsGridView extends StatelessWidget {
  final dynamic model;

  const MoneyPoolsGridView({Key? key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: GridView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          crossAxisCount: 2,
        ),
        itemCount:
            model.moneyPools!.length > 3 ? 4 : model.moneyPools!.length + 1,
        itemBuilder: (context, index) {
          var itemCount =
              model.moneyPools!.length > 3 ? 4 : model.moneyPools!.length + 1;
          var showCreateNew = index == itemCount - 1 ? true : false;
          return MoneyPoolPreview(
            moneyPool: showCreateNew ? null : model.moneyPools![index],
            onTap: (MoneyPool pool) =>
                model.navigateToSingleMoneyPoolView(pool),
            onCreateMoneyPoolTapped: model.navigateToCreateMoneyPoolView,
          );
        },
      ),
    );
  }
}
