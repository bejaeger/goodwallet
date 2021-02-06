import 'package:flutter/material.dart';
import 'package:good_wallet/ui/views/payments/send_money_viewmodel.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class PaymentCancelView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SendMoneyViewModel>.reactive(
      viewModelBuilder: () => SendMoneyViewModel(),
      onModelReady: (model) {
        model.handlePaymentFailure();
      },
      builder: (context, model, child) => CenteredView(
        maxWidth: 600,
        child: Column(
          children: [
            Text("Cancelled payment!", style: TextStyle(fontSize: 16)),
            FlatButton(
                onPressed: model.navigateToHomeView, child: Text("Go back.")),
          ],
        ),
      ),
    );
  }
}
