import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:good_wallet/ui/layout_widgets/tabbar_layout.dart';
import 'package:good_wallet/ui/shared/image_paths.dart';
import 'package:good_wallet/ui/views/qrcode/qrcode_viewmodel.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
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

class ScanQRCode extends StatefulWidget {
  final Function onScanCodePressed;

  const ScanQRCode({Key key, @required this.onScanCodePressed})
      : super(key: key);

  @override
  _ScanQRCodeState createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  Barcode result;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        verticalSpaceLarge,
        Container(
          height: 250,
          width: 250,
          child: _buildQrView(context),
          // SizedBox.expand(
          //     child: Image.asset(ImageIconPaths.qrcodeScanning)),
        ),
        verticalSpaceLarge,
        ElevatedButton(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Scan", style: textTheme(context).headline5),
            ),
            onPressed: widget.onScanCodePressed),
      ],
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (screenWidth(context) < 400 || screenHeight(context) < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
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
