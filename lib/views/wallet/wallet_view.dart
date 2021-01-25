import 'package:flutter/material.dart';
import 'package:good_wallet/app/locator.dart';
import 'package:good_wallet/enums/user_status.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:good_wallet/viewmodels/wallet_view_model.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class WalletView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ViewModelBuilder<WalletViewModel>.reactive(
      viewModelBuilder: () => locator<WalletViewModel>(),
      onModelReady: (model) async {
        await model.updateBalances();
        await model.listenToTransactions();
      },
      fireOnModelReadyOnce: true,
      disposeViewModel: false,
      builder: (context, model, child) => model.userStatus ==
              UserStatus.SignedIn
          ? CenteredView(
              maxWidth: 400,
              child: ListView(
                //crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: screenSize.height / 12),
                  _buildFullName(model.currentUser.fullName),
                  //_buildMemberSinceText(context),
                  verticalSpace(10),
                  _buildSeparator(screenSize),
                  verticalSpace(10),
                  _buildStatView(model),
                  verticalSpace(20),
                  //_buildTransferButton(model),
                  verticalSpace(20),
                  Text("Transaction History", style: TextStyle(fontSize: 25)),
                  _buildTransactionHistoryView(model),
                  //_buildRecentActivities(model.currentUser),
                ],
              ),
            )
          : _loginButton(() async => await model.loginWithGoogle()),
    );
  }

  _buildFullName(String name) {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );
    return Center(
      child: Text(
        "Hi, ${name}",
        style: _nameTextStyle,
      ),
    );
  }

  _buildSeparator(Size screenSize) {
    return Container(
        width: 300,
        height: 2.0,
        color: Colors.black54,
        margin: EdgeInsets.only(top: 4.0));
  }

  _buildStatView(var model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Balance: ${model.balance * 0.01} \$",
            style: TextStyle(fontSize: 22)),
        Text("Donated: ${model.donations * 0.01} \$",
            style: TextStyle(fontSize: 22)),
        Text("Donated Implicitly: ${model.implicitDonations * 0.01} \$",
            style: TextStyle(fontSize: 22)),
      ],
    );
  }

  _buildTransferButton(dynamic model) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: Colors.lightBlue,
      elevation: 10.0,
      onPressed: () => model.navigateToSendMoneyView(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("Send Money",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
    );
  }

  _loginButton(Function onPressed) {
    return Column(
      children: [
        Container(
          child: FlatButton(
            onPressed: onPressed,
            child: Text(
              "Login with Google",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.lightBlue,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        Text("Login to see your wallet"),
      ],
    );
  }

  _buildTransactionHistoryView(dynamic model) {
    return model.transactions != null
        ? ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              var hist = model.transactions[index];
              var incoming = (hist.recipientName == model.currentUser.fullName);
              var color = incoming ? Colors.lightGreen : Colors.redAccent;
              var amountFormatted = incoming
                  ? "\$ ${hist.amount * 0.01}"
                  : "- \$ ${hist.amount * 0.01}";
              var nameToDisplay =
                  incoming ? hist.senderName : hist.recipientName;
              if (hist.topUp != null) {
                if (hist.topUp) {
                  nameToDisplay = "Committed for good";
                }
              }
              return Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Card(
                  elevation: 2,
                  child: ListTile(
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
                            .add_jm()
                            .format(hist.createdAt.toDate()))
                        : Text(""),
                    trailing:
                        Text(amountFormatted, style: TextStyle(color: color)),
                  ),
                ),
              );
            },
            itemCount: model.transactions.length)
        : model.isBusy
            ? Center(child: CircularProgressIndicator())
            : Center(child: Text("No transactions on record!"));
  }
}
