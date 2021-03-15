import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:good_wallet/app/locator.dart';
import 'package:good_wallet/style/colors.dart';
import 'package:good_wallet/ui/shared/setup_bottom_sheet_ui.dart';
import 'package:good_wallet/ui/views/home/home_view_mobile.dart';
import 'package:good_wallet/ui/views/layout/layout_template_view.dart';
import 'package:good_wallet/ui/views/layout/layout_template_view_mobile.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:good_wallet/utils/unfocuser.dart';
import 'package:stacked_services/stacked_services.dart';
import 'app/router.gr.dart' as auto_router;
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  setupBottomSheetUi();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("INFO: Building MaterialApp...");
    return Unfocuser(
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'The Good Dollars Marketplace',
          navigatorKey: locator<NavigationService>().navigatorKey,
          onGenerateRoute: auto_router.Router().onGenerateRoute,
          theme: MyThemeData.myTheme(),
          initialRoute: kIsWeb
              ? auto_router.Routes.welcomeView
              : auto_router.Routes.layoutTemplateViewMobile,
          builder: (context, child) =>
              isDesktop(context) ? LayoutTemplate(childView: child) : child),
    );
  }
}

class MyThemeData {
  static ThemeData myTheme() {
    return ThemeData(
      // TODO: Import google font
      //fontFamily: 'Open-Sans',
      // colors form here https://material.io/resources/color/#!/?view.left=0&view.right=1&primary.color=941305
      primaryColor: Color(0xFF941305),
      primaryColorLight: Color(0xFFcc492f), // light red
      backgroundColor: Colors.grey[50],
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        primary: Color(0xFF941305), // primary red
      )),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          //textStyle: TextStyle(fontSize: 15, color: MyColors.darkTurquoise),
          primary: Color(0xFF600000), // dark red
        ),
      ),
      textTheme: TextTheme(
        // headlines for sections
        headline1: TextStyle(
            fontSize: 35, color: Colors.grey[200], fontWeight: FontWeight.w800),
        headline2: TextStyle(
            fontSize: 35, color: Colors.grey[800], fontWeight: FontWeight.w800),

        // sub headlines for sections?
        headline3: TextStyle(
            fontSize: 30, color: Colors.grey[200], fontWeight: FontWeight.w600),
        headline4: TextStyle(
            fontSize: 30, color: Colors.grey[800], fontWeight: FontWeight.w600),

        bodyText1: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: Colors.grey[200],
            height: 1.5),
        bodyText2: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: Colors.grey[600],
            height: 1.5),
      ),
    );
  }
}
