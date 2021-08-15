import 'package:flutter/material.dart';
import 'package:good_wallet/constants/constants.dart';
import 'package:good_wallet/enums/featured_app_type.dart';
import 'package:good_wallet/enums/search_type.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/callout_container.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/widgets/carousel_card.dart';
import 'package:good_wallet/ui/widgets/custom_app_bar_small.dart';
import 'package:good_wallet/ui/widgets/section_header.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:good_wallet/utils/debouncer.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:stacked/stacked.dart';

import 'explore_viewmodel.dart';

class ExploreView extends StatelessWidget {
  final SearchType searchType;
  final bool autofocus;
  final _debouncer = Debouncer(milliseconds: 100);

  ExploreView(
      {Key? key, this.searchType = SearchType.Explore, this.autofocus = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textFieldFocusNode = FocusNode();
    return ViewModelBuilder<ExploreViewModel>.reactive(
      viewModelBuilder: () => ExploreViewModel(),
      onModelReady: (model) => model.fetchTotalDonationsGlobal(),
      builder: (context, model, child) => ConstrainedWidthWithScaffoldLayout(
        child: RefreshIndicator(
          onRefresh: () async => await model.refresh(),
          child: CustomScrollView(
            key: PageStorageKey('storage-key'),
            physics: AlwaysScrollableScrollPhysics(),
            slivers: [
              CustomSliverAppBarSmall(
                  forceElevated: false, title: "Our Community & Plans"),
              // onSecondRightIconPressed: searchType == SearchType.Explore
              //     ? model.navigateToProfileView
              //     : null,
              // secondRightIcon: searchType == SearchType.Explore
              //     ? Icon(
              //         Icons.person,
              //         color: ColorSettings.pageTitleColor,
              //         size: 28,
              //       )
              //     : null),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    verticalSpaceMedium,
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: LayoutSettings.horizontalPadding),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          horizontalSpaceMedium,
                          Text(formatAmount(model.runningTotalDonationsGlobal),
                              style: textTheme(context).headline2),
                          horizontalSpaceRegular,
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: LinearPercentIndicator(
                              backgroundColor: Colors.transparent,
                              lineHeight: 30.0,
                              animation: true,
                              animationDuration: model.animationDurationInMs,
                              percent: 1,
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              progressColor:
                                  ColorSettings.primaryColor.withOpacity(0.8),
                            ),
                          ),
                          FittedBox(
                              child: Text(
                            "Total donations from The Good Wallet community",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          )),
                        ],
                      ),
                    ),
                    verticalSpaceMedium,
                    SectionHeader(
                      title: "Our Future Apps",
                    ),
                    verticalSpaceRegular,
                    //FeaturedAppsCarousel(model: model),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: LayoutSettings.horizontalPadding),
                      child: FeaturedAppsGrid(
                        titles: [
                          "Marketplace",
                          "Loyalty Program",
                          "Social Habit Forming",
                          "Sportsbetting"
                        ],
                        descriptions: [
                          "Sell items in exchange for Good Dollars",
                          "A purely altruistic loyalty program with cashback in your Good Wallet",
                          "Encourage each other to healthier habits with Good Dollars as incentive",
                          "Bet with friends and win Good Gollars"
                        ],
                      ),
                    ),
                    // SectionHeader(
                    //   title: "Feed",
                    //   // onTextButtonTap: model.showNotImplementedSnackbar,
                    // ),
                    //FeaturedAppsCarousel(model: model, newsFeed: true),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 40.0, right: 40, top: 20),
                      child: CalloutContainer(
                          title: "Are you a developer?",
                          description:
                              "We're looking for you! Help us build applications that leverage the Good Wallet. Reach out at info@the-good-wallet.com!"),
                    ),
                    verticalSpaceLarge,
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

class FeaturedAppsCarousel extends StatelessWidget {
  final dynamic model;
  final bool newsFeed;

  const FeaturedAppsCarousel({Key? key, this.model, this.newsFeed = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(width: LayoutSettings.horizontalPadding),
          CarouselCard(
            title: newsFeed ? "Are you a developer?" : "Marketplace",
            explanation: newsFeed
                ? "We're looking for you! Help us build applications that leverage the Good Wallet. Reach out to info@the-good-wallet.com!"
                : "Sell items in exchange for Good Dollars",
            onTap: newsFeed
                ? null
                : () => model.navigateToSingleFeaturedAppView(
                    FeaturedAppType.Marketplace),
            backgroundColor: newsFeed
                ? MyColors.paletteGreen2.withOpacity(0.8)
                : MyColors.niceLightRed.withOpacity(0.8),
          ),
          SizedBox(width: LayoutSettings.horizontalPadding),
          if (!newsFeed)
            CarouselCard(
              title: "Loyalty Program",
              explanation:
                  "A purely philanthropic loyalty program with cashback in your Good Wallet",
              onTap: null,
              backgroundColor: MyColors.palettePurple.withOpacity(0.8),
            ),
          if (!newsFeed) SizedBox(width: LayoutSettings.horizontalPadding),
          if (!newsFeed)
            CarouselCard(
              title: "Sportsbetting",
              explanation: "Bet with friends and win Good Gollars",
              onTap: null,
              backgroundColor: MyColors.paletteTurquoise.withOpacity(0.8),
            ),
          SizedBox(width: LayoutSettings.horizontalPadding),
        ],
      ),
    );
  }
}

class FeaturedAppsGrid extends StatelessWidget {
  final List<String> titles;
  final List<String> descriptions;
  const FeaturedAppsGrid({
    Key? key,
    required this.titles,
    required this.descriptions,
  }) : super(key: key);

  @override
  Widget build(BuildContext contexst) {
    return GridView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
      ),
      itemCount: titles.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 5.0,
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            color: MyColors.niceColors[index % 4],
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(titles[index], style: textTheme(context).headline5),
                  Flexible(
                    child: Text(descriptions[index],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        style: textTheme(context).bodyText1!.copyWith(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
