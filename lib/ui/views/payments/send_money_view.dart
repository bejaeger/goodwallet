import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:good_wallet/datamodels/user/public_user_info.dart';
import 'package:good_wallet/ui/views/payments/send_money_viewmodel.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class SendMoneyView extends StatelessWidget {
  final PublicUserInfo? userInfoMap;
  final openSearchBarOnBuild;

  SendMoneyView({Key? key, this.userInfoMap, this.openSearchBarOnBuild = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SendMoneyViewModel>.reactive(
      viewModelBuilder: () => SendMoneyViewModel(),
      onModelReady: (model) {
        model.setPaymentReady(false);
        if (userInfoMap != null) {
          model.selectUser(userInfoMap!);
        }
      },
      builder: (context, model, child) => WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: !model.isUserInitialized
              ? Container()
              : CenteredView(
                  maxWidth: 500,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 2,
                      child: Container(
                        height: 600, // 25 = safearea
                        child: Stack(
                          children: [
                            ListView(
                              padding: const EdgeInsets.all(20.0),
                              children: [
                                verticalSpace(30),
                                _selectUserView(model),
                                verticalSpace(30),
                                _buildSearchTextWidget(context, model),
                                verticalSpace(10),
                                _selectValueView(context, model),
                                verticalSpace(10),
                                _optionalMessageView(model),
                                verticalSpace(30),
                                model.errorMessage != null
                                    ? Text(model.errorMessage!,
                                        style: TextStyle(color: Colors.red))
                                    : Container(height: 0, width: 0),
                                model.isBusy
                                    ? Center(child: LinearProgressIndicator())
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                            _payButtonView(model),
                                            _testPayButtonView(model),
                                          ]),
                              ],
                            ),
                            //_buildFloatingSearchBar(context, model),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  _buildSearchTextWidget(BuildContext context, dynamic model) {
    final List<String> items = List.generate(5, (index) => "Item $index");

    return ListView(shrinkWrap: true, children: [
      //SizedBox(height: 200),
      TypeAheadField<String>(
        //hideOnEmpty: true,
        hideOnLoading: true,
        noItemsFoundBuilder: (context) =>
            Text("No user found", style: TextStyle(fontSize: 18)),
        getImmediateSuggestions: true,
        textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(hintText: 'Select user'),
          controller: model.userSelectionController,
        ),
        suggestionsCallback: (String pattern) async {
          var names = await model.getQueriedUserNames(pattern);
          //names = ["hi", "next", "hi", "next", "hi", "next", "hi", "next"];
          return names;
        },
        suggestionsBoxDecoration: SuggestionsBoxDecoration(
          constraints: BoxConstraints(
            maxHeight: 280,
          ),
        ),
        itemBuilder: (context, String suggestion) {
          return ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blue,
              child: Text('${suggestion[0]}',
                  style: TextStyle(color: Colors.white, fontSize: 14)),
            ),
            title: Text(suggestion, style: TextStyle(fontSize: 14)),
            subtitle: Text("Rookie", style: TextStyle(fontSize: 12)),
          );
        },
        onSuggestionSelected: (String suggestion) {
          model.setUser(suggestion);
          print("INFO: User selected");
        },
      ),
      //SizedBox(height: 500),
    ]);
  }

  _selectUserView(dynamic model) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Send Money to: ", style: TextStyle(fontSize: 18)),
            model.selectedUserInfoMap != null
                ? Center(
                    child: Text(model.selectedUserInfoMap["name"],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)))
                : Container(),
          ],
        ),
      ],
    );
  }

  _selectValueView(dynamic context, var model) {
    return Container(
      child: TextFormField(
        decoration: new InputDecoration(labelText: "Amount"),
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
      child: TextField(
        decoration: new InputDecoration(labelText: "Message (optional)"),
        controller:
            model.optionalMessageController, // Only numbers can be entered
      ),
    );
  }

  _payButtonView(dynamic model) {
    return Column(
      children: <Widget>[
        RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: model.isPaymentReady ? Colors.lightBlue : Colors.grey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "       Checkout       ",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          onPressed: model.isPaymentReady
              ? () async => await model.makePayment()
              : null,
        ),
      ],
    );
  }

  _testPayButtonView(dynamic model) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.lightBlue,
              child: Text("DUMMY", style: TextStyle(color: Colors.white)),
              onPressed: () async {
                await model.makeTestPayment();
              },
            ),
            Text("Pay 7\$ to Hans", style: TextStyle(fontSize: 8)),
          ],
        ),
      ),
    );
  }
}
