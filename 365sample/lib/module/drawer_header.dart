import 'package:flutter/material.dart';
import 'package:flutter_unicons/flutter_unicons.dart';
import 'package:promises_of_god/Module/global_settings.dart';
//import 'package:promises_of_god/Module/theme_mode.dart';

class drawerHeader extends StatefulWidget {
  @override
  _drawerHeaderState createState() => _drawerHeaderState();
}

class _drawerHeaderState extends State<drawerHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50.0, left: 20.0, bottom: 20.0),
      color: Colors.white,
      //width: double.infinity,
      height: 230.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Unicon(
            Unicons.uniBookOpen,
            animationDuration: Duration(milliseconds: 300),
            animationCurve: Curves.fastOutSlowIn,
            mainAxisAlignment: MainAxisAlignment.start,
            size: icon1Size, //or iconTipSize
            color: globalAppColor,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 10.0),
          Text(
            '365 Promises of God',
            style: TextStyle(
              fontSize: icon3Size,
              color: globalAppColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
