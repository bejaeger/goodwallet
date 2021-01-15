import 'package:flutter/material.dart';
import 'package:good_wallet/viewmodels/wallet_view_model.dart';
import 'package:good_wallet/views/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class WalletView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ViewModelBuilder<WalletViewModel>.reactive(
      viewModelBuilder: () => WalletViewModel(),
      onModelReady: (model) => model.updateBalances(),
      builder: (context, model, child) => CenteredView(
        maxWidth: 500,
        child: model.currentUser != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenSize.height / 12),
                  _buildFullName(model.currentUser.fullName),
                  //_buildMemberSinceText(context),
                  verticalSpace(10),
                  _buildSeparator(screenSize),
                  verticalSpace(10),
                  _buildStatView(model),
                  verticalSpace(20),
                  _buildTransferButton(model),
                  //_buildRecentActivities(model.currentUser),
                ],
              )
            : _loginButton(model.loginWithGoogle),
      ),
    );
  }

  _buildFullName(String name) {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );
    return Text(
      "Hi, ${name}",
      style: _nameTextStyle,
    );
  }

  _buildSeparator(Size screenSize) {
    return Container(
        width: 300,
        height: 2.0,
        color: Colors.black54,
        margin: EdgeInsets.only(top: 4.0));
  }

  _buildStatView(var model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Balance: ${model.balance * 0.01} \$",
            style: TextStyle(fontSize: 22)),
        Text("Donated: ${model.donations * 0.01} \$",
            style: TextStyle(fontSize: 22)),
        Text("Donated Implicitly: ${model.implicitDonations * 0.01} \$",
            style: TextStyle(fontSize: 22)),
      ],
    );
  }

  _buildTransferButton(dynamic model) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: Colors.lightBlue,
      elevation: 10.0,
      onPressed: () => model.navigateToTransferView(),
      //model.navigateToTransferView(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("Send Money",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
    );
  }

  _loginButton(Function onPressed) {
    return Column(
      children: [
        Container(
          child: FlatButton(
            onPressed: onPressed,
            child: Text(
              "Login with Google",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.lightBlue,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        Text("Login to see your wallet"),
      ],
    );
  }
}
