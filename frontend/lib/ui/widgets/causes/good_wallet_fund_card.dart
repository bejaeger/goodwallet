import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/causes/concise_info/concise_project_info.dart';
import 'package:good_wallet/ui/widgets/carousel_card.dart';

class GoodWalletFundCardMobile extends StatelessWidget {
  final ConciseProjectInfo fund;
  final Function? onTap;
  final Alignment? imageAlignment;
  final ImageProvider? backgroundImage;

  const GoodWalletFundCardMobile(
      {Key? key,
      required this.fund,
      this.onTap,
      this.imageAlignment,
      this.backgroundImage})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: CarouselCard(
        title: fund.name,
        onTap: onTap as void Function()?,
        explanation: fund.description,
        backgroundImage: backgroundImage,
        imageAlignment: imageAlignment,
      ),
    );
  }
}
