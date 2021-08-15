import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/setup_bottom_sheet_ui.dart';
import 'package:good_wallet/ui/shared/setup_dialog_ui.dart';
import 'package:good_wallet/ui/shared/setup_snackbar_ui.dart';
import 'package:good_wallet/utils/logger.dart';
import 'package:good_wallet/utils/unfocuser.dart';
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'flavor_config.dart';

const bool USE_EMULATOR = false;

void mainCommon(Flavor flavor) async {
  final log = getLogger("main.dart");
  log.i("Load dot env");
  // await DotEnv.load(fileName: ".env");
  log.i("Loaded dot env");
  //Stripe.publishableKey = DotEnv.env['STRIPE_API_KEY']!;

  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    if (USE_EMULATOR) {
      await _connectToFirebaseEmulator();
    }
    // will remove the leading # in the URL
    setHashUrlStrategy();
    setupLocator();
    setupDialogUi();
    setupBottomSheetUi();
    setupSnackbarUi();
    Logger.level = Level.verbose;

    // configure services that need settings dependent on flavor
    final FlavorConfigProvider flavorConfigProvider =
        locator<FlavorConfigProvider>();
    flavorConfigProvider.configure(flavor);

    runApp(MyApp(appName: flavorConfigProvider.appName));
  } catch (e) {
    print("ERROR: App main function failed with error: ${e.toString()}");
  }
}

Future _connectToFirebaseEmulator() async {
  final localHostString = Platform.isAndroid ? '10.0.2.2' : 'localhost';
  //final localHostString = "192.168.1.69";
  FirebaseFirestore.instance.settings = Settings(
    host: '$localHostString:8080',
    sslEnabled: false,
    persistenceEnabled: false,
  );

  await FirebaseAuth.instance.useEmulator('http://$localHostString:9099');
}

class MyApp extends StatelessWidget {
  final String appName;
  // This widget is the root of your application.
  final log = getLogger("main.dart");
  MyApp({Key? key, required this.appName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    log.i("Building MaterialApp...");
    return Unfocuser(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        // TODO: Get title from flavour
        title: appName,

        navigatorKey: StackedService.navigatorKey,
        onGenerateRoute: StackedRouter().onGenerateRoute,
        theme: MyThemeData.myTheme(),
        //initialRoute: auto_router.Routes.startUpLogicView,
        //kIsWeb
        //? auto_router.Routes.welcomeView
        //: auto_router.Routes.startUpLogicView,
        builder: (context, child) => child!,
      ),
      //    isDesktop(context) ? LayoutTemplate(childView: child) : child!),
    );
  }
}

class MyThemeData {
  static ThemeData myTheme() {
    return ThemeData(
      fontFamily: 'Roboto',
      // colors form here https://material.io/resources/color/#!/?view.left=0&view.right=1&primary.color=941305
      primaryColor: ColorSettings.primaryColor,
      primaryColorLight: ColorSettings.primaryColorLight,
      primaryColorDark: ColorSettings.primaryColorDark,
      backgroundColor: Colors.grey[100],
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
          primary: ColorSettings.blackHeadlineColor, // dark red
        ),
      ),
      tabBarTheme: TabBarTheme(
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: Colors.grey[100]!, width: 3.0),
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
