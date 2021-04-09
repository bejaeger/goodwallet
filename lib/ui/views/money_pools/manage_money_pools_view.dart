import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/money_pools/manage_money_pools_viewmodel.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

import 'package:stacked/stacked.dart';

class ManageMoneyPoolsView extends StatelessWidget {
  const ManageMoneyPoolsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ManageMoneyPoolsViewModel>.reactive(
      viewModelBuilder: () => ManageMoneyPoolsViewModel(),
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
                "Manage Money Pools",
                style: TextStyle(fontSize: 34),
              ),
              verticalSpaceMediumLarge,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: model.navigateToCreateMoneyPoolView,
                            child: Container(
                              width: screenWidthWithoutPadding(context,
                                  percentage: 0.45),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                        color: ColorSettings.primaryColor,
                                        width: 2),
                                  ),
                                  child: Center(
                                    child: Icon(Icons.add,
                                        size: 30,
                                        color: ColorSettings.primaryColor),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          verticalSpaceSmall,
                          Text(
                            "Create money pool",
                            style: textTheme(context).bodyText2!.copyWith(
                                fontSize: 16,
                                //fontWeight: FontWeight.bold,
                                color: ColorSettings.blackHeadlineColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
