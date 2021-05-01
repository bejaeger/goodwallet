import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/money_pools/money_pool_model.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/money_pools/components/user_payout_form.dart';
import 'package:good_wallet/ui/views/money_pools/disburse_money_pool_viewmodel.dart';
import 'package:good_wallet/ui/widgets/alternative_screen_header_small.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class DisburseMoneyPoolView extends StatelessWidget {
  final MoneyPoolModel moneyPool;
  const DisburseMoneyPoolView({Key? key, required this.moneyPool})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DisburseMoneyPoolViewModel>.reactive(
      viewModelBuilder: () => DisburseMoneyPoolViewModel(moneyPool: moneyPool),
      builder: (context, model, child) {
        return ConstrainedWidthWithScaffoldLayout(
          resizeToAvoidBottomInset: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: LayoutSettings.horizontalPadding),
            child: model.userPayoutForms.length > 100
                ? Container()
                : ListView(
                    physics: AlwaysScrollableScrollPhysics(),
                    children: [
                      AlternativeScreenHeaderSmall(
                          title: "Select Payouts",
                          onBackButtonPressed: model.navigateBack),
                      verticalSpaceMedium,
                      Column(
                        children: [
                          Text(formatAmount(model.getCurrentBalance()),
                              style: textTheme(context).headline2),
                          Text("Available"),
                        ],
                      ),
                      verticalSpaceMedium,
                      Column(
                        children: _getUserPayoutFormRows(context,
                            model.userPayoutForms, model.removeUserPayoutForm),
                      ),
                      verticalSpaceMedium,
                      IconButton(
                        padding: const EdgeInsets.all(0.0),
                        color: MyColors.paletteGreen,
                        onPressed: () => model.addUserPayoutForm(),
                        icon: Icon(
                          Icons.add_circle_outline_rounded,
                          size: 35,
                        ),
                      ),
                    ],
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
          Divider(height: 20, thickness: 2.0),
        ],
      );
    }).toList();
    return rows;
  }
}
