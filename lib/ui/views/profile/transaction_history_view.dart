import 'package:flutter/material.dart';
import 'package:good_wallet/enums/transaction_type.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/profile/transaction_history_viewmodel.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:stacked/stacked.dart';

class TransactionHistoryView extends StatefulWidget {
  @override
  _TransactionHistoryViewState createState() => _TransactionHistoryViewState();
}

class _TransactionHistoryViewState extends State<TransactionHistoryView>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TransactionHistoryViewModel>.reactive(
      viewModelBuilder: () => TransactionHistoryViewModel(),
      onModelReady: (model) async {
        await model.listenToTransactions();
        await model.listenToWalletTransactions();
        return null;
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text("Donations & Transactions"),
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
                      child: Tab(text: "Raised & Pledged")),
                  // Container(
                  //     width: screenWidth(context) * 0.2,
                  //     child: Tab(text: "Pledged")),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: LayoutSettings.horizontalPadding),
          child: model.transactions == null
              ? model.isBusy
                  ? Center(child: CircularProgressIndicator())
                  : Center(child: Text("No transactions on record!"))
              : //formattedListOfTransactions(model),
              TabBarView(
                  controller: _tabController,
                  children: [
                    formattedListOfTransactions(
                        context, model, TransactionType.InOrOut),
                    formattedListOfTransactions(
                        context, model, TransactionType.Outgoing),
                    formattedListOfTransactions(
                        context, model, TransactionType.InOrTransferred),
                    // formattedListOfTransactions(
                    //     model, TransactionType.TransferredToPeers),
                  ],
                ),
        ),
      ),
    );
  }

  Widget formattedListOfTransactions(BuildContext context,
      TransactionHistoryViewModel model, TransactionType type) {
    return Shimmer(
      interval: Duration(hours: 1),
      child: ListView(
        children: [
          verticalSpaceRegular,
          if (type == TransactionType.InOrOut)
            Card(
              margin: const EdgeInsets.all(0.0),
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.white,
              child: Container(
                padding:
                    const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 10.0),
                width: screenWidthWithoutPadding(context) - 8.0,
                child: Text(
                    "Balance: \$ " +
                        (model.userWallet.currentBalance / 100).toString(),
                    style: textTheme(context).headline2.copyWith(fontSize: 28)),
              ),
            ),
          verticalSpaceRegular,
          if (type == TransactionType.InOrOut)
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: screenWidthPercentage(context, percentage: 0.7),
                child: Text(
                    "Your Good Wallet's incoming and outgoing transactions"),
              ),
            ),
          verticalSpaceMediumLarge,
          ListView.builder(
            itemCount:
                model.transactions.length > 3 ? 3 : model.transactions.length,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              if (type == TransactionType.InOrTransferred) {
                var hist = model.transactions[index];
                var incoming =
                    (hist.recipientName == model.currentUser.fullName);
                var color =
                    incoming ? MyColors.paletteTurquoise : Colors.grey[700];
                var amountFormatted = "\$ ${hist.amount * 0.01}";
                var nameToDisplay =
                    incoming ? hist.senderName : hist.recipientName;
                if (hist.topUp != null) {
                  if (hist.topUp) {
                    nameToDisplay = "Committed for good";
                  }
                }
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      leading: CircleAvatar(
                        backgroundColor: color,
                        child: Text('${hist.recipientName[0]}',
                            style: TextStyle(color: Colors.white)),
                      ),
                      // FlutterLogo(),
                      title: Text(nameToDisplay),
                      subtitle: hist.createdAt != null
                          //https://api.flutter.dev/flutter/intl/DateFormat-class.html
                          ? Text(DateFormat.MMMEd()
                              //.add_jm()
                              .format(hist.createdAt.toDate()))
                          : Text(""),
                      trailing:
                          Text(amountFormatted, style: TextStyle(color: color)),
                    ),
                    Divider(
                      color: Colors.grey[500],
                      thickness: 0.5,
                    ),
                  ],
                );
              } else if (type == TransactionType.InOrOut) {
                var hist = model.walletTransactions[index];
                bool isDonation;
                try {
                  var pName_tmp = hist.projectName;
                  isDonation = true;
                } catch (e) {
                  isDonation = false;
                }

                var color = isDonation
                    ? MyColors.primaryRed
                    : MyColors.paletteTurquoise;
                var amountFormatted = "\$ ${hist.amount * 0.01}";
                var descriptionToDisplay =
                    isDonation ? "Donated to" : "Received from";
                var nameToDisplay =
                    isDonation ? hist.projectName : hist.senderName;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      leading: CircleAvatar(
                        backgroundColor: color.withOpacity(0.9),
                        child: isDonation
                            ? Icon(Icons.favorite,
                                color: ColorSettings.primaryColorLight)
                            : Icon(Icons.people_rounded,
                                color: ColorSettings.whiteTextColor),
                      ),
                      // FlutterLogo(),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (descriptionToDisplay != null)
                            Text(
                              descriptionToDisplay,
                              style: textTheme(context).bodyText2.copyWith(
                                    fontSize: 15,
                                  ),
                            ),
                          Text(nameToDisplay,
                              style: textTheme(context)
                                  .headline6
                                  .copyWith(fontSize: 16)),
                        ],
                      ),
                      subtitle: hist.createdAt != null
                          //https://api.flutter.dev/flutter/intl/DateFormat-class.html
                          ? Text(
                              DateFormat.MMMEd()
                                  //.add_jm()
                                  .format(hist.createdAt.toDate()),
                              style: textTheme(context).bodyText2.copyWith(
                                    fontSize: 15,
                                  ),
                            )
                          : Text(""),
                      trailing:
                          Text(amountFormatted, style: TextStyle(color: color)),
                    ),
                    Divider(
                      color: Colors.grey[500],
                      thickness: 0.5,
                    ),
                  ],
                );
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
