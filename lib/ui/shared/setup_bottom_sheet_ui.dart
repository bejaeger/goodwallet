import 'package:flutter/material.dart';
import 'package:good_wallet/app/locator.dart';
import 'package:good_wallet/enums/bottom_sheet_type.dart';
import 'package:stacked_services/stacked_services.dart';

void setupBottomSheetUi() {
  final bottomSheetService = locator<BottomSheetService>();

  final builders = {
    BottomSheetType.raise: (context, sheetRequest, completer) =>
        RaiseMoneyBottomSheet(request: sheetRequest, completer: completer)
  };

  bottomSheetService.setCustomSheetBuilders(builders);
}

class RaiseMoneyBottomSheet extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;

  const RaiseMoneyBottomSheet({
    Key key,
    this.request,
    this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 40,
            child: Divider(
              thickness: 4,
              color: Colors.grey[400],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  request.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[900],
                  ),
                ),
                SizedBox(height: 25),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      onPressed: () =>
                          completer(SheetResponse(responseData: "Test 1")),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Icon(Icons.qr_code_scanner_rounded),
                        ),
                        title: Text(
                          "Scan user QR code",
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        subtitle:
                            Text("scan code to retrieve user information"),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () =>
                          completer(SheetResponse(responseData: "Test 2")),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Icon(Icons.person_search_rounded),
                        ),
                        title: Text(
                          "Search user by name",
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
