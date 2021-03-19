import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeBottomSheetView extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;

  const HomeBottomSheetView({
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
                          "Accept payments",
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        subtitle: Text("Create personal payment link"),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () =>
                          completer(SheetResponse(responseData: "Test 2")),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Icon(Icons.people),
                        ),
                        title: Text(
                          "Create money pool",
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () =>
                          completer(SheetResponse(responseData: "Test 3")),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Icon(Icons.apps),
                        ),
                        title: Text(
                          "Checkout our good apps",
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
