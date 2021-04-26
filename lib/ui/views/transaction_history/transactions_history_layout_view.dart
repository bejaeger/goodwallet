import 'package:flutter/material.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/enums/transaction_type.dart';
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
  final TransactionType type;
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
      viewModelBuilder: () => locator<TransactionHistoryLayoutViewModel>(),
      disposeViewModel: false,
      onModelReady: (model) async {
        model.initialize();
      },
      fireOnModelReadyOnce: true,
      builder: (context, model, child) => model
              .getTransactionsCorrespondingToType(type)!
              .isEmpty
          ? model.isBusy
              ? Center(child: CircularProgressIndicator())
              : Center(child: Text("No transactions on record!"))
          : ConstrainedWidthLayout(
              child: Shimmer(
                interval: Duration(hours: 1),
                child: RefreshIndicator(
                  onRefresh: () => model.initialize(type),
                  child: ListView(
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
                        itemCount: model
                                    .getTransactionsCorrespondingToType(type)!
                                    .length >
                                maximumLength
                            ? maximumLength
                            : model
                                .getTransactionsCorrespondingToType(type)!
                                .length,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (context, index) {
                          return TransactionListTile(
                            transactionData:
                                model.getTransactionsCorrespondingToType(
                                    type)![index],
                            inferEntryTypeFunction: model.inferTransactionType,
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
}

class TransactionListTile extends StatelessWidget {
  final dynamic transactionData;
  final Function inferEntryTypeFunction;

  const TransactionListTile(
      {Key? key,
      required this.transactionData,
      required this.inferEntryTypeFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var amountFormatted = "\$ ${transactionData.amount * 0.01}";
    TransactionHistoryEntryStyle style =
        _getTransactionsCorrespondingToTypeHistoryEntryStyle(
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
            DateFormat.MMMEd().format(transactionData.createdAt.toDate()),
            style: textTheme(context).bodyText2!.copyWith(
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

  _getTransactionsCorrespondingToTypeHistoryEntryStyle(TransactionType? type) {
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
