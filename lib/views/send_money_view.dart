import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:good_wallet/viewmodels/finances/send_money_view_model.dart';
import 'package:good_wallet/views/utils/ui_helpers.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:stacked/stacked.dart';

class SendMoneyView extends StatelessWidget {
  final Map<String, String> userInfoMap;
  final openSearchBarOnBuild;

  SendMoneyView({Key key, this.userInfoMap, this.openSearchBarOnBuild = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SendMoneyViewModel>.reactive(
      viewModelBuilder: () => SendMoneyViewModel(),
      onModelReady: (model) {
        model.setPaymentReady(false);
        model.addListenersToControllers();
        if (userInfoMap != null) {
          model.selectUser(userInfoMap);
        }
      },
      builder: (context, model, child) => WillPopScope(
        onWillPop: () async => true,
        child: Scaffold(
          body: CenteredView(
            maxWidth: 500,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      verticalSpace(50),
                      _selectUserView(model),
                      _selectValueView(model),
                      _optionalMessageView(model),
                      verticalSpace(50),
                      model.errorMessage != null
                          ? Text(model.errorMessage,
                              style: TextStyle(color: Colors.red))
                          : Container(),
                      model.isBusy
                          ? Center(child: CircularProgressIndicator())
                          : Column(children: [
                              model.currentUser != null
                                  ? _payButtonView(model)
                                  : Container(),
                              model.currentUser != null
                                  ? _testPayButtonView(model)
                                  : Container(),
                            ]),
                    ],
                  ),
                  _buildFloatingSearchBar(context, model),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildFloatingSearchBar(BuildContext context, dynamic model) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return FloatingSearchBar(
      hint: 'Search for users...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      maxWidth: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        model.searchFor(query);
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      builder: (context, transition) {
        return (model.userInfoMaps.length > 0)
            ? Container(
                color: Colors.white,
                height: 300,
                child: ListView.separated(
                    itemCount: model.userInfoMaps.length,
                    separatorBuilder: (context, index) =>
                        const Divider(thickness: 1),
                    itemBuilder: (context, index) {
                      return ListTile(
                          title: Text(
                              'Username: ${model.userInfoMaps[index]["name"]}'),
                          onTap: () {
                            FloatingSearchBar.of(context).close();
                            model.selectUser(model.userInfoMaps[index]);
                          });
                    }),
              )
            : Container();
      },
    );
  }

  _selectUserView(dynamic model) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Transfer Good Dollars to: ",
                    style: TextStyle(fontSize: 18)),
                model.selectedUserInfoMap != null
                    ? Center(
                        child: Text(model.selectedUserInfoMap["name"],
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)))
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _selectValueView(var model) {
    return Container(
      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
      child: TextField(
        decoration: new InputDecoration(labelText: "Amount in CAD"),
        keyboardType: TextInputType.number,
        controller: model.transferValueController,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ], // Only numbers can be entered
      ),
    );
  }

  _optionalMessageView(model) {
    return Container(
      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
      child: TextField(
        decoration: new InputDecoration(labelText: "Message (optional)"),
        controller:
            model.optionalMessageController, // Only numbers can be entered
      ),
    );
  }

  _payButtonView(dynamic model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        RaisedButton(
          color: model.isPaymentReady ? Colors.lightBlue : Colors.grey,
          child: Text("       Checkout       ",
              style: TextStyle(color: Colors.white)),
          onPressed: model.isPaymentReady
              ? () async => await model.makePayment()
              : null,
        ),
      ],
    );
  }

  _testPayButtonView(dynamic model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        RaisedButton(
          color: Colors.lightBlue,
          child: Text("Make Dummy Payment \$7 to Hans",
              style: TextStyle(color: Colors.white)),
          onPressed: () async {
            await model.makeTestPayment();
          },
        ),
      ],
    );
  }
}
