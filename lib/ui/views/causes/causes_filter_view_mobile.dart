import 'package:flutter/material.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/ui/layout_widgets/tabbar_layout.dart';
import 'package:good_wallet/ui/views/causes/causes_filter_viewmodel.dart';
import 'package:good_wallet/ui/views/causes/causes_viewmodel.dart';
import 'package:good_wallet/ui/widgets/small_wallet_card.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
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
              child: Tab(text: "Projects")),
          Container(
              width: screenWidth(context) * 0.3,
              child: Tab(text: "Good Wallet Funds")),
          Container(
              width: screenWidth(context) * 0.25,
              child: Tab(text: "Favorites")),
        ],
        views: [],
      ),
    );
  }
}