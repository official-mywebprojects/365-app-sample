import 'dart:async';
import 'package:flutter/material.dart';
import 'package:promises_of_god/widget/custom_home.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'custom_page_route.dart';
//import 'main.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 10), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomeScreen())
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    print(Offset(0.0, -1.0).distanceSquared - Offset(0.0, 0.0).distanceSquared);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 160.0,
              width: 160.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                image: DecorationImage(
                  image: AssetImage('lib/assets/aboutus.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 5.0),
          ],
        ),
      ),
    );
  }
}
