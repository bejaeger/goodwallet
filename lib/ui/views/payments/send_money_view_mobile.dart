import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/payments/send_money_viewmodel.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class SendMoneyViewMobile extends StatelessWidget {
  final Map<String, String> userInfoMap;
  final openSearchBarOnBuild;

  SendMoneyViewMobile(
      {Key key, this.userInfoMap, this.openSearchBarOnBuild = false})
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
      builder: (context, model, child) => model.isBusy
          ? CircularProgressIndicator()
          : Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: LayoutSettings.horizontalPadding),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        IconButton(
                          icon: Icon(
                            Icons.info_outline_rounded,
                            color: ColorSettings.blackHeadlineColor,
                          ),
                          onPressed: model.showNotImplementedSnackbar,
                        ),
                      ],
                    ),
                    Text(
                      "Send Money",
                      style: TextStyle(fontSize: 34),
                    ),
                    verticalSpaceLarge,
                    Column(
                      children: [
                        verticalSpaceMedium,
                        _buildSearchTextWidget(context, model),
                        verticalSpaceMedium,
                        _selectValueView(context, model),
                        verticalSpaceMedium,
                        _optionalMessageView(model),
                        verticalSpaceMassive,
                        //_selectUserView(model),
                        verticalSpaceRegular,
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth:
                                screenWidthPercentage(context, percentage: 0.7),
                          ),
                          child: ElevatedButton(
                            onPressed: () =>
                                model.dummyPaymentConfirmationDialog(),
                            child: Text('Send'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

_selectUserView(dynamic model) {
  return Column(
    children: [
      Row(
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Send Money to: ", style: TextStyle(fontSize: 18)),
          model.selectedUserInfoMap != null
              ? Center(
                  child: Text(model.selectedUserInfoMap["name"],
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600)))
              : Container(),
        ],
      ),
    ],
  );
}

_selectValueView(dynamic context, var model) {
  return Container(
    child: TextFormField(
      decoration: new InputDecoration(
          prefixIcon: Icon(Icons.money), labelText: "Amount in \$"),
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
      decoration: new InputDecoration(
          prefixIcon: Icon(Icons.message_outlined),
          labelText: "Message (optional)"),
      controller:
          model.optionalMessageController, // Only numbers can be entered
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
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.search), hintText: 'Search for user'),
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
      )),
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
