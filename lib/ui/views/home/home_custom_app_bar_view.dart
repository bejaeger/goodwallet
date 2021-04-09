import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/home/home_custom_app_bar_viewmodel.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class HomeCustomAppBarView extends SliverPersistentHeaderDelegate {
  final double minExtent;
  final double maxExtent;

  HomeCustomAppBarView({required this.minExtent, required this.maxExtent});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double shrinkPercentage =
        (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);
    const double leftPadding = 20.0;
    // print("shrinkPercentage = $shrinkPercentage");
    // print("shrinkOffset = $shrinkOffset");
    // print("overlaps = $overlapsContent");
    return ViewModelBuilder<HomeCustomAppBarViewModel>.reactive(
      viewModelBuilder: () => HomeCustomAppBarViewModel(),
      builder: (context, model, child) => Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            //'https://burst.shopifycdn.com/photos/white-copper-and-wood-background.jpg?width=373&format=pjpg&exif=0&iptc=0',
            'https://burst.shopifycdn.com/photos/hands-hold-red-apple.jpg?width=373&format=pjpg&exif=0&iptc=0',
            fit: BoxFit.cover,
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 1.0],
                colors: [Colors.transparent, Colors.white],
              ),
            ),
          ),
          Container(
              color: Colors.white
                  .withOpacity((0.4 + 0.6 * shrinkPercentage).clamp(0.0, 1.0))),
          Positioned(
            left: leftPadding,
            bottom: (10.0 - shrinkOffset * 0.2).clamp(0.0, 35.0),
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxWidth: screenWidth(context) - leftPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Opacity(
                        opacity: 1 - shrinkPercentage,
                        child: Text('\$ 1003.10',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                    color: ColorSettings.blackTextColor)),
                      ),
                      Text(
                        'Total raised by our community',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 15,
                              color:
                                  ColorSettings.lightGreyTextColor!.withOpacity(
                                (1 - shrinkPercentage),
                              ),
                            ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: leftPadding,
                        bottom: shrinkPercentage > 0.9 ? 20.0 : 0.0),
                    child: GestureDetector(
                        onTap: () => null,
                        child: Icon(
                          Icons.person_outline_rounded,
                          size: 30,
                        )
                        // CircleAvatar(
                        //     radius: 22,
                        //     backgroundColor:
                        //         Theme.of(context).primaryColor.withOpacity(0.1),
                        //     child: Icon(Icons.person_outline_rounded)),
                        ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: leftPadding,
            bottom: maxExtent *
                0.5 *
                (1 - 0.85 * shrinkPercentage), // * (1 - shrinkPercentage),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: getBkgColor(context).withOpacity(0.0)),
              child: Text('The Good Wallet',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: ColorSettings.blackHeadlineColor,
                      fontSize: (30.0 * (1.0 - shrinkPercentage * 0.15))
                          .clamp(25.0, 30.0))),
            ),
          ),
        ],
      ),
    );
  }

  double titleOpacity(double shrinkOffset) {
    // simple formula: fade out text as soon as shrinkOffset > 0
    return 1.0 - max(0.0, shrinkOffset) / maxExtent;
    // more complex formula: starts fading out text when shrinkOffset > minExtent
    //return 1.0 - max(0.0, (shrinkOffset - minExtent)) / (maxExtent - minExtent);
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration =>
      OverScrollHeaderStretchConfiguration(
        stretchTriggerOffset: maxExtent,
      );
}
