import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'payment_sheet_viewModel.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PaymentViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: model.getPaymentSheetData != null
                  ? null
                  : model.initPaymentSheet,
              child: const Text('Init payment sheet'),
            ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: model.getPaymentSheetData != null
                  ? model.displayPaymentSheet
                  : null,
              child: const Text('Show payment sheet'),
            ),
          ],
        )),
      ),
      viewModelBuilder: () => PaymentViewModel(),
    );
  }
}


/*
class PaymentView extends StatefulWidget {
  @override
  _PaymentSheetViewState createState() => _PaymentSheetViewState();
}

class _PaymentSheetViewState extends State<PaymentView> {

  //Map<String, dynamic>? _paymentSheetData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: _paymentSheetData != null ? null : _initPaymentSheet,
            child: const Text('Init payment sheet'),
          ),
          const SizedBox(height: 24),
          TextButton(
            onPressed: _paymentSheetData != null ? _displayPaymentSheet : null,
            child: const Text('Show payment sheet'),
          ),
        ],
      )),
    );
  }

  */