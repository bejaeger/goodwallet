import 'package:flutter/material.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:stacked_services/stacked_services.dart';

void setupSnackbarUi() {
  final service = locator<SnackbarService>();

  // Registers a config to be used when calling showSnackbar
  service.registerSnackbarConfig(SnackbarConfig(
    backgroundColor: ColorSettings.blackTextColor!,
    textColor: ColorSettings.whiteTextColor!,
    titleColor: ColorSettings.whiteTextColor!,
    messageColor: ColorSettings.whiteTextColor!,
    mainButtonTextColor: ColorSettings.whiteTextColor,
  ));
}
