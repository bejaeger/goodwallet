import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/views/payments/payments_view.form.dart';
import 'package:good_wallet/ui/widgets/buttons/loading_buttons.dart';
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
  int amountRcv = 0;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PaymentViewModel>.reactive(
      /// onModelReady: (model) => model.initPayment(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(hintText: 'Email'),
                onChanged: (value) {
                  model.setEmail(email: value);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: CardField(
                onCardChanged: (card) {
                  model.setCardFiel(card: card);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: LoadingButton(
                onPressed: model.getCardField?.complete == true
                    ? model.handlePayPress
                    : null,
                text: 'Save',
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: LoadingButton(
                onPressed: model.getSetupIntentResult != null
                    ? model.handleOffSessionPayment
                    : null,
                text: 'Pay with saved card off-session',
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: LoadingButton(
                onPressed: model.getRetrievedPaymentIntent != null
                    ? model.handleRecoveryFlow
                    : null,
                text: 'Authenticate payment',
              ),
            ),
          ],
        ),
        /*Center(
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
                try {
                  amountRcv = int.parse(amountController.text.toString());

                  /// model.initPaymentSheet;
                  model.payNewCard(amount: '500', currency: 'USD');
                  amountController.clear();
                } catch (e) {
                  print(e);
                }
              },
            ),
          ]),
        ),*/
      ),
      viewModelBuilder: () => PaymentViewModel(amount: amountRcv),
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