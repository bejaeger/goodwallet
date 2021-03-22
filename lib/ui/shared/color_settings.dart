import 'dart:ui';
import 'package:flutter/material.dart';

class ColorSettings extends MyColors {
  static const Color primaryColor = MyColors.primaryRed;
  static const Color primaryColorLight = MyColors.lightRed;
  static const Color primaryColorDark = MyColors.darkRed;
  static const Color whiteTextColor = MyColors.whiteGrey;
  static Color greyTextColor = MyColors.blackGrey;
  static Color lightGreyTextColor = MyColors.lightGrey;
  static Color blackTextColor = MyColors.black;
}

class MyColors {
  static const Color whiteGrey = Colors.white70;
  static const Color grey = Colors.grey;
  static const Color blackGrey = Colors.black54;
  static Color black = Colors.grey[800];
  static Color lightGrey = Colors.grey[600];

  // @see https://material.io/resources/color/#!/?view.left=0&view.right=1&primary.color=941305
  static const Color primaryRed = Color(0xFF941305);
  static const Color lightRed = Color(0xFFcc492f);
  static const Color darkRed = Color(0xFF600000);

  // @see https://colorpalettes.net/color-palette-1849/
  static const Color paletteBlue = Color(0xFF145b9c);
  static const Color paletteBlack = Color(0xFF030303);
  static const Color paletteGrey = Color(0xFF747d90);

  static const Color paletteTurquoise = Color(0xFF149c9a);
}
