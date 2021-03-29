import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/profile/transaction_history_viewmodel.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:stacked/stacked.dart';

class TransactionHistoryView extends StatelessWidget {
  const TransactionHistoryView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TransactionHistoryViewModel>.reactive(
      viewModelBuilder: () => TransactionHistoryViewModel(),
      onModelReady: (model) => model.listenToTransactions(),
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: LayoutSettings.horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerLeft,
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                  onPressed: model.navigateBack,
                ),
                Text(
                  "Transaction History",
                  style: TextStyle(fontSize: 34),
                ),
                verticalSpaceMediumLarge,
                model.transactions == null
                    ? model.isBusy
                        ? Center(child: CircularProgressIndicator())
                        : Center(child: Text("No transactions on record!"))
                    : Shimmer(
                        interval: Duration(hours: 1),
                        enabled: true,
                        child: ListView.builder(
                          itemCount: model.transactions.length > 3
                              ? 3
                              : model.transactions.length,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, index) {
                            var hist = model.transactions[index];
                            var incoming = (hist.recipientName ==
                                model.currentUser.fullName);
                            var color = incoming
                                ? MyColors.paletteTurquoise
                                : Colors.grey[700];
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
                                  trailing: Text(amountFormatted,
                                      style: TextStyle(color: color)),
                                ),
                                Divider(
                                  color: Colors.grey[500],
                                  thickness: 0.5,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
