import 'dart:async';

import 'package:flutter/material.dart';
import 'package:good_wallet/enums/money_transfer_dialog_status.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/custom_dialogs/money_transfer_dialog_viewmodel.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';

class MoneyTransferDialogView extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const MoneyTransferDialogView({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MoneyTransferDialogViewModel>.reactive(
        viewModelBuilder: () => MoneyTransferDialogViewModel(),
        onModelReady: (model) => model.waitForTransfer(request: request),
        builder: (context, model, child) => Dialog(
              backgroundColor: Colors.transparent,
              child: _BasicDialogContent(
                request: request,
                completer: completer,
                model: model,
              ),
            ));
  }
}

class _BasicDialogContent extends StatelessWidget {
  final dynamic model;
  final DialogRequest request;
  final Function(DialogResponse dialogResponse) completer;

  _BasicDialogContent({
    Key? key,
    required this.request,
    required this.completer,
    required this.model,
  }) : super(key: key);

  final log = getLogger("donation_dialog_view.dart");

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      AnimatedOpacity(
        duration: Duration(milliseconds: 500),
        opacity: model.isBusy ? 0.0 : 1.0,
        child: model.isBusy
            ? Container(
                color: Colors.transparent,
                width: 50,
                height: 50,
                child: CircularProgressIndicator())
            : Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal:
                          screenWidthPercentage(context, percentage: 0.04),
                    ),
                    padding: const EdgeInsets.only(
                      top: 32,
                      left: 16,
                      right: 16,
                      bottom: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        verticalSpaceSmall,
                        Text(model.title ?? '',
                            textAlign: TextAlign.center,
                            style: textTheme(context).headline6),
                        verticalSpaceSmall,
                        Text(model.description ?? '',
                            textAlign: TextAlign.center),
                        verticalSpaceMedium,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            if (model.secondaryButtonTitle != null)
                              TextButton(
                                onPressed: () =>
                                    completer(DialogResponse(confirmed: false)),
                                child: Text(
                                  model.secondaryButtonTitle!,
                                ),
                              ),
                            TextButton(
                              onPressed: () =>
                                  completer(DialogResponse(confirmed: true)),
                              child: Text(
                                model.mainButtonTitle ?? '',
                                style: textTheme(context).bodyText2!.copyWith(
                                    color: _getStatusColor(model.status),
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: -28,
                    child: CircleAvatar(
                      minRadius: 16,
                      maxRadius: 28,
                      backgroundColor: _getStatusColor(model.status),
                      child: Icon(
                        _getStatusIcon(model.status),
                        size: 28,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
      ),
      if (model.isBusy)
        Container(
            color: Colors.transparent,
            width: screenWidth(context, percentage: 0.7),
            height: 50,
            child: CircularProgressIndicator())
    ]);
  }

  Color _getStatusColor(TransferDialogStatus? status) {
    if (status != null) {
      switch (status) {
        case TransferDialogStatus.error:
          return ColorSettings.primaryColorDark;
        case TransferDialogStatus.warning:
          return Colors.amber.shade800;
        default:
          return MyColors.paletteGreen;
      }
    } else {
      return MyColors.paletteGreen;
    }
  }

  IconData _getStatusIcon(TransferDialogStatus? status) {
    if (status != null) {
      switch (status) {
        case TransferDialogStatus.error:
          return Icons.close;
        case TransferDialogStatus.warning:
          return Icons.warning_amber;
        default:
          return Icons.check;
      }
    } else {
      return Icons.check;
    }
  }

  // TODO: Move that to another file

}
