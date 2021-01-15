import 'package:flutter/material.dart';
import 'package:good_wallet/views/utils/ui_helpers.dart';

class PaymentCancelView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CenteredView(
          maxWidth: 600,
          child: Text("Cancelled payment!"),
        ),
      ],
    );
  }
}
