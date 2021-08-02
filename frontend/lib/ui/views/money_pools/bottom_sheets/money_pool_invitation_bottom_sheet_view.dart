import 'package:flutter/material.dart';
import 'package:good_wallet/ui/layout_widgets/confirmation_bottom_sheet_layout.dart';
import 'package:good_wallet/ui/views/money_pools/bottom_sheets/money_pool_invitation_bottom_sheet_viewmodel.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MoneyPoolInvitationBottomSheetView extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;

  const MoneyPoolInvitationBottomSheetView(
      {Key? key, required this.completer, required this.request})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MoneyPoolInvitationBottomSheetViewModel>.reactive(
      viewModelBuilder: () => MoneyPoolInvitationBottomSheetViewModel(),
      builder: (context, model, child) => ConfirmationBottomSheetLayout(
        title: "Invitation to Money Pool",
        onAcceptPressed: () => completer(
          SheetResponse(confirmed: true),
        ),
        onCancelPressed: () => completer(
          SheetResponse(confirmed: false),
        ),
        centerWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Name: ",
                    style:
                        textTheme(context).headline6!.copyWith(fontSize: 18)),
                Text(request.data.name,
                    style:
                        textTheme(context).bodyText2!.copyWith(fontSize: 18)),
              ],
            ),
            verticalSpaceTiny,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Admin: ",
                    style:
                        textTheme(context).headline6!.copyWith(fontSize: 18)),
                Text(request.data.adminName,
                    style:
                        textTheme(context).bodyText2!.copyWith(fontSize: 18)),
              ],
            ),
            if (request.data.description != null) verticalSpaceTiny,
            if (request.data.description != null)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Description: ",
                      style:
                          textTheme(context).headline6!.copyWith(fontSize: 18)),
                  Text(request.data.description!,
                      style:
                          textTheme(context).bodyText2!.copyWith(fontSize: 18)),
                ],
              ),
            verticalSpaceMedium,
          ],
        ),
      ),
    );
  }
}
