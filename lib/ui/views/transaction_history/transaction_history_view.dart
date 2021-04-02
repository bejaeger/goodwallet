import 'package:flutter/material.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/enums/transaction_type.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/shared/transactions_history_entry_style.dart';
import 'package:good_wallet/ui/views/transaction_history/transaction_history_viewmodel.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:stacked/stacked.dart';

// Setting up
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
    return Scaffold(
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
              description:
                  Text("Your Good Wallet's incoming and outgoing transactions"),
            ),
            TransactionsHistoryLayout(
              type: TransactionType.TransferredToPeers,
              description: Text("Money you gifted to friends"),
            ),
            TransactionsHistoryLayout(
              type: TransactionType.Donation,
              description: Text("History of your charitable givings"),
            ),
            TransactionsHistoryLayout(
              type: TransactionType.Incoming,
              description: Text("Money you raised into your Good Wallet"),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionsHistoryLayout extends StatelessWidget {
  final TransactionType type;
  final int maximumLength;
  final String userName;
  final Widget description;

  const TransactionsHistoryLayout(
      {Key key,
      @required this.type,
      this.maximumLength = 5,
      this.userName,
      this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TransactionHistoryViewModel>.reactive(
      viewModelBuilder: () => locator<TransactionHistoryViewModel>(),
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
                    model.getTransactions(type) == null
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: model.getTransactions(type).length >
                                    maximumLength
                                ? maximumLength
                                : model.getTransactions(type).length,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemBuilder: (context, index) {
                              return TransactionListTile(
                                transactionData:
                                    model.getTransactions(type)[index],
                                style: model.getTransactionsHistoryEntryStyle(
                                    model.getTransactions(type)[index]),
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
          "Balance: \$ " + (model.userWallet.donations / 100).toString(),
          style: textStyle);
    } else if (type == TransactionType.Incoming) {
      return Text("Balance: TBI", style: textStyle);
      ;
    } else if (type == TransactionType.TransferredToPeers) {
      return Text(
          "Balance: \$ " +
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
