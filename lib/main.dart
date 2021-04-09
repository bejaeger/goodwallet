import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/setup_bottom_sheet_ui.dart';
import 'package:good_wallet/ui/views/layout/layout_template_view.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:good_wallet/utils/unfocuser.dart';
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart';
import 'app/app.router.dart' as auto_router;
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  setupBottomSheetUi();
  Logger.level = Level.info;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final log = getLogger("main.dart");
  @override
  Widget build(BuildContext context) {
    log.i("Building MaterialApp...");
    return Unfocuser(
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'The Good Dollars Marketplace',
          navigatorKey: StackedService.navigatorKey,
          onGenerateRoute: StackedRouter().onGenerateRoute,
          theme: MyThemeData.myTheme(),
          initialRoute: kIsWeb
              ? auto_router.Routes.welcomeView
              //: auto_router.Routes.layoutTemplateViewMobile,
              : auto_router.Routes.loginView,
          builder: (context, child) =>
              isDesktop(context) ? LayoutTemplate(childView: child) : child!),
    );
  }
}

class MyThemeData {
  static ThemeData myTheme() {
    return ThemeData(
      // TODO: Import google font
      fontFamily: 'Roboto',
      // colors form here https://material.io/resources/color/#!/?view.left=0&view.right=1&primary.color=941305
      primaryColor: Color(0xFF941305),
      primaryColorLight: Color(0xFFcc492f), // light red
      primaryColorDark: Color(0xFF600000), // dark red
      backgroundColor: Colors.grey[50],
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        primary: Color(0xFFcc492f), // primary red
      )),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          //textStyle: TextStyle(fontSize: 15, color: MyColors.darkTurquoise),
          primary: Color(0xFF600000), // dark red
        ),
      ),
      tabBarTheme: TabBarTheme(
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: MyColors.lightRed, width: 5.0),
        ),
      ),
      iconTheme: IconThemeData(
        color: Color(0xFFcc492f),
      ),
      //primaryColorBrightness: Brightness.light,
      //textTheme: Typography.whiteMountainView,
      textTheme: TextTheme(
        // headlines for sections
        headline1: TextStyle(
            fontSize: 35, color: Colors.grey[200], fontWeight: FontWeight.w800),
        headline2: TextStyle(
            fontSize: 35,
            color: ColorSettings.blackHeadlineColor,
            fontWeight: FontWeight.w800),

        // sub headlines for sections?

        headline3: TextStyle(
            fontSize: 30, color: Colors.grey[200], fontWeight: FontWeight.w600),
        headline4: TextStyle(
            fontSize: 30,
            color: ColorSettings.blackHeadlineColor,
            fontWeight: FontWeight.w600),

        // sub headlines for sections?
        headline5: TextStyle(
            fontSize: 20, color: Colors.grey[200], fontWeight: FontWeight.w600),
        headline6: TextStyle(
            fontSize: 20,
            color: ColorSettings.greyTextColor,
            fontWeight: FontWeight.w600),

        bodyText1: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.grey[200],
            height: 1.5),
        bodyText2: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: ColorSettings.lightGreyTextColor,
            height: 1.5),
      ),
    );
  }
}
