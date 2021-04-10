// widget looking like a credit card providing the balances of the Good Wallet

import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/user/qr_code_user_info_model.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/image_paths.dart';
import 'package:good_wallet/ui/widgets/good_wallet_logo.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GoodWalletCard extends StatelessWidget {
  final void Function() onCardTap;
  final void Function() onQRCodeTap;
  final num currentBalance;
  final num totalDonations;
  final num totalRaised;
  final String userInfo;

  const GoodWalletCard(
      {Key? key,
      required this.onCardTap,
      required this.currentBalance,
      required this.totalDonations,
      required this.totalRaised,
      required this.userInfo,
      required this.onQRCodeTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardTap,
      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.white,
        child: Container(
          width: screenWidthWithoutPadding(context) - 8.0,
          child: AspectRatio(
            aspectRatio: 1.586, // aspect ratio credit card
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
                        ColorSettings.primaryColor.withOpacity(0.5),
                        ColorSettings.primaryColor.withOpacity(0.1),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 5.0, left: 20.0, right: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Current Balance",
                                style: textTheme(context).bodyText2!.copyWith(
                                    fontSize: 18,
                                    color: ColorSettings.greyTextColor),
                              ),
                              verticalSpaceSmall,
                              Text("\$" + (currentBalance / 100).toString(),
                                  style: textTheme(context).headline2!.copyWith(
                                      fontSize: 32,
                                      color: ColorSettings.greyTextColor)),
                            ],
                          ),
                          GoodWalletLogo(),
                        ],
                      ),
                      verticalSpaceRegular,
                      GestureDetector(
                        onTap: onQRCodeTap,
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: QrImage(
                            foregroundColor: ColorSettings.qrCodeOnWalletColor,
                            backgroundColor: ColorSettings.greyTextColor!,
                            padding: const EdgeInsets.all(0.0),
                            data: userInfo,
                          ),
                        ),
                      ),
                      verticalSpaceRegular,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildStatItem(
                              context,
                              "Total donations",
                              "\$" + (totalDonations / 100).toString(),
                              ColorSettings.primaryColor),
                          _buildStatItem(
                              context,
                              "Total raised",
                              "\$" + (totalRaised / 100).toString(),
                              ColorSettings.primaryColor),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(
      BuildContext context, String label, String count, Color? color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: textTheme(context).bodyText2!.copyWith(color: color),
        ),
        Text(
          count,
          style: textTheme(context).bodyText2!.copyWith(
              fontWeight: FontWeight.bold, fontSize: 18, color: color),
        ),
      ],
    );
  }
}
