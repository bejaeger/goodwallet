// widget looking like a credit card providing the balances of the Good Wallet

import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/image_icon_paths.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'call_to_action_button.dart';

class GoodWalletCard extends StatelessWidget {
  final void Function() onCardTap;
  final void Function() onQRCodeTap;
  final void Function()? onShowTransactionsPressed;
  final void Function()? onFavoriteCharitiesPressed;
  final void Function()? onHistoryButtonPressed;
  final void Function()? onCommitButtonPressed;
  final void Function()? onDonateButtonPressed;
  final num currentBalance;
  final num totalDonations;
  final num totalRaised;
  final num totalGifted;
  final String userInfo;
  final bool showGoodometer;

  const GoodWalletCard(
      {Key? key,
      required this.onCardTap,
      required this.currentBalance,
      required this.totalDonations,
      required this.totalRaised,
      required this.totalGifted,
      required this.userInfo,
      required this.onQRCodeTap,
      this.showGoodometer = false,
      this.onShowTransactionsPressed,
      this.onFavoriteCharitiesPressed,
      this.onHistoryButtonPressed,
      this.onCommitButtonPressed,
      this.onDonateButtonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardTap,
      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        color: Colors.white,
        child: Container(
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(16.0),
          //   border: Border.all(
          //       color: ColorSettings.primaryColor.withOpacity(0.8), width: 2),
          // ),
          width: screenWidthWithoutPadding(context) - 8.0,
          height: 220,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Container(
              //   child: Opacity(
              //     opacity: 0.8,
              //     child: Image.asset(
              //       ImagePath.creditCardBackground,
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    //stops: [0.0, 1.0],
                    colors: [
                      // Colors.white.withOpacity(0.2),
                      // Colors.white.withOpacity(0.9),
                      MyColors.paletteBlue.withOpacity(0.8),
                      MyColors.paletteBlue.withOpacity(0.8),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 15.0, bottom: 0.0, left: 25.0, right: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width:
                              screenWidthPercentage(context, percentage: 0.28),
                          child: FittedBox(
                            fit: BoxFit.none,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Your Balance",
                                  style: textTheme(context).bodyText1!.copyWith(
                                        fontSize: 20,
                                      ),
                                ),
                                //verticalSpaceTiny,
                                Text(
                                  formatAmount(currentBalance),
                                  maxLines: 1,
                                  style: textTheme(context).headline1!.copyWith(
                                        fontSize: 32,
                                      ),
                                ),
                                //verticalSpaceTiny,
                                Text(
                                  "To be donated",
                                  maxLines: 1,
                                  style: textTheme(context).bodyText1!.copyWith(
                                        fontSize: 13,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // GoodWalletLogo(
                            //     textColor: ColorSettings.whiteTextColor),
                            // horizontalSpaceSmall,
                            //
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: displayQRCode(context),
                            ),
                            if (onDonateButtonPressed != null)
                              CallToActionIcon(
                                text: "Give",
                                showText: true,
                                onPressed: onDonateButtonPressed,
                                textColor: ColorSettings.whiteTextColor,
                                backgroundColor: MyColors.paletteBlue,
                                icon: Icon(Icons.favorite,
                                    color: ColorSettings.whiteTextColor),
                              ),
                            if (onDonateButtonPressed != null)
                              horizontalSpaceTiny,
                            if (onCommitButtonPressed != null)
                              CallToActionIcon(
                                text: "Commit",
                                showText: true,
                                onPressed: onCommitButtonPressed,
                                textColor: ColorSettings.whiteTextColor,
                                backgroundColor: MyColors.paletteBlue,
                                icon: Icon(Icons.attach_money_outlined,
                                    color: ColorSettings.whiteTextColor,
                                    size: 28),
                              ),
                            if (onCommitButtonPressed != null)
                              horizontalSpaceTiny,
                            if (onHistoryButtonPressed != null)
                              CallToActionIcon(
                                text: "History",
                                showText: true,
                                onPressed: onHistoryButtonPressed,
                                textColor: ColorSettings.whiteTextColor,
                                backgroundColor: MyColors.paletteBlue,
                                icon: Icon(Icons.history_rounded,
                                    color: ColorSettings.whiteTextColor),
                              ),
                            if (onShowTransactionsPressed != null &&
                                onFavoriteCharitiesPressed != null)
                              horizontalSpaceTiny,
                            if (onShowTransactionsPressed != null &&
                                onFavoriteCharitiesPressed != null)
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0),
                                    color:
                                        MyColors.paletteBlue.withOpacity(0.3)),
                                child: PopupMenuButton(
                                  padding: const EdgeInsets.all(8.0),
                                  onSelected: (int index) {
                                    if (index == 0) {
                                      onShowTransactionsPressed!();
                                    } else if (index == 1) {
                                      onFavoriteCharitiesPressed!();
                                    }
                                  },
                                  icon: Icon(
                                    Icons.more_vert_rounded,
                                    color: ColorSettings.whiteTextColor,
                                  ),
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: 0,
                                      child: Text("All transactions"),
                                    ),
                                    PopupMenuItem(
                                      value: 1,
                                      child: Text("Your supported projects"),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    verticalSpaceSmall,
                    if (showGoodometer)
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: GestureDetector(
                          onTap: onQRCodeTap,
                          child: SizedBox(
                            height: 45,
                            width: 45,
                            child: QrImage(
                              foregroundColor:
                                  ColorSettings.qrCodeOnWalletColor,
                              backgroundColor: ColorSettings.greyTextColor!,
                              padding: const EdgeInsets.all(2.0),
                              data: userInfo,
                            ),
                          ),
                        ),
                      ),
                    verticalSpaceSmall,
                    showGoodometer
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              verticalSpaceSmall,
                              FittedBox(
                                child: Row(
                                  children: [
                                    Text(
                                      "Good Wallet Goodometer: ",
                                      style: textTheme(context)
                                          .bodyText1!
                                          .copyWith(
                                            fontSize: 18,
                                          ),
                                    ),
                                    Text(
                                      "\$ 10789",
                                      style: textTheme(context)
                                          .bodyText1!
                                          .copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              // Text("Total raised by our community",
                              //     style: textTheme(context).bodyText2),
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                //displayQRCode(context),
                                _buildStatItem(
                                  context,
                                  "Total donations",
                                  formatAmount(totalDonations),
                                ),
                                horizontalSpaceRegular,
                                _buildStatItem(
                                  context,
                                  "Total raised",
                                  formatAmount(totalRaised),
                                ),
                                horizontalSpaceRegular,
                                _buildStatItem(
                                  context,
                                  "Total gifted",
                                  formatAmount(totalGifted),
                                ),
                              ],
                            ),
                          )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector displayQRCode(BuildContext context) {
    return GestureDetector(
      onTap: onQRCodeTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(4.0),
            // decoration: BoxDecoration(
            //     border: Border.all(color: ColorSettings.greyTextColor!)),
            height: 70,
            width: 70,
            child: QrImage(
              foregroundColor: ColorSettings.qrCodeOnWalletColor,
              backgroundColor: ColorSettings.greyTextColor!,
              padding: const EdgeInsets.all(1.0),
              data: userInfo,
            ),
          ),
          Text("QR code",
              style: textTheme(context)
                  .bodyText1!
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 16))
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String count) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: textTheme(context).bodyText1!,
        ),
        Text(
          count,
          style: textTheme(context)
              .bodyText1!
              .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }
}
