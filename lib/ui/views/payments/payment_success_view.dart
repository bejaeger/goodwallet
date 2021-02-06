import 'package:flutter/material.dart';
import 'package:good_wallet/ui/views/payments/send_money_viewmodel.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class PaymentSuccessView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SendMoneyViewModel>.reactive(
      viewModelBuilder: () => SendMoneyViewModel(),
      onModelReady: (model) {
        model.handlePaymentSuccess();
      },
      builder: (context, model, child) => WillPopScope(
        onWillPop: () async {
          model.setShowNavigationBar(true);
          model.navigateToHomeView();
          return true;
        },
        child: CenteredView(
            maxWidth: 600,
            child: model.paymentStatus == "unknown"
                ? LinearProgressIndicator()
                : model.paymentStatus == "success"
                    ? _statusSuccessMessage(model)
                    : model.paymentStatus == "expired"
                        ? _statusExpiredMessage(model)
                        : _statusPendingMessage(model)),
      ),
    );
  }

  Widget _statusSuccessMessage(dynamic model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Successfully transferred Good Dollars!",
            style: TextStyle(fontSize: 20)),
        FlatButton(
            onPressed: () {
              model.setShowNavigationBar(true);
              model.navigateToWalletView();
            },
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
            onPressed: () {
              model.setShowNavigationBar(true);
              model.navigateToHomeView();
            },
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
            onPressed: () => model.navigateToHomeView(),
            child: Text("Go back.")),
      ],
    );
  }
}
