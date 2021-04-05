import 'package:flutter/material.dart';
import 'package:good_wallet/enums/transaction_type.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/transaction_history/transactions_history_layout_view.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

// Might want to refactor the transaction view setup a little still

// TransactionsView (does not have a viewmodel assigned to it at the moment)
// sets up the layout of the transactions view with the tab bar view

class TransactionsView extends StatefulWidget {
  final TransactionType historyType; // used for initial value of tab controller
  const TransactionsView({Key key, this.historyType = TransactionType.InOrOut})
      : super(key: key); //
  @override
  _TransactionsViewState createState() => _TransactionsViewState();
}

class _TransactionsViewState extends State<TransactionsView>
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
          preferredSize:
              Size(screenWidth(context), LayoutSettings.tabBarPreferredHeight),
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
            TransactionsHistoryLayoutView(
              type: TransactionType.InOrOut,
              description:
                  Text("Your Good Wallet's incoming and outgoing transactions"),
            ),
            TransactionsHistoryLayoutView(
              type: TransactionType.TransferredToPeers,
              description: Text("Money you gifted to friends"),
            ),
            TransactionsHistoryLayoutView(
              type: TransactionType.Donation,
              description: Text("History of your charitable givings"),
            ),
            TransactionsHistoryLayoutView(
              type: TransactionType.Incoming,
              description: Text("Money you raised into your Good Wallet"),
            ),
          ],
        ),
      ),
    );
  }
}
