import 'package:flutter/material.dart';
import 'package:good_wallet/ui/views/goodcauses/causes_viewmodel.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
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
          backgroundColor: Theme.of(context).backgroundColor,
          body: CenteredView(
            maxWidth: 600,
            child: Center(child: Text("It's coming Bro, relax...")),
          ),
        ),
      ),
    );
  }
}
