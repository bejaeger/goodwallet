import 'dart:async';

import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:good_wallet/datamodels/money_pools/money_pool_model.dart';
import 'package:good_wallet/datamodels/user/public_user_info.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/views/money_pools/components/user_payout_form.form.dart';
import 'package:good_wallet/ui/views/money_pools/components/user_payout_form_model.dart';
import 'package:good_wallet/utils/datamodel_helpers.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:flutter/material.dart';
import 'package:delayed_display/delayed_display.dart';

@FormView(fields: [
  FormTextField(name: 'name'),
  FormTextField(name: 'amount'),
])
class UserPayoutForm extends StatelessWidget with $UserPayoutForm {
  final UserPayoutFormModel userPayoutFormModel;

  UserPayoutForm({required Key key, required this.userPayoutFormModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserPayoutFormModel>.reactive(
      viewModelBuilder: () => userPayoutFormModel,
      disposeViewModel: false,
      builder: (context, model, child) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: screenWidthPercentage(context, percentage: 0.6),
            height: 50,
            child: model.hasSelectedUser
                ? GestureDetector(
                    onTap: model.editSelectedUser,
                    child: Container(
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        border: new Border.all(
                          color: ColorSettings.lightGreyTextColor!,
                          width: 1.0,
                        ),
                      ),
                      child: ListTile(
                        dense: true, // removes padding on top!
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundColor: MyColors.paletteBlue,
                          child: Text(
                              getInitialsFromName(model.selectedUserName!),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14)),
                        ),
                        title: Text(model.selectedUserName!,
                            style: textTheme(context)
                                .headline6!
                                .copyWith(fontSize: 16.0)),
                        trailing: Icon(Icons.arrow_drop_down, size: 22),
                      ),
                    ),
                  )
                : DelayedDisplay(
                    delay: Duration(milliseconds: 0),
                    fadingDuration: Duration(milliseconds: 300),
                    slidingBeginOffset: const Offset(0.0, -0.2),
                    child: UserSelectionDropDownMenu(
                      controller: nameController,
                      suggestionsCallback: (String pattern) =>
                          model.getUserNames(),
                      onSuggestionSelected: (String suggestion) =>
                          model.selectUser(suggestion),
                    ),
                  ),
          ),
          horizontalSpaceRegular,
          Flexible(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'CAD',
                hintStyle: textTheme(context).bodyText2,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(16.0),
                  ),
                  borderSide: new BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
              ),
              focusNode: amountFocusNode,
              controller: amountController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: textTheme(context).bodyText2!.copyWith(
                  fontSize: 20, color: ColorSettings.blackHeadlineColor),
              autofocus: true,
            ),
          ),
        ],
      ),
    );
  }
}

class UserSelectionDropDownMenu extends StatelessWidget {
  final TextEditingController controller;
  final FutureOr<Iterable<String>> Function(String) suggestionsCallback;
  final void Function(String) onSuggestionSelected;
  final bool autofocus;

  const UserSelectionDropDownMenu(
      {Key? key,
      required this.controller,
      required this.suggestionsCallback,
      required this.onSuggestionSelected,
      this.autofocus = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<String>(
      hideOnEmpty: true,
      hideKeyboard: true,
      noItemsFoundBuilder: (context) =>
          Text("No user found", style: TextStyle(fontSize: 18)),
      getImmediateSuggestions: true,
      textFieldConfiguration: TextFieldConfiguration(
        autofocus: autofocus,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 16.0),
          suffixIcon: Icon(Icons.arrow_drop_down),
          hintText: 'Select user',
          hintStyle: textTheme(context).bodyText2,
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(16.0),
            ),
            borderSide: new BorderSide(
              color: Colors.black,
              width: 1.0,
            ),
          ),
        ),
        controller: controller,
      ),
      suggestionsCallback: suggestionsCallback,
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
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white, fontSize: 14)),
          ),
          title: Text(suggestion, style: TextStyle(fontSize: 14)),
          //subtitle: Text("Rookie", style: TextStyle(fontSize: 12)),
        );
      },
      onSuggestionSelected: onSuggestionSelected,
    );
  }
}
