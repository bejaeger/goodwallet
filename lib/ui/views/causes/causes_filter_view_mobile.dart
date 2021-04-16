import 'package:flutter/material.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/datamodels/causes/good_wallet_fund_model.dart';
import 'package:good_wallet/enums/causes_filter_list_type.dart';
import 'package:good_wallet/ui/layout_widgets/tabbar_layout.dart';
import 'package:good_wallet/ui/views/causes/causes_filter_viewmodel.dart';
import 'package:good_wallet/ui/views/causes/causes_viewmodel.dart';
import 'package:good_wallet/ui/widgets/causes/global_giving_project_card.dart';
import 'package:good_wallet/ui/widgets/causes/good_wallet_fund_card.dart';
import 'package:good_wallet/ui/widgets/small_wallet_card.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:stacked/stacked.dart';

class CausesFilterViewMobile extends StatelessWidget {
 const CausesFilterViewMobile({Key? key}) : super(key: key);

 @override
 Widget build(BuildContext context) {
   return ViewModelBuilder<CausesFilterViewModel>.reactive(
     viewModelBuilder: () => locator<CausesFilterViewModel>(),
      disposeViewModel: false,
      fireOnModelReadyOnce: true,
      onModelReady: (model) async => await model.fetchCauses(),
      builder: (context, model, child) => TabBarLayout(
        title: "Social Projects",
        titleTrailingWidget: SmallWalletCard(
            onTap: model.navigateToTransactionsHistoryView,
            width: 80,
            balance: model.userWallet.currentBalance!),
        tabs: [
          Container(
              width: screenWidth(context) * 0.25,
              child: Tab(text: "Themes")),
          Container(
              width: screenWidth(context) * 0.3,
              child: Tab(text: "Good Wallet Funds")),
          Container(
              width: screenWidth(context) * 0.25,
              child: Tab(text: "Favorites")),
        ],
        views: [ 
          CausesFilterListViewMobile(
            type: CausesFilterListType.Themes,
            description: Text("High-impact charities provided by GlobalGiving"),
          ),
          CausesFilterListViewMobile(
            type: CausesFilterListType.GoodWalletFund,
            description: Text(
                "Support one of our Good Wallet funds and help grow our community"),
          ),
          CausesFilterListViewMobile(
            type: CausesFilterListType.Favorites,
            description: Text("Your favorite projects"),
          ),
        ],
      ),
    );
  }
}

class CausesFilterListViewMobile extends StatelessWidget {
  final CausesFilterListType type;
  final Widget? description;

  const CausesFilterListViewMobile({Key? key, required this.type, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CausesViewModel>.reactive(
      viewModelBuilder: () => locator<CausesViewModel>(),
      disposeViewModel: false,
      fireOnModelReadyOnce: true,
      onModelReady: (model) async => await model.fetchCauses(),
      builder: (context, model, child) => model.isBusy
          ? Center(child: CircularProgressIndicator())
          : Shimmer(
              interval: Duration(hours: 1),
              child: RefreshIndicator(
                onRefresh: () => Future.value(1),
                child: ListView(
                  children: [
                    verticalSpaceRegular,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: screenWidthPercentage(context, percentage: 0.7),
                        child: description ?? Container(),
                      ),
                    ),
                    verticalSpaceMediumLarge,
                    if (type == CausesFilterListType.Themes)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: model.projects!.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Container() // add a list with the project themes
                          // child: GlobalGivingProjectCardMobile(
                          //   project: model.projects![index],
                          //   onTap: () async =>
                          //       await model.navigateToProjectScreen(index),
                          //   onTapFavorite: model.showNotImplementedSnackbar,
                          // ),
                        ),
                      ),
                    if (type == CausesFilterListType.GoodWalletFund)
                      ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: model.goodWalletFunds!.length,
                          itemBuilder: (context, index) {
                            GoodWalletFundModel fund =
                                model.goodWalletFunds![index];
                            Alignment alignment =
                                fund.title == "Friend Referral Fund"
                                    ? Alignment.bottomCenter
                                    : Alignment.center;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: GoodWalletFundCardMobile(
                                fund: fund,
                                onTap: model.showNotImplementedSnackbar,
                                imageAlignment: alignment,
                                backgroundImage: AssetImage(fund.imagePath!),
                              ),
                            );
                          })
                  ],
                ),
              ),
            ),
    );
  }
}