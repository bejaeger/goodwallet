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
  static const Color primaryRed = Color(0xFF941305);
  static const Color lightRed = Color(0xFFcc492f);
  static const Color darkRed = Color(0xFF600000);
  static const Color whiteGrey = Colors.white70;
  static const Color grey = Colors.grey;
  static const Color blackGrey = Colors.black54;
  static Color black = Colors.grey[800];
  static Color lightGrey = Colors.grey[600];
}
