import 'package:flutter/material.dart';
//import 'dart:async';

import 'package:promises_of_god/Module/home_screen.dart';
import 'package:promises_of_god/sharedpreferences.dart';
import 'package:promises_of_god/splash_screen.dart';
import 'package:promises_of_god/spotlight.dart';
import 'package:promises_of_god/widget/custom_home.dart';
import 'package:provider/provider.dart';

import 'Module/about_365.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  await UserClickCount.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = '365 Promises';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/custom_home': (context) => BTNav(newIndex: 0),
          '/home_screen': (context) => HomeScreen(),
          '/about_365': (context) => About(),
        },
      ),
      //providers: [ChangeNotifierProvider(create: (_) => NotificationApi())],
    );
  }
}
