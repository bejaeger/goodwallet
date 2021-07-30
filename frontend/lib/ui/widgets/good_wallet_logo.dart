import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/image_icon_paths.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

class GoodWalletLogo extends StatelessWidget {
  final double heightLogo;
  final Color? textColor;

  const GoodWalletLogo({Key? key, this.heightLogo = 25, this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: heightLogo,
          child: AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              child:
                  Image.asset(ImageIconPaths.holdingHands, fit: BoxFit.cover),
            ),
          ),
        ),
        Text("Good Wallet",
            style: textTheme(context).bodyText2!.copyWith(
                fontSize: 11,
                color: textColor ?? ColorSettings.blackHeadlineColor)),
      ],
    );
  }
}
