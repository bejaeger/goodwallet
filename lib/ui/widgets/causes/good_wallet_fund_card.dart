import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/causes/good_wallet_fund_model.dart';
import 'package:good_wallet/ui/widgets/carousel_card.dart';

class GoodWalletFundCardMobile extends StatelessWidget {
  final GoodWalletFundModel fund;
  final Function onTap;

  const GoodWalletFundCardMobile({Key key, this.fund, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: CarouselCard(
        title: fund.title,
        onTap: onTap,
        explanation: fund.description,
        showImage: true,
      ),
    );
  }
}
