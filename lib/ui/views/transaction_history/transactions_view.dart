import 'package:flutter/material.dart';
import 'package:good_wallet/enums/transaction_type.dart';
import 'package:good_wallet/ui/layout_widgets/tabbar_layout.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/transaction_history/transactions_history_layout_view.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

class TransactionsView extends StatelessWidget {
  final TransactionType historyType;

  const TransactionsView({Key? key, this.historyType = TransactionType.InOrOut})
      : super(key: key); // used for initial value of tab controller

  @override
  Widget build(BuildContext context) {
    return TabBarLayout(
      initialIndex: historyType.index,
      title: "Transactions History",
      titleSize: 20,
      tabs: [
        Container(
            width: screenWidth(context) * 0.2, child: Tab(text: "Good Wallet")),
        Container(
            width: screenWidth(context) * 0.2, child: Tab(text: "Gifted")),
        Container(
          width: screenWidth(context) * 0.2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
            width: screenWidth(context) * 0.2, child: Tab(text: "Raised")),
      ],
      views: [
        TransactionsHistoryLayoutView(
          type: TransactionType.InOrOut,
          description: "Your Good Wallet's incoming and outgoing transactions",
        ),
        TransactionsHistoryLayoutView(
          type: TransactionType.TransferredToPeers,
          description: "Money you gifted to friends",
        ),
        TransactionsHistoryLayoutView(
          type: TransactionType.Donation,
          description: "The total of your charitable givings",
        ),
        TransactionsHistoryLayoutView(
          type: TransactionType.Incoming,
          description: "Money you raised into your Good Wallet",
        ),
      ],
    );
  }
}
