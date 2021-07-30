import 'package:flutter/material.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/money_transfers/money_transfer_style_helpers.dart';
import 'package:good_wallet/ui/shared/money_transfers/transfer_list_tile.dart';
import 'package:good_wallet/ui/shared/style_settings.dart';
import 'package:good_wallet/ui/views/transaction_history/transfers_history_viewmodel.dart';
import 'package:good_wallet/ui/widgets/custom_app_bar_small.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:stacked/stacked.dart';

class TransfersHistoryView extends StatelessWidget {
  const TransfersHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TransfersHistoryViewModel>.reactive(
      viewModelBuilder: () => TransfersHistoryViewModel(),
      onModelReady: (model) => model.listenToData(),
      builder: (context, model, child) => ConstrainedWidthWithScaffoldLayout(
        child: Shimmer(
          interval: Duration(hours: 1),
          child: CustomScrollView(
            key: PageStorageKey('storage-key'),
            slivers: [
              CustomSliverAppBarSmall(
                title: "Recent Activities",
              ),
              SliverToBoxAdapter(child: SizedBox(height: 18)),
              model.transfers == null || model.transfers!.isEmpty
                  ? model.isBusy
                      ? SliverToBoxAdapter(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : SliverToBoxAdapter(
                          child: Center(
                            child: Text("No transfers on record!"),
                          ),
                        )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          var data = model.transfers![index];
                          return TransferListTile(
                            onTap: () =>
                                model.showMoneyTransferInfoDialog(data),
                            transaction: data,
                            style:
                                getTransactionsCorrespondingToTypeHistoryEntryStyle(
                                    data: data,
                                    type: data.type,
                                    uid: model.currentUser.uid),
                            amount: data.transferDetails.amount,
                          );
                        },
                        childCount: model.transfers!.length,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
