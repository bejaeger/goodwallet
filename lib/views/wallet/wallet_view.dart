import 'package:flutter/material.dart';
import 'package:good_wallet/app/locator.dart';
import 'package:good_wallet/enums/user_status.dart';
import 'package:good_wallet/style/colors.dart';
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
        await model.listenToBalance();
        await model.listenToTransactions();
      },
      fireOnModelReadyOnce: true,
      disposeViewModel: false,
      builder: (context, model, child) => Scaffold(
        backgroundColor: backgroundColor,
        body: model.userStatus != UserStatus.SignedIn
            ? Container()
            : CenteredView(
                maxWidth: MediaQuery.of(context).size.width / 1.2,
                child: ListView(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  //mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: screenSize.height / 14),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildFullName(model.currentUser.fullName),
                              verticalSpace(20),
                              _buildStatView(model),
                              verticalSpace(20),
                              _buildDonationView(model),
                              _buildSeparator(screenSize),
                              _buildFeed(model),
                            ],
                          ),
                        ),
                        Spacer(flex: 1),
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildTransferButton(model),
                              verticalSpace(30),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15.0, bottom: 15.0),
                                child: Text("Send Again",
                                    style: TextStyle(fontSize: 20)),
                              ),
                              _buildSendAgain(model),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15.0, bottom: 15.0),
                                child: Text("Transaction History",
                                    style: TextStyle(fontSize: 20)),
                              ),
                              _buildTransactionHistoryView(model),
                            ],
                          ),
                        ),
                      ],
                    ),
                    //_buildMemberSinceText(context),
                  ],
                ),
              ),
      ),
    );
  }

  _buildFullName(String name) {
    TextStyle _nameTextStyle = TextStyle(
      color: Colors.grey[850],
      fontSize: 35.0,
      fontWeight: FontWeight.w700,
    );
    return Text(
      "Hi ${name.split(" ")[0]}!",
      style: _nameTextStyle,
    );
  }

  _buildSeparator(Size screenSize) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 45),
        child: Container(
            width: 400,
            height: 1.0,
            color: Colors.grey[700],
            margin: EdgeInsets.only(top: 4.0)),
      ),
    );
  }

  _buildStatView(var model) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Good Dollars Credit",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
              ),
            ),
            Text(
              "${model.thisbalance * 0.01}.00 \$",
              style: TextStyle(
                fontSize: 40,
                color: Colors.grey[850],
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: CallToActionButtonRound(
                      color: ATLASred,
                      onPressed: model.navigateToSendMoneyView,
                      text: "Commit",
                      icon: Icon(Icons.arrow_circle_up),
                    ),
                  ),
                  Spacer(flex: 1),
                  Expanded(
                    flex: 1,
                    child: CallToActionButtonRound(
                      color: Colors.blue,
                      onPressed: model.navigateToSendMoneyView,
                      text: "Receive",
                      icon: Icon(Icons.call_received),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildDonationView(var model) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "You gave already",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
              ),
            ),
            verticalSpace(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "${model.donations * 0.01}.00 \$",
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.grey[850],
                        ),
                      ),
                      Text(
                        "to good causes",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "${model.implicitDonations * 0.01}.00 \$",
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.grey[850],
                        ),
                      ),
                      Text(
                        "to peers",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildFeed(dynamic model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FeedCard(
            title: "Commit for good",
            supportingText: "Top up your account and commit money for good",
            actionButtonText: "#commitforgood",
            imageLocation: "images/hand-with-heart.jpg"),
        verticalSpace(20),
        FeedCard(
            title: "Get payed for good",
            supportingText:
                "Next time a friend pays you back ask for good dollars instead",
            actionButtonText: "#getpayedforgood",
            imageLocation: "images/hand-shake-on-yellow.jpg"),
      ],
    );
  }

  _buildTransferButton(dynamic model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: CallToActionButtonRound(
            color: ATLASred,
            onPressed: model.navigateToSendMoneyView,
            text: "Give Money",
            icon: Icon(Icons.favorite),
          ),
        ),
        Expanded(
          child: CallToActionButtonRound(
            color: Colors.blue,
            onPressed: model.navigateToSendMoneyView,
            text: "Send Money",
            icon: Icon(Icons.send),
          ),
        ),
      ],
    );
  }

  _buildSendAgain(dynamic model) {
    return model.transactions != null
        ? Container(
            height: 120,
            child: ListView.separated(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: model.transactions.length,
              separatorBuilder: (BuildContext context, int index) =>
                  Container(width: 20),
              itemBuilder: (context, index) {
                dynamic hist = model.transactions[index];
                return SizedBox(
                  width: 64,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CircleAvatar(
                            radius: 32,
                            backgroundColor: Colors.blue[200],
                            child: Text(hist.recipientName[0])),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: Text(hist.recipientName,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        : Container();
  }

  _buildTransactionHistoryView(dynamic model) {
    return model.transactions != null
        ? ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              var hist = model.transactions[index];
              var incoming = (hist.recipientName == model.currentUser.fullName);
              var color = incoming ? ATLASgreen : Colors.grey[700];
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
              return ListTile(
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
                trailing: Text(amountFormatted, style: TextStyle(color: color)),
              );
            },
            itemCount: model.transactions.length)
        : model.isBusy
            ? Center(child: CircularProgressIndicator())
            : Center(child: Text("No transactions on record!"));
  }
}

class FeedCard extends StatelessWidget {
  final String title;
  final String actionButtonText;
  final String imageLocation;
  final String supportingText;

  const FeedCard(
      {Key key,
      this.title,
      this.actionButtonText,
      this.imageLocation,
      this.supportingText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imageLocation),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(supportingText,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              FlatButton(
                textColor: ATLASblue,
                onPressed: () {
                  // Perform some action
                },
                child: Text(actionButtonText),
              ),
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  // Perform some action
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CallToActionButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  const CallToActionButton({Key key, this.onPressed, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            Text(text, style: TextStyle(fontSize: 16, color: Colors.grey[100])),
      ),
    );
  }
}

class CallToActionButtonRound extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Icon icon;
  final Color color;

  const CallToActionButtonRound(
      {Key key, this.onPressed, this.text, this.icon, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: color,
          child: IconButton(
            icon: icon,
            color: Colors.white,
            onPressed: onPressed,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[800], fontSize: 15)),
        ),
      ],
    );
  }
}
