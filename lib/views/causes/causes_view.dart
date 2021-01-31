import 'package:flutter/material.dart';
import 'package:good_wallet/style/colors.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:good_wallet/viewmodels/base_model.dart';
import 'package:good_wallet/viewmodels/goodcauses/causes_view_model.dart';
import 'package:stacked/stacked.dart';

class DonationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CausesViewModel>.reactive(
      viewModelBuilder: () => CausesViewModel(),
      builder: (context, model, child) => WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: CenteredView(
            maxWidth: 600,
            child: Center(child: Text("It's coming Bro, relax...")),
          ),
        ),
      ),
    );
  }
}
