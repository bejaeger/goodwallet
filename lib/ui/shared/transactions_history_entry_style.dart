// simple class holding style for rendering entries in transaction history

import 'package:flutter/material.dart';

class TransactionHistoryEntryStyle {
  final Color color;
  final Widget icon;
  final String descriptor;
  final String nameToDisplay;

  TransactionHistoryEntryStyle(
      {@required this.color,
      @required this.icon,
      this.descriptor,
      @required this.nameToDisplay});
}
