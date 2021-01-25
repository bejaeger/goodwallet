import 'package:flutter/material.dart';
import 'package:good_wallet/app/locator.dart';
import 'package:good_wallet/services/userdata/wallet_client_service.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:good_wallet/viewmodels/payments/send_money_view_model.dart';
import 'package:stacked/stacked.dart';

class PaymentSuccessView extends StatelessWidget {
  final UserWalletService _userWalletService = locator<UserWalletService>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SendMoneyViewModel>.reactive(
      viewModelBuilder: () => SendMoneyViewModel(),
      onModelReady: (model) {
        model.handlePaymentSuccess();
      },
      builder: (context, model, child) => CenteredView(
        maxWidth: 600,
        child: Column(
          children: [
            Text("Successfully transferred Good Dollars!",
                style: TextStyle(fontSize: 16)),
            FlatButton(
                onPressed: () => model.navigateToHomeView(2),
                child: Text("Go back.")),
          ],
        ),
      ),
    );
  }
}
