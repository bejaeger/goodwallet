import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/recipient_info.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/sender_info.dart';
import 'package:good_wallet/enums/money_source.dart';
import 'package:good_wallet/enums/transfer_type.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/transfer_funds/transfer_funds_amount_view.form.dart';
import 'package:good_wallet/ui/views/transfer_funds/transfer_funds_amount_viewmodel.dart';
import 'package:good_wallet/ui/widgets/alternative_screen_header_small.dart';
import 'package:good_wallet/ui/widgets/call_to_action_button.dart';
import 'package:good_wallet/ui/widgets/transfer_funds/transfer_funds.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

// View to choose amount for various transfers:
// 1. Sending money to other users GW
// 2. Contributing to Money View
// 3. Donating
// 4. Top up of money pool fund
// 5. committing money

// TODO: Make unions of recipientInfo and senderInfo
// This allows for easy switching of UI and is scalable and maintainable!

@FormView(fields: [
  FormTextField(name: 'amount'),
])
class TransferFundsAmountView extends StatelessWidget
    with $TransferFundsAmountView {
  final TransferType type;
  final SenderInfo senderInfo;
  RecipientInfo? recipientInfo;
  final void Function()? onContinuePressed;

  TransferFundsAmountView(
      {Key? key,
      required this.type,
      required this.senderInfo,
      this.recipientInfo,
      this.onContinuePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TransferFundsAmountViewModel>.reactive(
      onModelReady: (model) {
        listenToFormUpdated(model);
      },
      viewModelBuilder: () => TransferFundsAmountViewModel(
          type: type, senderInfo: senderInfo, recipientInfo: recipientInfo),
      builder: (context, model, child) {
        String headline = recipientInfo != null
            ? recipientInfo!.maybeMap(
                donation: (value) => "#Give",
                user: (value) => "GiveTheGiftOfGiving",
                moneyPool: (value) => "#RaiseTogehter",
                orElse: () => "#CommitForGood",
              )
            : "#CommitForGood";
        return ConstrainedWidthWithScaffoldLayout(
          resizeToAvoidBottomInset: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: LayoutSettings.horizontalPadding),
            child: Column(
              children: [
                AlternativeScreenHeaderSmall(
                    title: headline, onBackButtonPressed: model.navigateBack),
                verticalSpaceRegular,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Source of transaction
                        if (senderInfo.moneySource == MoneySource.Bank)
                          bankInstituteIcon(context),
                        if (senderInfo.moneySource == MoneySource.PrepaidFund)
                          prepaidFundIcon(context),
                        if (senderInfo.moneySource == MoneySource.GoodWallet)
                          goodWalletIcon(
                              context, model.userStats.currentBalance),
                        // Arrow
                        horizontalSpaceRegular,
                        Icon(Icons.arrow_forward_rounded, size: 40),
                        horizontalSpaceRegular,

                        // Recipients
                        if (type == TransferType.User2UserSent)
                          avatarWithUserName(
                            context,
                            () => model
                                .navigateToPublicProfileView(recipientInfo!.id),
                            recipientName: recipientInfo!.name,
                          ),
                        if (type == TransferType.User2OwnPrepaidFund)
                          topUp(context),
                        if (type == TransferType.User2OwnGoodWallet)
                          hashTagCommitForGood(context),

                        // TODO: make sure recipientInfo is not null!
                        if (recipientInfo is DonationRecipientInfo)
                          projectSummary(
                              context,
                              () => model.navigateToSingleProjectScreen(
                                  projectId: recipientInfo!.id),
                              recipientName: recipientInfo!.name),
                        if (recipientInfo is MoneyPoolRecipientInfo)
                          moneyPoolSummary(context, name: recipientInfo!.name),
                      ],
                    ),
                    verticalSpaceMedium,
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
                    if (model.customValidationMessage != null)
                      Text(
                        model.customValidationMessage!,
                        style: TextStyle(
                          color: Colors.red,
                          //fontSize: kBodyTextSize,
                        ),
                      ),
                    if (model.customValidationMessage != null)
                      verticalSpaceTiny,
                    model.isBusy
                        ? Center(child: CircularProgressIndicator())
                        : CallToActionButtonRectangular(
                            color: MyColors.paletteGreen.withOpacity(0.9),
                            maxWidth:
                                screenWidthPercentage(context, percentage: 0.6),
                            title: "Send",
                            onPressed: () async {
                              await model.showBottomSheetAndProcessPayment();
                            },
                          ),
                    if (type == TransferType.User2Project ||
                        type == TransferType.MoneyPool2User)
                      TextButton(
                        onPressed: () async {
                          await model.changePaymentMethod();
                        },
                        child: Text(
                          "Change Payment Source",
                          style: textTheme(context)
                              .headline4!
                              .copyWith(fontSize: 16),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
