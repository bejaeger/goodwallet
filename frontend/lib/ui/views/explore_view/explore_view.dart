import 'package:flutter/material.dart';
import 'package:good_wallet/enums/featured_app_type.dart';
import 'package:good_wallet/enums/search_type.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/widgets/carousel_card.dart';
import 'package:good_wallet/ui/widgets/custom_app_bar_small.dart';
import 'package:good_wallet/ui/widgets/search_text_field.dart';
import 'package:good_wallet/ui/widgets/section_header.dart';
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
    final title = searchType == SearchType.UserToTransferTo
        ? "Send Money To"
        : searchType == SearchType.UserToInviteToMP
            ? "Invite User"
            : searchType == SearchType.FindFriends
                ? "Search Friends"
                : "Explore";
    final textFieldFocusNode = FocusNode();
    return ViewModelBuilder<ExploreViewModel>.reactive(
      viewModelBuilder: () => ExploreViewModel(),
      builder: (context, model, child) => ConstrainedWidthWithScaffoldLayout(
        child: CustomScrollView(
          key: PageStorageKey('storage-key'),
          physics: AlwaysScrollableScrollPhysics(),
          slivers: [
            CustomSliverAppBarSmall(forceElevated: false, title: title),
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
            SliverToBoxAdapter(
              child: Column(
                children: [
                  GreySearchTextField(hintText: "Explore"),
                  verticalSpaceRegular,
                  SectionHeader(
                    title: "Your Community's Impact",
                  ),
                  verticalSpaceRegular,
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: LayoutSettings.horizontalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LinearPercentIndicator(
                          width: screenWidth(context, percentage: 0.7),
                          lineHeight: 25.0,
                          animation: true,
                          animationDuration: 1000,
                          // leading: Padding(
                          //   padding: const EdgeInsets.only(right: 8.0),
                          //   child: Text("\$0"),
                          // ),

                          trailing: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text("\$1000"),
                          ),
                          percent: 0.7,
                          center: Text("\$700",
                              style: textTheme(context)
                                  .bodyText1!
                                  .copyWith(color: MyColors.almostWhite)),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: MyColors.paletteGreen.withOpacity(0.7),
                        ),
                        Text("Total donations of all your friends combined!"),
                      ],
                    ),
                  ),
                  verticalSpaceRegular,
                  SectionHeader(
                    title: "Our envisioned apps",
                    onTextButtonTap: model.showNotImplementedSnackbar,
                  ),
                  FeaturedAppsCarousel(model: model),
                  verticalSpaceRegular,
                  SectionHeader(
                    title: "Feed",
                    // onTextButtonTap: model.showNotImplementedSnackbar,
                  ),
                  verticalSpaceSmall,
                  FeaturedAppsCarousel(model: model, newsFeed: true),
                  verticalSpaceMassive,
                ],
              ),
            ),
          ],
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
                ? ColorSettings.primaryColor.withOpacity(0.5)
                : MyColors.paletteBlue.withOpacity(0.8),
          ),
          SizedBox(width: LayoutSettings.horizontalPadding),
          if (!newsFeed)
            CarouselCard(
              title: "Loyalty Program",
              explanation:
                  "A purely philanthropic loyalty program where you get cashback in your Good Wallet",
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
