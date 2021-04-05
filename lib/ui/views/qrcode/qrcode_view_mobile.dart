import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:good_wallet/ui/layout_widgets/tabbar_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/image_icon_paths.dart';
import 'package:good_wallet/ui/shared/image_paths.dart';
import 'package:good_wallet/ui/views/qrcode/qrcode_viewmodel.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:stacked/stacked.dart';

class QRCodeViewMobile extends StatelessWidget {
  final int initialIndex;
  const QRCodeViewMobile({Key key, this.initialIndex = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QRCodeViewModel>.reactive(
      viewModelBuilder: () => QRCodeViewModel(),
      builder: (context, model, child) =>
          TabBarLayout(initialIndex: initialIndex, title: "QR Code", tabs: [
        SizedBox(
          width: screenWidth(context) * 0.4,
          child: Tab(text: "Scan QR Code"),
        ),
        SizedBox(
          width: screenWidth(context) * 0.4,
          child: Tab(text: "My QR Code"),
        ),
      ], views: [
        ScanQRCode(
          onScanCodePressed: model.showNotImplementedSnackbar,
        ),
        MyQRCode(userInfo: model.getUserInfo()),
      ]),
    );
  }
}

class ScanQRCode extends StatelessWidget {
  final Function onScanCodePressed;

  const ScanQRCode({Key key, @required this.onScanCodePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        verticalSpaceLarge,
        Container(
          height: 250,
          width: 250,
          child: SizedBox.expand(
              child: Image.asset(ImageIconPaths.qrcodeScanning)),
        ),
        verticalSpaceLarge,
        ElevatedButton(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Scan", style: textTheme(context).headline5),
            ),
            onPressed: onScanCodePressed),
      ],
    );
  }
}

class MyQRCode extends StatelessWidget {
  final String userInfo;
  const MyQRCode({Key key, @required this.userInfo}) : super(key: key);

  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 100.0,
        height: 100.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(90.0),
          child: Image.network(
            ImagePath.profilePicURL,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        verticalSpaceLarge,
        _buildProfileImage(),
        verticalSpaceSmall,
        Center(
          child: Text(
            jsonDecode(userInfo)["name"],
            style: textTheme(context).headline6,
          ),
        ),
        verticalSpaceMediumLarge,
        Center(
          child: Container(
            height: 250,
            width: 250,
            child: QrImage(
              data: userInfo,
            ),
          ),
        ),
        verticalSpaceMedium,
        Center(
          child: Container(
            height: 250,
            width: 250,
            child: Text(
              "Have your friend scan this QR code to transfer money to you",
            ),
          ),
        ),
      ],
    );
  }
}
