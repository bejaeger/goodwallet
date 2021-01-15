import 'package:flutter/material.dart';
import 'package:good_wallet/app/locator.dart';
import 'package:good_wallet/services/userdata/wallet_client_service.dart';
import 'package:good_wallet/views/utils/ui_helpers.dart';
import 'package:stacked_services/stacked_services.dart';

class PaymentSuccessView extends StatelessWidget {
  final UserWalletService _userWalletService = locator<UserWalletService>();

  @override
  Widget build(BuildContext context) {
    // HERE we need to trigger the function to update the good wallet

    return CenteredView(
        maxWidth: 600,
        child: Column(
          children: [
            Text("Successfully transferred Good Dollars!",
                style: TextStyle(fontSize: 16)),
          ],
        ));
  }
}
