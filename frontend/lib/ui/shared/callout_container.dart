import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:good_wallet/ui/shared/custom_shape.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

import 'color_settings.dart';

class CalloutContainer extends StatelessWidget {
  final String title;
  final String description;
  const CalloutContainer(
      {Key? key, required this.title, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Flexible(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: CustomPaint(
                painter: CustomShape(MyColors.paletteGreen.withOpacity(1)),
              ),
            ),
            Flexible(
              child:
                  //  Card(
                  //   elevation: 5.0,
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(18.0)),
                  //   child:

                  Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  // boxShadow: <BoxShadow>[
                  //   BoxShadow(
                  //     color: Colors.black54,
                  //     blurRadius: 5.0,
                  //     offset: Offset(0.0, 0.75),
                  //   ),
                  // ],
                  color: MyColors.paletteGreen.withOpacity(1),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(18),
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: textTheme(context)
                            .headline5!
                            .copyWith(color: ColorSettings.whiteTextColor)),
                    Text(description,
                        style: textTheme(context)
                            .bodyText1!
                            .copyWith(color: ColorSettings.whiteTextColor)),
                  ],
                ),
              ),
            ),
          ],
        )),
        // Text(title),
        // Text(description),
      ],
    );
  }
}
