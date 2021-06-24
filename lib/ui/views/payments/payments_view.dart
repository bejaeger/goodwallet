import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/views/payments/payments_view.form.dart';
import 'package:good_wallet/ui/widgets/call_to_action_button.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'payment_sheet_viewModel.dart';

@FormView(fields: [
  FormTextField(name: 'amount'),
])
class PaymentView extends StatelessWidget with $PaymentView {
  PaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PaymentViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      "\$",
                      style: textTheme(context).bodyText2!.copyWith(
                          fontSize: 35,
                          color: ColorSettings.blackHeadlineColor),
                    ),
                  ),
                  Flexible(
                    child: TextField(
                      focusNode: amountFocusNode,
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: textTheme(context).bodyText2!.copyWith(
                          fontSize: 35,
                          color: ColorSettings.blackHeadlineColor),
                      autofocus: true,
                    ),
                  ),
                ],
              ),
            ),
            verticalSpaceLarge,
            CallToActionButtonRectangular(
              color: MyColors.paletteGreen.withOpacity(0.9),
              maxWidth: screenWidthPercentage(context, percentage: 0.6),
              title: "Send",
              onPressed: () async {
                /// model.initPaymentSheet;

                model.sendAmount(amount: amountController.text.toString());
                amountController.clear();
              },
            ),
            /*
              if (model != null)
                Text(
                  'Harguilar Tested This',
                  // model.customValidationMessage!,
                  style: TextStyle(
                    color: Colors.red,
                    //fontSize: kBodyTextSize,
                  ),
                ),
              if (model.customValidationMessage != null) verticalSpaceTiny,
              model.isBusy
                  ? Center(child: CircularProgressIndicator())
                  : CallToActionButtonRectangular(
                      color: MyColors.paletteGreen.withOpacity(0.9),
                      maxWidth: screenWidthPercentage(context, percentage: 0.6),
                      title: "Send",
                      onPressed: () async {
                        /// model.initPaymentSheet;
                        model.sendAmount();
                      },
                    ),
              TextButton(
                onPressed: model.sendAmount(),
                //model.getPaymentSheetData != null
                //? null
                // : model.initPaymentSheet,
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
            */
          ]),
        ),
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