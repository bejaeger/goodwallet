import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:good_wallet/app/locator.dart';
import 'package:good_wallet/views/layout/layout_template_view.dart';
import 'package:good_wallet/views/send_money_view.dart';
import 'package:good_wallet/views/wallet_view.dart';
import 'package:stacked_services/stacked_services.dart';
import 'app/router.gr.dart' as auto_router;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("INFO: Building MaterialApp...");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Good Dollars Marketplace',
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: auto_router.Router().onGenerateRoute,
      theme: ThemeData(
        primaryColor: Colors.blue,
        backgroundColor: Colors.white70,
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Open Sans',
            ),
      ),
      initialRoute: auto_router.Routes.walletView,
      builder: (context, child) => LayoutTemplate(childView: child),
    );
  }
}
