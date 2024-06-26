// widget looking like a credit card providing the balances of the Good Wallet

import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
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
  final double margins;
  final String title;
  final bool showQRCode;
  final double titleWidthPercentage;
  final bool highlightTotalDonations;

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
      this.onDonateButtonPressed,
      this.margins = 4.0,
      this.title = "Your Balance",
      this.showQRCode = true,
      this.titleWidthPercentage = 0.28,
      this.highlightTotalDonations = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardTap,
      child: Card(
        margin: EdgeInsets.all(margins),
        clipBehavior: Clip.hardEdge,
        elevation: 10.0,
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
          height: 235,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                // DecoratedBox(
                //   decoration: BoxDecoration(
                //     gradient: LinearGradient(
                //       begin: Alignment.topLeft,
                //       end: Alignment.bottomRight,
                //       //stops: [0.0, 1.0],
                //       colors: [
                //         // Colors.white.withOpacity(0.2),
                //         // Colors.white.withOpacity(0.9),
                //         MyColors.paletteBlue.withOpacity(0.3),
                //         MyColors.paletteBlue.withOpacity(0.0),
                //       ],
                //     ),
                //   ),
                // ),
                Flexible(
                  flex: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                title,
                                style: textTheme(context).bodyText2!.copyWith(
                                      fontSize: 20,
                                    ),
                              ),
                            ),
                            if (highlightTotalDonations) verticalSpaceSmall,
                            //verticalSpaceTiny,
                            Flexible(
                              child: Text(
                                formatAmount(highlightTotalDonations
                                    ? totalDonations
                                    : currentBalance),
                                maxLines: 1,
                                style: textTheme(context).headline2!.copyWith(
                                      fontSize: 32,
                                    ),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                highlightTotalDonations
                                    ? "Total Donations"
                                    : "To be donated",
                                maxLines: 1,
                                style: textTheme(context).bodyText2!.copyWith(
                                      fontSize: 13,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Spacer(),
                      if (showQRCode) FittedBox(child: displayQRCode(context)),
                    ],
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    //displayQRCode(context),
                    Expanded(
                      child: _buildStatItem(
                        context,
                        highlightTotalDonations
                            ? "Current balance"
                            : "Total donations",
                        formatAmount(highlightTotalDonations
                            ? currentBalance
                            : totalDonations),
                      ),
                    ),
                    horizontalSpaceRegular,
                    Expanded(
                      child: _buildStatItem(
                        context,
                        "Total raised",
                        formatAmount(totalRaised),
                      ),
                    ),
                    horizontalSpaceRegular,
                    Expanded(
                      child: _buildStatItem(
                        context,
                        "Total gifted",
                        formatAmount(totalGifted),
                      ),
                    ),
                  ],
                ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Row(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Container(
                //           width: screenWidthPercentage(context,
                //               percentage: titleWidthPercentage),
                //           child: FittedBox(
                //             fit: BoxFit.none,
                //             // child: Column(
                //             //   crossAxisAlignment: CrossAxisAlignment.start,
                //             //   children: [
                //             //     Text(
                //             //       title,
                //             //       style: textTheme(context).bodyText2!.copyWith(
                //             //             fontSize: 20,
                //             //           ),
                //             //     ),
                //             //     if (highlightTotalDonations) verticalSpaceSmall,
                //             //     //verticalSpaceTiny,
                //             //     Text(
                //             //       formatAmount(highlightTotalDonations
                //             //           ? totalDonations
                //             //           : currentBalance),
                //             //       maxLines: 1,
                //             //       style: textTheme(context).headline2!.copyWith(
                //             //             fontSize: 32,
                //             //           ),
                //             //     ),
                //             //     Text(
                //             //       highlightTotalDonations
                //             //           ? "Total Donations"
                //             //           : "To be donated",
                //             //       maxLines: 1,
                //             //       style: textTheme(context).bodyText2!.copyWith(
                //             //             fontSize: 13,
                //             //           ),
                //             //     ),
                //             //   ],
                //             // ),
                //           ),
                //         ),
                //         Row(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           mainAxisAlignment: MainAxisAlignment.end,
                //           children: [
                //             // GoodWalletLogo(
                //             //     textColor: ColorSettings.whiteTextColor),
                //             // horizontalSpaceSmall,
                //             // //
                //             // if (showQRCode)
                //             //   Padding(
                //             //     padding: const EdgeInsets.all(5.0),
                //             //     child: displayQRCode(context),
                //             //   ),
                //             if (onDonateButtonPressed != null)
                //               CallToActionIcon(
                //                 text: "Give",
                //                 showText: true,
                //                 onPressed: onDonateButtonPressed,
                //                 textColor: ColorSettings.whiteTextColor,
                //                 backgroundColor: MyColors.paletteBlue,
                //                 icon: Icon(Icons.favorite,
                //                     color: ColorSettings.whiteTextColor),
                //               ),
                //             if (onDonateButtonPressed != null)
                //               horizontalSpaceTiny,
                //             if (onCommitButtonPressed != null)
                //               CallToActionIcon(
                //                 text: "Commit",
                //                 showText: true,
                //                 onPressed: onCommitButtonPressed,
                //                 textColor: ColorSettings.whiteTextColor,
                //                 backgroundColor: MyColors.paletteBlue,
                //                 icon: Icon(Icons.attach_money_outlined,
                //                     color: ColorSettings.whiteTextColor,
                //                     size: 28),
                //               ),
                //             if (onCommitButtonPressed != null)
                //               horizontalSpaceTiny,
                //             if (onHistoryButtonPressed != null)
                //               CallToActionIcon(
                //                 text: "History",
                //                 showText: true,
                //                 onPressed: onHistoryButtonPressed,
                //                 textColor: ColorSettings.whiteTextColor,
                //                 backgroundColor: MyColors.paletteBlue,
                //                 icon: Icon(Icons.history_rounded,
                //                     color: ColorSettings.whiteTextColor),
                //               ),
                //             if (onShowTransactionsPressed != null &&
                //                 onFavoriteCharitiesPressed != null)
                //               horizontalSpaceTiny,
                //             if (onShowTransactionsPressed != null &&
                //                 onFavoriteCharitiesPressed != null)
                //               Container(
                //                 decoration: BoxDecoration(
                //                     borderRadius: BorderRadius.circular(16.0),
                //                     color: MyColors.paletteBlue.withOpacity(0.3)),
                //                 child: PopupMenuButton(
                //                   padding: const EdgeInsets.all(8.0),
                //                   onSelected: (int index) {
                //                     if (index == 0) {
                //                       onShowTransactionsPressed!();
                //                     } else if (index == 1) {
                //                       onFavoriteCharitiesPressed!();
                //                     }
                //                   },
                //                   icon: Icon(
                //                     Icons.more_vert_rounded,
                //                     color: ColorSettings.whiteTextColor,
                //                   ),
                //                   itemBuilder: (context) => [
                //                     PopupMenuItem(
                //                       value: 0,
                //                       child: Text("All transactions"),
                //                     ),
                //                     PopupMenuItem(
                //                       value: 1,
                //                       child: Text("Your supported projects"),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //           ],
                //         ),
                //       ],
                //     ),
                //     verticalSpaceSmall,
                //     if (showGoodometer)
                //       Padding(
                //         padding: const EdgeInsets.only(left: 20.0),
                //         child: GestureDetector(
                //           onTap: onQRCodeTap,
                //           child: SizedBox(
                //             height: 45,
                //             width: 45,
                //             child: QrImage(
                //               foregroundColor: ColorSettings.qrCodeOnWalletColor,
                //               backgroundColor: ColorSettings.greyTextColor!,
                //               padding: const EdgeInsets.all(2.0),
                //               data: userInfo,
                //             ),
                //           ),
                //         ),
                //       ),
                //     verticalSpaceSmall,
                //     showGoodometer
                //         ? Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               verticalSpaceSmall,
                //               FittedBox(
                //                 child: Row(
                //                   children: [
                //                     Text(
                //                       "Good Wallet Goodometer: ",
                //                       style:
                //                           textTheme(context).bodyText1!.copyWith(
                //                                 fontSize: 18,
                //                               ),
                //                     ),
                //                     Text(
                //                       "\$ 10789",
                //                       style:
                //                           textTheme(context).bodyText1!.copyWith(
                //                                 fontSize: 18,
                //                                 fontWeight: FontWeight.w600,
                //                               ),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //               // Text("Total raised by our community",
                //               //     style: textTheme(context).bodyText2),
                //             ],
                //           )
                //         : Container(),
                //     // : Padding(
                //     //     padding: const EdgeInsets.only(bottom: 8.0),
                //     //     child: Row(
                //     //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     //       crossAxisAlignment: CrossAxisAlignment.end,
                //     //       children: [
                //     //         //displayQRCode(context),
                //     //         Expanded(
                //     //           child: _buildStatItem(
                //     //             context,
                //     //             highlightTotalDonations
                //     //                 ? "Current balance"
                //     //                 : "Total donations",
                //     //             formatAmount(highlightTotalDonations
                //     //                 ? currentBalance
                //     //                 : totalDonations),
                //     //           ),
                //     //         ),
                //     //         horizontalSpaceRegular,
                //     //         Expanded(
                //     //           child: _buildStatItem(
                //     //             context,
                //     //             "Total raised",
                //     //             formatAmount(totalRaised),
                //     //           ),
                //     //         ),
                //     //         horizontalSpaceRegular,

                //     //         Expanded(
                //     //           child: _buildStatItem(
                //     //             context,
                //     //             "Total gifted",
                //     //             formatAmount(totalGifted),
                //     //           ),
                //     //         ),
                //     //       ],
                //     //     ),
                //     //   )
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget displayQRCode(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onQRCodeTap,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: MyColors.paletteGrey.withOpacity(0.07)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                      style: textTheme(context).bodyText2!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: ColorSettings.blackHeadlineColor))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String count) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: textTheme(context).bodyText2!),
        Text(
          count,
          style: textTheme(context).bodyText2!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: ColorSettings.blackHeadlineColor),
        ),
      ],
    );
  }
}
