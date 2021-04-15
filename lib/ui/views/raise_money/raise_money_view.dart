import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/money_pools/money_pool_model.dart';
import 'package:good_wallet/enums/featured_app_type.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/home/home_view_mobile.dart';
import 'package:good_wallet/ui/views/raise_money/raise_money_viewmodel.dart';
import 'package:good_wallet/ui/widgets/carousel_card.dart';
import 'package:good_wallet/ui/widgets/money_pool_preview.dart';
import 'package:good_wallet/ui/widgets/section_header.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class RaiseMoneyView extends StatelessWidget {
  const RaiseMoneyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RaiseMoneyViewModel>.reactive(
      viewModelBuilder: () => RaiseMoneyViewModel(),
      onModelReady: (model) async => await model.fetchMoneyPools(),
      //fireOnModelReadyOnce: true,
      builder: (context, model, child) => Scaffold(
        body: RefreshIndicator(
          onRefresh: () async => await model.fetchMoneyPools(force: true),
          child: CustomScrollView(
            key: PageStorageKey('storage-key'),
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Raise Money",
                            style: textTheme(context)
                                .headline3!
                                .copyWith(fontSize: 25)),
                        GestureDetector(
                          onTap: model.navigateToProfileView,
                          child: Icon(
                            Icons.person,
                            color: ColorSettings.whiteTextColor,
                            size: 25,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                titleSpacing: 20,
                expandedHeight: LayoutSettings.minAppBarHeight * 1,
                collapsedHeight: LayoutSettings.minAppBarHeight,
                backgroundColor: ColorSettings.primaryColor, //Colors.white,
                elevation: 2.0,
                toolbarHeight: LayoutSettings.minAppBarHeight,
                pinned: true,
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
        itemCount: model.moneyPools!.length > 4 ? 4 : model.moneyPools!.length,
        itemBuilder: (context, index) {
          return MoneyPoolPreview(
            moneyPool: model.moneyPools![index],
            onTap: (MoneyPoolModel pool) =>
                model.navigateToSingleMoneyPoolView(pool),
            onCreateMoneyPoolTapped: model.navigateToCreateMoneyPoolView,
          );
        },
      ),
    );
  }
}

class FeaturedAppsCarousel extends StatelessWidget {
  final dynamic model;

  const FeaturedAppsCarousel({Key? key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(width: LayoutSettings.horizontalPadding),
          CarouselCard(
            title: "Marketplace",
            explanation: "Sell items in exchange for Good Dollars",
            onTap: () => model
                .navigateToSingleFeaturedAppView(FeaturedAppType.Marketplace),
          ),
          SizedBox(width: LayoutSettings.horizontalPadding),
          CarouselCard(
            title: "Sportsbetting",
            explanation: "Bet with friends and win Good Gollars",
            onTap: model.showNotImplementedSnackbar,
            backgroundColor: MyColors.paletteTurquoise,
          ),
          SizedBox(width: LayoutSettings.horizontalPadding),
          CarouselCard(
            title: "Your Application",
            explanation:
                "This could be your application that leverages the Good Wallet to do good",
            onTap: model.showNotImplementedSnackbar,
            backgroundColor: MyColors.palettePurple,
          ),
          SizedBox(width: LayoutSettings.horizontalPadding),
        ],
      ),
    );
  }
}
