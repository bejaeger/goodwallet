import 'package:flutter/material.dart';
import 'package:good_wallet/app/locator.dart';
import 'package:good_wallet/enums/user_status.dart';
import 'package:good_wallet/style/colors.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:good_wallet/viewmodels/wallet_view_model.dart';
import 'package:good_wallet/widgets/goodcauses/global_giving_project_card.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class WalletView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ViewModelBuilder<WalletViewModel>.reactive(
      viewModelBuilder: () => locator<WalletViewModel>(),
      onModelReady: (model) async {
        model.getProjects();
        model.updateBalances();
        model.listenToBalances();
        model.listenToTransactions();
      },
      fireOnModelReadyOnce: true,
      disposeViewModel: false,
      builder: (context, model, child) => Scaffold(
        backgroundColor: backgroundColor,
        body: model.userStatus != UserStatus.SignedIn
            ? Container()
            : CenteredView(
                maxWidth: MediaQuery.of(context).size.width > 1000
                    ? 1000
                    : MediaQuery.of(context).size.width / 1.1,
                child: ListView(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  //mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: screenSize.height / 14),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFullName(model.currentUser.fullName),
                        verticalSpace(25),
                        _buildDonationBalanceView(model),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  verticalSpace(15),
                                  _buildStatView(model),
                                  verticalSpace(30),
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
                                  //_buildTransferButton(model),
                                  verticalSpace(15),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15.0, bottom: 20.0),
                                    child: Text("Send again",
                                        style: TextStyle(fontSize: 20)),
                                  ),
                                  _buildSendAgain(model),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15.0, bottom: 20.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Transaction history",
                                            style: TextStyle(fontSize: 20)),
                                        Text("See all",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey[800])),
                                      ],
                                    ),
                                  ),
                                  _buildTransactionHistoryView(model),
                                ],
                              ),
                            ),
                          ],
                        ),
                        _buildSeparator(screenSize),
                        _buildProjectView(context, model),
                        _buildSeparator(screenSize),
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
      color: Colors.grey[800],
      fontSize: 35.0,
      fontWeight: FontWeight.w600,
    );
    return Text(
      "Hi ${name.split(" ")[0]}!",
      style: _nameTextStyle,
    );
  }

  _buildSeparator(Size screenSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Center(
        child: Container(
            width: 6000,
            height: 1.0,
            color: Colors.grey[600],
            margin: EdgeInsets.only(top: 4.0)),
      ),
    );
  }

  _buildStatView(var model) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(
            top: 15.0, bottom: 20.0, left: 15.0, right: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Current balance",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                    ),
                  ),
                  verticalSpace(10),
                  Text(
                    "${model.wallet.currentBalance * 0.01}.00 \$",
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  CallToActionButton(
                    color: Colors.grey[800],
                    onTap: model.navigateToSendMoneyView,
                    text: "Commit",
                    icon: Icon(Icons.arrow_circle_up, color: Colors.grey[800]),
                  ),
                  verticalSpace(15),
                  CallToActionButton(
                    color: Colors.grey[800],
                    onTap: model.navigateToSendMoneyView,
                    text: "Receive",
                    icon: Icon(Icons.call_received, color: Colors.grey[800]),
                  ),
                  //Spacer(flex: 1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildProjectView(BuildContext context, dynamic model) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Featured projects",
                  style: TextStyle(fontSize: 24, color: Colors.grey[800])),
              GestureDetector(
                onTap: model.navigateToDonationView,
                child: Text("See all",
                    style: TextStyle(fontSize: 16, color: Colors.grey[800])),
              ),
            ],
          ),
        ),
        model.projects == null
            ? Center(child: LinearProgressIndicator())
            : Container(
                height: 350,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: model.projects.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: MediaQuery.of(context).size.width > 1000
                          ? 1000 / 3
                          : MediaQuery.of(context).size.width / 1.1 / 3,
                      child: GlobalGivingProjectCard(
                          project: model.projects[index],
                          onTap: model.navigateToDonationView),
                    );
                  },
                ),
              ),
      ],
    );
  }

  _buildDonationBalanceView(dynamic model) {
    return Column(
      children: [
        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 8.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Text("Your social footprint",
        //           style: TextStyle(fontSize: 25, color: Colors.grey[800])),
        //       Text("...",
        //           style: TextStyle(fontSize: 16, color: Colors.grey[800])),
        //     ],
        //   ),
        // ),
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "That's your social footprint",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.grey[800],
                  ),
                ),
                verticalSpace(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "invested in good causes ",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                          ),
                        ),
                        verticalSpace(10),
                        Text(
                          "${model.wallet.donated * 0.01}.00 \$",
                          style: TextStyle(
                            fontSize: 35,
                            color: Colors.grey[800],
                          ),
                        ),
                        verticalSpace(20),
                        CallToActionButtonRound(
                          color: ATLASred,
                          onPressed: model.navigateToDonationView,
                          text: "Give more",
                          icon: Icon(Icons.favorite),
                        ),
                      ],
                    ),
                    //Spacer(flex: 1),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "invested in your peers' wallets",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                          ),
                        ),
                        verticalSpace(10),
                        Text(
                          "${model.wallet.sentToPeer * 0.01}.00 \$",
                          style: TextStyle(
                            fontSize: 35,
                            color: Colors.grey[800],
                          ),
                        ),
                        verticalSpace(10),
                        CallToActionButtonRound(
                          color: Colors.blue,
                          onPressed: model.navigateToSendMoneyView,
                          text: "Send more",
                          icon: Icon(Icons.send),
                        ),
                      ],
                    ),
                    //Expanded(flex: 2, child: Container()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
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
            imageLocation: "assets/images/hand-with-heart.jpg"),
        verticalSpace(20),
        FeedCard(
            title: "Get payed for good",
            supportingText:
                "Next time a friend pays you back ask for good dollars instead",
            actionButtonText: "#getpayedforgood",
            imageLocation: "assets/images/hand-shake-on-yellow.jpg"),
      ],
    );
  }

  _buildTransferButton(dynamic model) {
    return Row(
      children: [
        Expanded(
          child: CallToActionButtonRound(
            color: ATLASred,
            onPressed: model.navigateToDonationView,
            text: "Give",
            icon: Icon(Icons.favorite),
          ),
        ),
        Expanded(
          child: CallToActionButtonRound(
            color: Colors.blue,
            onPressed: model.navigateToSendMoneyView,
            text: "Send",
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
                String initials = hist.recipientName.split(" ")[0][0];
                initials = hist.recipientName.split(" ").length > 1
                    ? initials + hist.recipientName.split(" ")[1][0]
                    : initials + "";
                return SizedBox(
                  width: 64,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CircleAvatar(
                            radius: 32,
                            backgroundColor: Colors.blue[400],
                            child: Text(initials,
                                style: TextStyle(color: Colors.grey[100]))),
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
            itemCount:
                model.transactions.length > 3 ? 3 : model.transactions.length,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              var hist = model.transactions[index];
              var incoming = (hist.recipientName == model.currentUser.fullName);
              var color = incoming ? ATLASgreen : Colors.grey[700];
              var amountFormatted = "\$ ${hist.amount * 0.01}";
              var nameToDisplay =
                  incoming ? hist.senderName : hist.recipientName;
              if (hist.topUp != null) {
                if (hist.topUp) {
                  nameToDisplay = "Committed for good";
                }
              }
              return Column(
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
            },
          )
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
  final Function onTap;
  final String text;
  final Icon icon;
  final Color color;
  final bool leadingIcon;

  const CallToActionButton(
      {Key key,
      this.leadingIcon = true,
      this.onTap,
      this.text,
      this.icon,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color),
          //color: color,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              leadingIcon
                  ? icon != null
                      ? icon
                      : Container()
                  : Container(),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  text,
                  style: TextStyle(fontSize: 14, color: color),
                ),
              ),
              leadingIcon
                  ? Container()
                  : icon != null
                      ? icon
                      : Container(),
            ],
          ),
        ),
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
