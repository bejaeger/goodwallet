import 'package:flutter/material.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/enums/transaction_type.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/transactions_history_entry_style.dart';
import 'package:good_wallet/ui/views/transaction_history/transactions_history_layout_viewmodel.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:stacked/stacked.dart';

// This is the body of transactions view with the history entries

class TransactionsHistoryLayoutView extends StatelessWidget {
  final TransactionType type;
  final int maximumLength;
  final String userName;
  final Widget description;

  const TransactionsHistoryLayoutView(
      {Key key,
      @required this.type,
      this.maximumLength = 5,
      this.userName,
      this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TransactionHistoryLayoutViewModel>.reactive(
      viewModelBuilder: () => locator<TransactionHistoryLayoutViewModel>(),
      disposeViewModel: false,
      onModelReady: (model) async {
        model.initialize();
      },
      fireOnModelReadyOnce: true,
      builder: (context, model, child) => model.getTransactions(type).isEmpty
          ? model.isBusy
              ? Center(child: CircularProgressIndicator())
              : Center(child: Text("No transactions on record!"))
          : Shimmer(
              interval: Duration(hours: 1),
              child: RefreshIndicator(
                onRefresh: () => model.initialize(type),
                child: ListView(
                  children: [
                    verticalSpaceRegular,
                    Card(
                      margin: const EdgeInsets.all(0.0),
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.white,
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 15.0, bottom: 15.0, left: 10.0),
                        width: screenWidthWithoutPadding(context),
                        child: _getMainStatisticsDisplay(model, context) ??
                            Container(),
                      ),
                    ),
                    verticalSpaceRegular,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: screenWidthPercentage(context, percentage: 0.7),
                        child: description ?? Container(),
                      ),
                    ),
                    verticalSpaceMediumLarge,
                    ListView.builder(
                      itemCount:
                          model.getTransactions(type).length > maximumLength
                              ? maximumLength
                              : model.getTransactions(type).length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return TransactionListTile(
                          transactionData: model.getTransactions(type)[index],
                          inferEntryTypeFunction: model.inferTransactionType,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _getMainStatisticsDisplay(dynamic model, BuildContext context) {
    var textStyle = textTheme(context).headline2.copyWith(fontSize: 28);
    if (type == TransactionType.Donation) {
      return Text(
          "Total donations: \$ " +
              (model.userWallet.donations / 100).toString(),
          style: textStyle);
    } else if (type == TransactionType.Incoming) {
      return Text("Raised: TBI", style: textStyle);
      ;
    } else if (type == TransactionType.TransferredToPeers) {
      return Text(
          "Total gifted: \$ " +
              (model.userWallet.transferredToPeers / 100).toString(),
          style: textStyle);
    } else if (type == TransactionType.InOrOut) {
      return Text(
          "Balance: \$ " + (model.userWallet.currentBalance / 100).toString(),
          style: textStyle);
    }
    return null;
  }
}

class TransactionListTile extends StatelessWidget {
  final dynamic transactionData;
  final Function inferEntryTypeFunction;

  const TransactionListTile(
      {Key key,
      @required this.transactionData,
      @required this.inferEntryTypeFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var amountFormatted = "\$ ${transactionData.amount * 0.01}";
    TransactionHistoryEntryStyle style = _getTransactionsHistoryEntryStyle(
        inferEntryTypeFunction(transactionData));
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
                  style.descriptor,
                  style: textTheme(context).bodyText2.copyWith(
                        fontSize: 15,
                      ),
                ),
              Text(style.nameToDisplay,
                  style: textTheme(context).headline6.copyWith(fontSize: 16)),
            ],
          ),
          // @see https://api.flutter.dev/flutter/intl/DateFormat-class.html
          //.add_jm()
          subtitle: Text(
            DateFormat.MMMEd().format(transactionData.createdAt.toDate()),
            style: textTheme(context).bodyText2.copyWith(
                  fontSize: 15,
                ),
          ),
          trailing: Text(amountFormatted, style: TextStyle(color: style.color)),
        ),
        Divider(
          color: Colors.grey[500],
          thickness: 0.5,
        ),
      ],
    );
  }

  _getTransactionsHistoryEntryStyle(TransactionType type) {
    if (type == TransactionType.Donation) {
      return TransactionHistoryEntryStyle(
          color: ColorSettings.primaryColor,
          descriptor: "Donated to",
          nameToDisplay: transactionData.projectName,
          icon: Icon(Icons.favorite, color: ColorSettings.primaryColorLight));
    } else if (type == TransactionType.Incoming) {
      return TransactionHistoryEntryStyle(
          color: MyColors.paletteTurquoise,
          descriptor: "Reveiced from",
          nameToDisplay: transactionData.senderName,
          icon:
              Icon(Icons.people_rounded, color: ColorSettings.whiteTextColor));
    } else if (type == TransactionType.TransferredToPeers) {
      return TransactionHistoryEntryStyle(
          color: ColorSettings.primaryColorLight,
          descriptor: "Gifted to",
          nameToDisplay: transactionData.recipientName,
          icon: Icon(Icons.person, color: ColorSettings.whiteTextColor));
    }
    return null;
  }
}
