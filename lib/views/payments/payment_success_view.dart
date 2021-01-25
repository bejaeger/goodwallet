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
          child: model.paymentStatus == "unknown"
              ? LinearProgressIndicator()
              : model.paymentStatus == "success"
                  ? _statusSuccessMessage(model)
                  : model.paymentStatus == "expired"
                      ? _statusExpiredMessage(model)
                      : _statusPendingMessage(model)),
    );
  }

  Widget _statusSuccessMessage(dynamic model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Successfully transferred Good Dollars!",
            style: TextStyle(fontSize: 20)),
        FlatButton(
            onPressed: () => model.navigateToHomeView(2),
            child: Text("Go back.")),
      ],
    );
  }

  Widget _statusExpiredMessage(dynamic model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This payment processing link has expired.",
            style: TextStyle(fontSize: 20)),
        FlatButton(
            onPressed: () => model.navigateToHomeView(2),
            child: Text("Go back.")),
      ],
    );
  }

  Widget _statusPendingMessage(dynamic model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            "Something went terribly wrong! Please contact support immediately",
            style: TextStyle(fontSize: 20)),
        FlatButton(
            onPressed: () => model.navigateToHomeView(2),
            child: Text("Go back.")),
      ],
    );
  }
}
