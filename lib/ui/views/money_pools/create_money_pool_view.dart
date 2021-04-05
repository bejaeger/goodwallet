import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/money_pools/create_money_pool_viewmodel.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

import 'package:stacked/stacked.dart';

class CreateMoneyPoolView extends StatelessWidget {
  const CreateMoneyPoolView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateMoneyPoolViewModel>.reactive(
      viewModelBuilder: () => CreateMoneyPoolViewModel(),
      builder: (context, model, child) => Scaffold(
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
                    onPressed: model.showInformationDialog,
                  ),
                ],
              ),
              Text(
                "Create Money Pool",
                style: TextStyle(fontSize: 34),
              ),
              verticalSpaceSmall,
              GestureDetector(
                onTap: model.navigateToManageMoneyPoolsView,
                child: Text("Manage existing money pools",
                    style: textTheme(context).bodyText2.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ColorSettings.primaryColor)),
              ),
              verticalSpaceMediumLarge,
            ],
          ),
        ),
      ),
    );
  }
}
