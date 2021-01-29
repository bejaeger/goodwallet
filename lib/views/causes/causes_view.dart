import 'package:flutter/material.dart';
import 'package:good_wallet/style/colors.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

class DonationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CenteredView(
        maxWidth: 600,
        child: Text("It's coming Bro, relax..."),
      ),
    );
  }
}
