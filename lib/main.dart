import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Good Dollars Marketplace',
      //navigatorKey: locator<DialogService>().navigatorKey,
      //onGenerateRoute: auto_router.Router().onGenerateRoute,
      //initialRoute: Routes.startUpView,
      theme: ThemeData(
        primaryColor: Colors.blue,
        backgroundColor: Colors.white70,
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Open Sans',
            ),
      ),
      //home: WebTestView(),
      //builder: (context, child) => child,
      home: Container(
        width: 1000,
        child: Column(
          children: [
            Text("Hello There!"),
          ],
        ),
      ),
    );
  }
}
