import 'package:flutter/material.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/money_pools/create_money_pool_form_viewmodel.dart';
import 'package:good_wallet/ui/widgets/alternative_screen_header.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:good_wallet/ui/views/money_pools/create_money_pool_form_view.form.dart';

@FormView(fields: [
  FormTextField(name: 'name'),
  FormTextField(name: 'description'),
])
class CreateMoneyPoolFormView extends StatelessWidget
    with $CreateMoneyPoolFormView {
  CreateMoneyPoolFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateMoneyPoolFormViewModel>.reactive(
      viewModelBuilder: () => CreateMoneyPoolFormViewModel(),
      onModelReady: (model) => listenToFormUpdated(model),
      builder: (context, model, child) => ConstrainedWidthWithScaffoldLayout(
        child: model.isBusy
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: LayoutSettings.horizontalPadding),
                child: ListView(
                  children: [
                    AlternativeScreenHeader(
                      title: "Give it a name",
                      onBackButtonPressed: model.navigateBack,
                      description:
                          "Add a name and describe the goal of this money pool",
                    ),
                    Card(
                      margin: const EdgeInsets.all(0.0),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            TextField(
                              decoration: InputDecoration(labelText: 'Name'),
                              controller: nameController,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Description (optional)',
                              ),
                              minLines: 4,
                              maxLines: 10,
                              controller: descriptionController,
                            ),
                            verticalSpaceMediumLarge,
                            CheckboxListTile(
                                contentPadding: const EdgeInsets.all(0.0),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                title: Text("Display raised amount"),
                                value: model.isShowBalanceChecked,
                                onChanged: (value) =>
                                    model.setIsShowBalanceChecked(value))
                            // with custom text
                          ],
                        ),
                      ),
                    ),
                    verticalSpaceMedium,
                    if (model.validationMessage != null)
                      Text(
                        model.validationMessage!,
                        style: TextStyle(
                          color: Colors.red,
                          //fontSize: kBodyTextSize,
                        ),
                      ),
                    if (model.validationMessage != null) verticalSpaceRegular,
                    verticalSpaceMedium,
                    Container(
                      constraints: BoxConstraints(
                        minWidth: screenWidthWithoutPadding(context),
                        maxWidth: screenWidthWithoutPadding(context),
                        minHeight: 45,
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(0.0),
                            elevation: 0.0,
                            primary:
                                MyColors.paletteTurquoise.withOpacity(0.8)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 12.0, bottom: 12.0, left: 20.0, right: 20.0),
                          child: Text(
                            "Create money pool",
                            style: textTheme(context).headline5!.copyWith(
                                fontSize: 18,
                                color: ColorSettings.whiteTextColor),
                          ),
                        ),
                        onPressed: model.createMoneyPool,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
