import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:good_wallet/viewmodels/payments/send_money_view_model.dart';
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
        child: CenteredView(
          maxWidth: 500,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                ListView(
                  padding: const EdgeInsets.all(20.0),
                  children: [
                    verticalSpace(50),
                    _selectUserView(model),
                    _buildSearchTextWidget(context, model),
                    _selectValueView(context, model),
                    _optionalMessageView(model),
                    verticalSpace(50),
                    model.errorMessage != null
                        ? Text(model.errorMessage,
                            style: TextStyle(color: Colors.red))
                        : Container(height: 0, width: 0),
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
                //_buildFloatingSearchBar(context, model),
              ],
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
          decoration: InputDecoration(hintText: 'Search by Username'),
        ),
        suggestionsCallback: (String pattern) async {
          return ["hi", "h", "1", "2", "3", "4", "4"];
          //return await model.getSearchedNames(pattern);
        },
        suggestionsBoxDecoration: SuggestionsBoxDecoration(
            constraints: BoxConstraints(
          maxHeight: 280,
        )),
        itemBuilder: (context, String suggestion) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text('${suggestion[0]}',
                  style: TextStyle(color: Colors.white)),
            ),
            title: Text(suggestion),
            subtitle: Text("Rookie"),
          );
        },
        onSuggestionSelected: (String suggestion) {
          print("Suggestion selected");
        },
      ),
      //SizedBox(height: 500),
    ]);
  }

  _buildFloatingSearchBar(BuildContext context, dynamic model) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Container(
      height: 400,
      child: FloatingSearchBar(
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
                      shrinkWrap: true,
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
              : Container(width: 0, height: 0);
        },
      ),
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

  _selectValueView(dynamic context, var model) {
    return Container(
      child: TextFormField(
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
