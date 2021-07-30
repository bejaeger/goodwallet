import 'package:flutter/material.dart';

import 'package:good_wallet/ui/widgets/translate_on_hover.dart';

extension HoverExtensions on Widget {
  // Get a regerence to the body of the view

  Widget get moveUpOnHover {
    return TranslateOnHover(
      child: this,
    );
  }
}
