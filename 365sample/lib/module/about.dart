import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unicons/flutter_unicons.dart';
import 'package:promises_of_god/custom_page_route.dart';
import 'package:promises_of_god/widget/custom_home.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../spotlight.dart';
import 'global_settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: About(),
    );
  }
}

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).push(CustomPageRoute(
          child: BTNav(newIndex: 0),
          direction: AxisDirection.left,
        ));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 1.0,
          backgroundColor: Colors.white,
          title: Text(
            'About 365',
            style: TextStyle(
              color: globalDefault,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(CustomPageRoute(
                child: BTNav(newIndex: 0),
                direction: AxisDirection.left,
              ));
            },
            icon: Unicon(
              Unicons.uniArrowLeft,
              size: leadingIcons,
              color: globalDefault,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40.0),
                  height: 100.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: AssetImage('lib/assets/aboutus.jpg'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Container(
                  child: Text(
                    'V.1.1.0',
                    style: TextStyle(
                      color: globalDefault,
                      fontSize: globalHeading,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(40.0, 25.0, 40.0, 5.0),
                  child: Text(
                    '365 promises of God is a product of moment with God. The App is designed for your all year round promises of joy and upliftment',
                    style: TextStyle(
                      color: globalDefault,
                      fontSize: BtnFnt1,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Divider(),
                TextButton(
                  onPressed: () {
                    urlLink1("https://momentwithgod.info", false);
                  },
                  child: Text(
                    'Visit MomentwithGod Website',
                    style: TextStyle(
                      color: globalDefault,
                      fontSize: globalTagline,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    urlLink2("#com.momentwithgod.info/google_playstore", false);
                  },
                  child: Text(
                    'Download MWG App',
                    style: TextStyle(
                      color: globalDefault,
                      fontSize: globalTagline,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Share With Friends',
                        style: TextStyle(
                          color: globalDefault,
                          fontSize: globalTagline,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 5.0),
                      // Clickable social media icons
                      IconButton(
                        onPressed: () {
                          Share.share(
                              'Check out 365 Promises of God for all year round NIV Bible promises');
                        },
                        icon: Icon(
                          Icons.share_outlined,
                          size: 20.0,
                          color: globalDefault,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Link 1
  Future urlLink1(String url1, bool inApp) async {
    if (await canLaunch(url1)) {
      await launch(
        url1,
        forceSafariVC: inApp,
        forceWebView: inApp,
        enableJavaScript: true,
      );
    }
  }

  //Link 2
  Future urlLink2(String url2, bool inApp) async {
    if (await canLaunch(url2)) {
      await launch(
        url2,
        forceSafariVC: inApp,
        forceWebView: inApp,
        enableJavaScript: true,
      );
    }
  }
}
