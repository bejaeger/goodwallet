import 'package:flutter/material.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/enums/transaction_type.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/shared/transactions_history_entry_style.dart';
import 'package:good_wallet/ui/views/transaction_history/transaction_history_viewmodel.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:stacked/stacked.dart';

class TransactionHistoryView extends StatefulWidget {
  final TransactionType historyType; // used for initial value of tab controller
  const TransactionHistoryView(
      {Key key, this.historyType = TransactionType.InOrOut})
      : super(key: key); //
  @override
  _TransactionHistoryViewState createState() => _TransactionHistoryViewState();
}

class _TransactionHistoryViewState extends State<TransactionHistoryView>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 4, vsync: this, initialIndex: widget.historyType.index);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TransactionHistoryViewModel>.reactive(
      viewModelBuilder: () => locator<TransactionHistoryViewModel>(),
      disposeViewModel: false,
      fireOnModelReadyOnce: true,
      onModelReady: (model) async {
        await model.initialize();
      },
      builder: (context, model, child) => model.isBusy
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
              appBar: AppBar(
                title: Text("Donations & Transactions History"),
                bottom: PreferredSize(
                  preferredSize: Size(screenWidth(context), 60.0),
                  child: Container(
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      tabs: [
                        Container(
                            width: screenWidth(context) * 0.2,
                            child: Tab(text: "Good Wallet")),
                        Container(
                            width: screenWidth(context) * 0.2,
                            child: Tab(text: "Gifted")),
                        Container(
                          width: screenWidth(context) * 0.2,
                          child: Row(
                            children: <Widget>[
                              Tab(text: "Donations"),
                              // SizedBox(width: 5),
                              // Tab(
                              //   icon: CircleAvatar(
                              //     backgroundColor: Colors.white,
                              //     child: Text(
                              //       "2",
                              //       style: TextStyle(
                              //           fontSize: 10.0,
                              //           color: Theme.of(context).primaryColor),
                              //     ),
                              //     radius: 10,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        Container(
                            width: screenWidth(context) * 0.2,
                            child: Tab(text: "Raised")),
                      ],
                    ),
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: LayoutSettings.horizontalPadding),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    TransactionsHistoryLayout(
                      type: TransactionType.InOrOut,
                      listOfTransactions: model.listOfWalletTransactions,
                      description: Text(
                          "Your Good Wallet's incoming and outgoing transactions"),
                      mainStatisticDisplay: Text(
                          "Balance: \$ " +
                              (model.userWallet.currentBalance / 100)
                                  .toString(),
                          style: textTheme(context)
                              .headline2
                              .copyWith(fontSize: 28)),
                    ),
                    TransactionsHistoryLayout(
                      type: TransactionType.TransferredToPeers,
                      listOfTransactions: model.listOfTransactionsToPeers,
                      description: Text("Money you gifted to friends"),
                      mainStatisticDisplay: Text(
                          "Total gifted: \$ " +
                              (model.userWallet.transferredToPeers / 100)
                                  .toString(),
                          style: textTheme(context)
                              .headline2
                              .copyWith(fontSize: 28)),
                    ),
                    TransactionsHistoryLayout(
                      type: TransactionType.Donation,
                      listOfTransactions: model.listOfDonations,
                      description: Text("History of your charitable givings"),
                      mainStatisticDisplay: Text(
                          "Total donations: \$ " +
                              (model.userWallet.donations / 100).toString(),
                          style: textTheme(context)
                              .headline2
                              .copyWith(fontSize: 28)),
                    ),
                    TransactionsHistoryLayout(
                      type: TransactionType.Incoming,
                      listOfTransactions: model.listOfIncomingTransactions,
                      description:
                          Text("Money you raised into your Good Wallet"),
                      mainStatisticDisplay: Text("Total raised: \$ TBI",
                          style: textTheme(context)
                              .headline2
                              .copyWith(fontSize: 28)),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class TransactionsHistoryLayout extends StatelessWidget {
  final TransactionType type;
  final List<dynamic> listOfTransactions;
  final Widget mainStatisticDisplay;
  final int maximumLength;
  final String userName;
  final Widget description;

  const TransactionsHistoryLayout(
      {Key key,
      @required this.type,
      @required this.listOfTransactions,
      this.mainStatisticDisplay,
      this.maximumLength = 5,
      this.userName,
      this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TransactionHistoryViewModel>.reactive(
      viewModelBuilder: () => locator<TransactionHistoryViewModel>(),
      disposeViewModel: false,
      fireOnModelReadyOnce: true,
      builder: (context, model, child) => listOfTransactions == null
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
                        child: mainStatisticDisplay ?? Container(),
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
                    listOfTransactions == null
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: listOfTransactions.length > maximumLength
                                ? maximumLength
                                : listOfTransactions.length,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemBuilder: (context, index) {
                              return TransactionListTile(
                                transactionData: listOfTransactions[index],
                                style: model.getTransactionsHistoryEntryStyle(
                                    listOfTransactions[index]),
                              );
                            },
                          ),
                  ],
                ),
              ),
            ),
    );
  }
}

class TransactionListTile extends StatelessWidget {
  final dynamic transactionData;
  final TransactionHistoryEntryStyle style;

  const TransactionListTile(
      {Key key, @required this.transactionData, @required this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var amountFormatted = "\$ ${transactionData.amount * 0.01}";
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
}
