import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/money_pools/money_pool_model.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/money_pools/single_money_pool_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SingleMoneyPoolView extends StatelessWidget {
  final MoneyPoolModel moneyPool;
  const SingleMoneyPoolView({Key? key, required this.moneyPool})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SingleMoneyPoolViewModel>.reactive(
      viewModelBuilder: () => SingleMoneyPoolViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: LayoutSettings.horizontalPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(moneyPool.toJson().toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
