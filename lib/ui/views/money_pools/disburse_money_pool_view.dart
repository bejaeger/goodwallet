import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/money_pools/base/money_pool.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/money_pools/components/user_payout_form.dart';
import 'package:good_wallet/ui/views/money_pools/disburse_money_pool_viewmodel.dart';
import 'package:good_wallet/ui/widgets/alternative_screen_header_small.dart';
import 'package:good_wallet/ui/widgets/call_to_action_button.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class DisburseMoneyPoolView extends StatelessWidget {
  final MoneyPool moneyPool;
  const DisburseMoneyPoolView({Key? key, required this.moneyPool})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DisburseMoneyPoolViewModel>.reactive(
      viewModelBuilder: () => DisburseMoneyPoolViewModel(moneyPool: moneyPool),
      builder: (context, model, child) {
        return ConstrainedWidthWithScaffoldLayout(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: LayoutSettings.horizontalPadding),
            child: RefreshIndicator(
              onRefresh: model.updateAvailableBalance,
              child: ListView(
                physics: AlwaysScrollableScrollPhysics(),
                children: [
                  AlternativeScreenHeaderSmall(
                      title: "Select Payouts",
                      onBackButtonPressed: model.navigateBack),
                  verticalSpaceSmall,
                  Column(
                    children: [
                      Text(formatAmount(model.availableBalance),
                          style: textTheme(context).headline2),
                      Text("Available",
                          style: textTheme(context)
                              .bodyText2!
                              .copyWith(fontSize: 16)),
                    ],
                  ),
                  verticalSpaceSmall,
                  Divider(
                    thickness: 2,
                  ),
                  verticalSpaceSmall,
                  Column(
                    children: _getUserPayoutFormRows(context,
                        model.userPayoutForms, model.removeUserPayoutForm),
                  ),
                  // verticalSpaceMedium,
                  Align(
                    child: Column(
                      children: [
                        IconButton(
                          color: MyColors.paletteGreen,
                          onPressed: () => model.addUserPayoutForm(),
                          icon: Icon(
                            Icons.add_circle_outline_rounded,
                            size: 40,
                          ),
                        ),
                        Text("Add Member",
                            style: textTheme(context).bodyText2!.copyWith(
                                color: ColorSettings.blackHeadlineColor,
                                fontSize: 16)),
                      ],
                    ),
                  ),
                  verticalSpaceMedium,
                  if (model.validationMessage != null)
                    Align(
                      child: SizedBox(
                        width: screenWidth(context, percentage: 0.8),
                        child: Text(
                          model.validationMessage!,
                          style: textTheme(context)
                              .bodyText2!
                              .copyWith(fontSize: 16, color: Colors.red),
                        ),
                      ),
                    ),
                  if (model.validationMessage != null) verticalSpaceSmall,
                  Align(
                    child: model.isBusy
                        ? Center(child: CircularProgressIndicator())
                        : CallToActionButtonRectangular(
                            maxWidth:
                                screenWidthPercentage(context, percentage: 0.6),
                            color: MyColors.paletteGreen.withOpacity(0.9),
                            title: "Payout",
                            onPressed: model.isValidPayoutData()
                                ? model.submitMoneyPoolPayout
                                : null),
                  ),
                  verticalSpaceMassive,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _getUserPayoutFormRows(
      BuildContext context,
      List<UserPayoutForm> userPayoutForms,
      void Function(Key) onRemovePayoutFormPressed) {
    List<dynamic> rows = userPayoutForms.map((element) {
      return Column(
        children: [
          verticalSpaceSmall,
          DelayedDisplay(
            fadingDuration: Duration(milliseconds: 300),
            slidingBeginOffset: const Offset(0.0, -0.2),
            child: Row(
              children: [
                SizedBox(
                  width: screenWidthPercentage(context, percentage: 0.8),
                  child: element,
                ),
                Flexible(
                  child: IconButton(
                    padding: const EdgeInsets.all(0.0),
                    onPressed: () => onRemovePayoutFormPressed(element.key!),
                    icon: Icon(
                      Icons.remove_circle_outline_outlined,
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),
          verticalSpaceSmall,
        ],
      );
    }).toList();
    return rows;
  }
}
