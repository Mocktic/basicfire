import 'package:contact/Config/Theme/theme.dart';
import 'package:contact/Provider/EmailProvider.dart';
import 'package:contact/Provider/LanguageProvider.dart';
import 'package:contact/Provider/UserProvider.dart';
import 'package:contact/Provider/agentProvider.dart';
import 'package:contact/Provider/contactProvider.dart';
import 'package:contact/Provider/kanbanBoardProvider.dart';
import 'package:contact/authentication/SignUp/SignUp3.dart';
import 'package:contact/authentication/SignUp/SignUpEmail.dart';
import 'package:contact/authentication/SignUp/SignUpName.dart';
import 'package:contact/authentication/login/Otp_verification_Screen.dart';
import 'package:contact/authentication/login/loginEmail.dart';
import 'package:contact/authentication/login/loginHomeScreen.dart';
import 'package:contact/authentication/login/loginPhoneScreen.dart';
import 'package:contact/languages/MultipleLanguage/AppLocalizations.dart';
import 'package:contact/learning%20file.dart';
import 'package:contact/screens/splash_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sizer/sizer.dart' as sizer;
import 'package:flutter_localizations/flutter_localizations.dart';

import 'Provider/providerSchedule.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  theme.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppThemeData(),
        ),
        ChangeNotifierProvider(
          create: (_) => EmailProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AppLanguage(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ScheduleProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AgentProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => KanbanBoardProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ContactProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

AppThemeData theme = AppThemeData();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return sizer.Sizer(builder: (context, orientation, deviceType) {
      return ChangeNotifierProvider(
        create: (_) => AppThemeData(),
        child: Consumer2<AppThemeData, AppLanguage>(
            builder: (context, value, appLang, child) {
          // ignore: unused_local_variable
          var _theme = ThemeData(
            fontFamily: 'Raleway',
            primarySwatch: theme.primarySwatch,
          );

          if (theme.darkMode) {
            _theme = ThemeData(
              fontFamily: 'Raleway',
              brightness: Brightness.dark,
              unselectedWidgetColor: Colors.white,
              primarySwatch: theme.primarySwatch,
            );
          }
          // if (theme.darkMode) {
          //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          //     systemNavigationBarColor: Colors.black, // navigation bar color
          //     statusBarColor: Colors.black, // status bar color
          //   ));
          // } else {
          //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          //     systemNavigationBarColor: Colors.white, // navigation bar color
          //     statusBarColor: Colors.white, // status bar color
          //   ));
          // }
          return CupertinoApp(
            supportedLocales: [
              Locale('en', 'US'),
              Locale('hi', ''),
            ],
            locale: appLang.appLocal,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            debugShowCheckedModeBanner: false,
            title: 'Customer App',
            home: SplashScreen(),
          );
        }),
      );
    });
  }
}
// https://medium.com/flutter/beautiful-animated-charts-for-flutter-164940780b8c