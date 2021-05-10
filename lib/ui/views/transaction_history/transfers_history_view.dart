import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
import 'package:good_wallet/enums/transfer_type.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/image_icon_paths.dart';
import 'package:good_wallet/ui/shared/transfer_history_entry_style.dart';
import 'package:good_wallet/ui/views/transaction_history/transfers_history_viewmodel.dart';
import 'package:good_wallet/ui/widgets/custom_app_bar_small.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:stacked/stacked.dart';

class TransfersHistoryView extends StatelessWidget {
  const TransfersHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TransfersHistoryViewModel>.reactive(
      viewModelBuilder: () => TransfersHistoryViewModel(),
      initialiseSpecialViewModelsOnce: true,
      builder: (context, model, child) => ConstrainedWidthWithScaffoldLayout(
        child: Shimmer(
          interval: Duration(hours: 1),
          child: CustomScrollView(
            key: PageStorageKey('storage-key'),
            slivers: [
              CustomSliverAppBarSmall(
                title: "Your Recent Activities",
                onRightIconPressed: model.showNotImplementedSnackbar,
                rightIcon: Icon(Icons.search_rounded, size: 28),
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
                            transaction: data,
                            style:
                                _getTransactionsCorrespondingToTypeHistoryEntryStyle(
                                    data, model.inferTransactionType(data)),
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

  TransferHistoryEntryStyle
      _getTransactionsCorrespondingToTypeHistoryEntryStyle(
          MoneyTransfer data, TransferType type) {
    return data.map(
      donation: (value) => TransferHistoryEntryStyle(
        color: ColorSettings.primaryColor,
        descriptor: "Donated to",
        nameToDisplay: value.transferDetails.recipientName,
        icon:
            Icon(Icons.favorite, color: ColorSettings.whiteTextColor, size: 22),
      ),
      peer2peer: (value) => TransferHistoryEntryStyle(
        color: type == TransferType.Peer2PeerSent
            ? MyColors.paletteBlue
            : MyColors.paletteTurquoise,
        descriptor:
            type == TransferType.Peer2PeerSent ? "Gifted to" : "Received from",
        nameToDisplay: type == TransferType.Peer2PeerSent
            ? value.transferDetails.recipientName
            : value.transferDetails.senderName,
        icon: Image.asset(ImageIconPaths.huggingPeople,
            height: 18, color: ColorSettings.whiteTextColor),
      ),
      moneyPoolContribution: (value) => TransferHistoryEntryStyle(
        color: MyColors.paletteGreen,
        descriptor: "Contributed to money pool",
        nameToDisplay: value.moneyPoolInfo.name,
        icon: Icon(Icons.people_rounded, color: ColorSettings.whiteTextColor),
      ),
      moneyPoolPayoutTransfer: (value) => TransferHistoryEntryStyle(
        color: MyColors.paletteGreen,
        descriptor: "From money pool",
        nameToDisplay: value.moneyPoolInfo.name,
        icon: Icon(Icons.people_rounded, color: ColorSettings.whiteTextColor),
      ),
    );
  }
}

class TransferListTile extends StatelessWidget {
  final num amount;
  final TransferHistoryEntryStyle style;
  final MoneyTransfer transaction;

  const TransferListTile(
      {Key? key,
      required this.amount,
      required this.style,
      required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          leading: CircleAvatar(
              backgroundColor: style.color.withOpacity(0.9), child: style.icon),
          // FlutterLogo(),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (style.descriptor != null)
                Text(
                  style.descriptor!,
                  style: textTheme(context).bodyText2!.copyWith(
                        fontSize: 15,
                      ),
                ),
              Text(style.nameToDisplay!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme(context).headline6!.copyWith(fontSize: 16)),
            ],
          ),
          // @see https://api.flutter.dev/flutter/intl/DateFormat-class.html
          //.add_jm()
          subtitle: Text(
            formatDate(transaction.createdAt.toDate()),
            style: textTheme(context).bodyText2!.copyWith(
                  fontSize: 15,
                ),
          ),
          trailing:
              Text(formatAmount(amount), style: TextStyle(color: style.color)),
        ),
        Divider(
          color: Colors.grey[500],
          thickness: 0.5,
        ),
      ],
    );
  }
}
