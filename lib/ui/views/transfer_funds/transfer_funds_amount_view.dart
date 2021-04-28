import 'package:flutter/material.dart';
import 'package:good_wallet/enums/fund_transfer_type.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/image_icon_paths.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/transfer_funds/transfer_funds_amount_view.form.dart';
import 'package:good_wallet/ui/views/transfer_funds/transfer_funds_amount_viewmodel.dart';
import 'package:good_wallet/ui/widgets/alternative_screen_header.dart';
import 'package:good_wallet/ui/widgets/call_to_action_button.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:good_wallet/utils/datamodel_helpers.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

// View to choose amount for various transfers:
// 1. Sending money to other users GW
// 2. Contributing to Money View
// 3. Donating
// 4. Top up of money pool fund
// 5. committing money

@FormView(fields: [
  FormTextField(name: 'amount'),
])
class TransferFundsAmountView extends StatelessWidget
    with $TransferFundsAmountView {
  final FundTransferType type;
  final dynamic receiverInfo;
  final void Function()? onContinuePressed;

  TransferFundsAmountView(
      {Key? key, required this.type, this.receiverInfo, this.onContinuePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TransferFundsAmountViewModel>.reactive(
      onModelReady: (model) {
        listenToFormUpdated(model);
        model.setTransferFundTypeAndReceiverInfo(type, receiverInfo);
      },
      viewModelBuilder: () => TransferFundsAmountViewModel(),
      builder: (context, model, child) {
        late String headline;
        if (type == FundTransferType.transferToPeer)
          headline = "#GiveTheGiftOfGiving";
        else if (type == FundTransferType.commitment)
          headline = "#CommitForGood";
        else if (type == FundTransferType.prepaidFundTopUp)
          headline = "#TopUpForGood";
        else if (type == FundTransferType.donation)
          headline = "#Give";
        else if (type == FundTransferType.moneyPoolContribution)
          headline = "#RaiseTogether";
        else if (type == FundTransferType.moneyPoolContributionFromBank)
          headline = "#RaiseTogether";
        else
          headline = "Transfer";
        return ConstrainedWidthWithScaffoldLayout(
          resizeToAvoidBottomInset: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: LayoutSettings.horizontalPadding),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                      onPressed: model.navigateBack,
                    ),
                    Text(
                      headline,
                      style:
                          textTheme(context).bodyText2!.copyWith(fontSize: 16),
                    ),
                    Icon(Icons.help_outline_rounded),
                  ],
                ),
                verticalSpaceRegular,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Source of transaction
                        if (type == FundTransferType.transferToPeer ||
                            type == FundTransferType.commitment ||
                            type == FundTransferType.prepaidFundTopUp ||
                            type == FundTransferType.donationFromBank)
                          bankInstituteIcon(context),
                        if (type == FundTransferType.moneyPoolContribution)
                          prepaidFundIcon(context),
                        if (type ==
                            FundTransferType.moneyPoolContributionFromBank)
                          bankInstituteIcon(context),

                        if (type == FundTransferType.donation)
                          goodWalletIcon(
                              context, model.userWallet.currentBalance),

                        // Arrow
                        horizontalSpaceRegular,
                        Icon(Icons.arrow_forward_rounded, size: 40),
                        horizontalSpaceRegular,

                        // Receiver
                        if (type == FundTransferType.transferToPeer)
                          avatarWithUserName(context),
                        if (type == FundTransferType.commitment)
                          hashTagCommitForGood(context),
                        if (type == FundTransferType.prepaidFundTopUp)
                          topUp(context),
                        if (type == FundTransferType.donation ||
                            type == FundTransferType.donationFromBank)
                          projectSummary(context),
                        if (type == FundTransferType.moneyPoolContribution ||
                            type ==
                                FundTransferType.moneyPoolContributionFromBank)
                          moneyPoolSummary(context),
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
                              await model
                                  .showConfirmationBottomSheetAndProcessPayment();
                            },
                          ),
                    if (type == FundTransferType.donation ||
                        type == FundTransferType.donationFromBank ||
                        type == FundTransferType.moneyPoolContribution ||
                        type == FundTransferType.moneyPoolContributionFromBank)
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

  Widget bankInstituteIcon(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          ImageIconPaths.bankInstitution,
          width: 40,
          height: 40,
          fit: BoxFit.contain,
        ),
        Text("Bank", style: textTheme(context).headline6),
      ],
    );
  }

  Widget goodWalletIcon(BuildContext context, [num? balance]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Good", style: textTheme(context).headline4),
        Text("Wallet", style: textTheme(context).headline4),
        if (balance != null)
          Text("Available: " + formatAmount(balance),
              style: textTheme(context).bodyText2),
      ],
    );
  }

  Widget prepaidFundIcon(BuildContext context) {
    return Column(
      children: [
        Text("Prepaid", style: textTheme(context).headline4),
        Text("Balance", style: textTheme(context).headline4),
      ],
    );
  }

  Widget avatarWithUserName(BuildContext context) {
    return Column(
      children: [
        //Text("Gift money to", style: textTheme(context).headline4),
        //verticalSpaceSmall,
        CircleAvatar(
          radius: 28,
          backgroundColor: MyColors.paletteBlue,
          child: Text(getInitialsFromName(receiverInfo.name),
              style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
        verticalSpaceSmall,
        Text(receiverInfo.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textTheme(context).headline6!.copyWith(fontSize: 15)),
      ],
    );
  }

  Widget projectSummary(BuildContext context) {
    return Column(
      children: [
        //Text("Gift money to", style: textTheme(context).headline4),
        //verticalSpaceSmall,
        CircleAvatar(
          radius: 28,
          backgroundColor: MyColors.primaryRed,
          child: Text(getInitialsFromName(receiverInfo.title),
              style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
        verticalSpaceSmall,
        SizedBox(
          width: screenWidthWithoutPadding(context, percentage: 0.35),
          child: Text(receiverInfo.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textTheme(context).headline6!.copyWith(fontSize: 14)),
        ),
      ],
    );
  }

  Widget moneyPoolSummary(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //Text("Gift money to", style: textTheme(context).headline4),
        //verticalSpaceSmall,
        CircleAvatar(
          radius: 28,
          backgroundColor: MyColors.paletteTurquoise,
          child: Text(getInitialsFromName(receiverInfo.name),
              style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
        verticalSpaceSmall,
        SizedBox(
          width: screenWidthWithoutPadding(context, percentage: 0.35),
          child: Text(receiverInfo.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textTheme(context).headline6!.copyWith(fontSize: 14)),
        ),
      ],
    );
  }

  Widget hashTagCommitForGood(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Wallet", style: textTheme(context).headline4),
        Text("Good", style: textTheme(context).headline4),
      ],
    );
  }

  Widget topUp(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Prepaid fund", style: textTheme(context).headline4),
        //Text("#Topup", style: textTheme(context).headline6),
      ],
    );
  }
}
