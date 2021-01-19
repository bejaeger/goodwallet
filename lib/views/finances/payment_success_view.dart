import 'package:flutter/material.dart';
import 'package:good_wallet/app/locator.dart';
import 'package:good_wallet/services/userdata/wallet_client_service.dart';
import 'package:good_wallet/viewmodels/finances/send_money_view_model.dart';
import 'package:good_wallet/views/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PaymentSuccessView extends StatelessWidget {
  final UserWalletService _userWalletService = locator<UserWalletService>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SendMoneyViewModel>.reactive(
      viewModelBuilder: () => SendMoneyViewModel(),
      onModelReady: (model) {
        model.handlePaymentSuccess();
      },
      builder: (context, model, child) =>
          //Container(height: 10, width: 10),

          CenteredView(
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
