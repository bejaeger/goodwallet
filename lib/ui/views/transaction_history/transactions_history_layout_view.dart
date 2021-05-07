import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/money_pools/payouts/money_pool_payout.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
import 'package:good_wallet/enums/transfer_direction.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/transactions_history_entry_style.dart';
import 'package:good_wallet/ui/views/transaction_history/transactions_history_layout_viewmodel.dart';
import 'package:good_wallet/ui/widgets/show_balance_card.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:stacked/stacked.dart';

// This is the body of transactions view with the history entries

class TransactionsHistoryLayoutView extends StatelessWidget {
  final TransferDirection type;
  final int maximumLength;
  final String? userName;
  final String? description;

  const TransactionsHistoryLayoutView(
      {Key? key,
      required this.type,
      this.maximumLength = 25,
      this.userName,
      this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TransactionHistoryLayoutViewModel>.reactive(
      viewModelBuilder: () => TransactionHistoryLayoutViewModel(),
      //disposeViewModel: false,
      onModelReady: (model) async {
        await model.initialize(type);
      },
      //fireOnModelReadyOnce: true,
      builder: (context, model, child) => ConstrainedWidthLayout(
        child: Shimmer(
          interval: Duration(hours: 1),
          child: RefreshIndicator(
            onRefresh: () async => await model.initialize(type),
            child: model.getTransactionsCorrespondingToType(type)!.isEmpty
                ? model.isBusy
                    ? Center(child: CircularProgressIndicator())
                    : Center(child: Text("No transactions on record!"))
                : ListView(
                    physics: AlwaysScrollableScrollPhysics(),
                    children: [
                      verticalSpaceRegular,
                      ShowBalanceCard(
                        balance: model.getBalanceCorrespondingToType(type),
                        title: model.getTitleCorrespondingToType(type),
                        //height: 90,
                        shortDescription: description,
                      ),
                      verticalSpaceMedium,
                      ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: model
                                    .getTransactionsCorrespondingToType(type)!
                                    .length >
                                maximumLength
                            ? maximumLength
                            : model
                                .getTransactionsCorrespondingToType(type)!
                                .length,
                        itemBuilder: (context, index) {
                          var data = model
                              .getTransactionsCorrespondingToType(type)![index];
                          return TransactionListTile(
                            transaction: data,
                            style:
                                _getTransactionsCorrespondingToTypeHistoryEntryStyle(
                                    data, model.inferTransactionType(data)),
                            amount: model.getAmount(data),
                          );
                        },
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  _getTransactionsCorrespondingToTypeHistoryEntryStyle(
      dynamic data, TransferDirection direction) {
    TransactionHistoryEntryStyle style;

    if (data is MoneyPoolPayout) {
      style = TransactionHistoryEntryStyle(
        color: MyColors.paletteGreen,
        descriptor: "From money pool",
        // get the correct transaction here
        nameToDisplay: data.moneyPool.name,
        icon: Icon(Icons.people_rounded, color: ColorSettings.whiteTextColor),
      );
    } else {
      style = data.maybeMap(
          donation: (value) => TransactionHistoryEntryStyle(
                color: ColorSettings.primaryColor,
                descriptor: "Donated to",
                nameToDisplay: value.transferDetails.recipientName,
                icon: Icon(Icons.favorite,
                    color: ColorSettings.primaryColorLight),
              ),
          peer2peer: (value) => TransactionHistoryEntryStyle(
                color: direction == TransferDirection.TransferredToPeers
                    ? ColorSettings.primaryColorLight
                    : MyColors.paletteTurquoise,
                descriptor: direction == TransferDirection.TransferredToPeers
                    ? "Gifted to"
                    : "Received from",
                nameToDisplay: direction == TransferDirection.TransferredToPeers
                    ? value.transferDetails.recipientName
                    : value.transferDetails.senderName,
                icon: direction == TransferDirection.TransferredToPeers
                    ? Icon(Icons.person, color: ColorSettings.whiteTextColor)
                    : Icon(Icons.people_rounded,
                        color: ColorSettings.whiteTextColor),
              ),
          moneyPoolContribution: (value) => null,
          orElse: () => null);
    }
    return style;
  }
}

class TransactionListTile extends StatelessWidget {
  final num amount;
  final TransactionHistoryEntryStyle style;
  final dynamic transaction;

  const TransactionListTile(
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
