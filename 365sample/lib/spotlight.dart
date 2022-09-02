import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_unicons/flutter_unicons.dart';
import 'package:promises_of_god/Module/global_settings.dart';
import 'package:promises_of_god/Module/drawer_header.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:promises_of_god/sharedpreferences.dart';
import 'package:promises_of_god/widget/custom_home.dart';
import 'package:promises_of_god/widget/saved_words.dart';
import 'package:promises_of_god/widget/textbutton_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:like_button/like_button.dart';

import 'Module/months_details_page.dart';
import 'custom_page_route.dart';

late SharedPreferences preferences;

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MyApp());
}

var scaffoldKey = GlobalKey<ScaffoldState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SpotLight(),
    );
  }
}

class SpotLight extends StatefulWidget {
  //Saved Promises
  static final _savedPromises = SavedPromises.savedPromises;

  @override
  _SpotLightState createState() => _SpotLightState();
}

class _SpotLightState extends State<SpotLight> {
  //For Like Button
  bool checkLike = false;
  int countNum = 0;

  final month = DateTime.now().month;

  BannerAd? bannerAd;
  bool isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId:
          "ca-app-pub-3940256099942544/6300978111", //ca-app-pub-9924483658315994/5579361324, //ca-app-pub-3940256099942544/6300978111
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            isLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
      ),
      request: AdRequest(),
    );
    bannerAd!.load();
  }

  //Theme Appearance
  //Shared Preferences - Theme Appearance
  Future getColor() async {
    preferences = await SharedPreferences.getInstance();
    int? index = preferences.getInt('color');
    globalAppColor = getColorIndex(index!); //was primaryColor before
    print('color taken from saved instance');
    setState(() {});
  }

  //Saved Promises
  // var _savedPromises = SpotLight._savedPromises;
  // bool alreadySaved = false;

  //deciding the month to list
  String value = "";
  String value2 = "";
  String value3 = "";

  //365 Promises of God Months List
  List TodayList = [
    if (DateTime.now().month == 1)
      {
        'month': "January",
        'monthtagline': "Assurance",
        'pictureUrl': "lib/assets/assurance.jpg",
        'value': "$promises/todayspromise.php",
      }
    else if (DateTime.now().month == 2)
      {
        'month': "February",
        'monthtagline': "Supply",
        'pictureUrl': "lib/assets/February-supply.jpg",
        'value': "$promises/todayspromise.php",
      }
    else if (DateTime.now().month == 3)
      {
        'month': "March",
        'monthtagline': "Victory & Dominion",
        'pictureUrl': "lib/assets/victory-dominion.jpg",
        'value': "$promises/todayspromise.php",
      }
    else if (DateTime.now().month == 4)
      {
        'month': "April",
        'monthtagline': "Deliverance",
        'pictureUrl': "lib/assets/deliverance.jpg",
        'value': "$promises/todayspromise.php",
      }
    else if (DateTime.now().month == 5)
      {
        'month': "May",
        'monthtagline': "Consecration",
        'pictureUrl': "lib/assets/consecration.jpg",
        'value': "$promises/todayspromise.php",
      }
    else if (DateTime.now().month == 6)
      {
        'month': "June",
        'monthtagline': "Healing & Recovery",
        'pictureUrl': "lib/assets/healing-recovery.jpg",
        'value': "$promises/todayspromise.php",
      }
    else if (DateTime.now().month == 7)
      {
        'month': "July",
        'monthtagline': "Mercy & Grace",
        'pictureUrl': "lib/assets/mercy-grace.jpg",
        'value': "$promises/todayspromise.php",
      }
    else if (DateTime.now().month == 8)
      {
        'month': "August",
        'monthtagline': "Peace & Joy",
        'pictureUrl': "lib/assets/peace-joy (2).jpg",
        'value': "$promises/todayspromise.php",
      }
    else if (DateTime.now().month == 9)
      {
        'month': "September",
        'monthtagline': "Protection",
        'pictureUrl': "lib/assets/protection.jpg",
        'value': "$promises/todayspromise.php",
      }
    else if (DateTime.now().month == 10)
      {
        'month': "October",
        'monthtagline': "Remembrance",
        'pictureUrl': "lib/assets/remembrance.jpg",
        'value': "$promises/todayspromise.php",
      }
    else if (DateTime.now().month == 11)
      {
        'month': "November",
        'monthtagline': "Growth & Maturity",
        'pictureUrl': "lib/assets/growth-maturity.jpg",
        'value': "$promises/todayspromise.php",
      }
    else
      {
        'month': "December",
        'monthtagline': "Thanksgiving",
        'pictureUrl': "lib/assets/thanksgiving.jpg",
        'value': "$promises/todayspromise.php",
      }
  ];

  // PRESS BACK BUTTON AGAIN TO EXIT
  DateTime timeBackPressed = DateTime.now();

  //var currentPage = DrawerSections.home;

  //int activeIndex = 0;
  //TTS Here
  bool isSpeaking = false;
  final _flutterTts = FlutterTts();

  void initializeTts() {
    _flutterTts.setStartHandler(() {
      setState(() {
        isSpeaking = true;
      });
    });

    _flutterTts.setCompletionHandler(() {
      setState(() {
        isSpeaking = false;
      });
    });

    _flutterTts.setErrorHandler((message) {
      setState(() {
        isSpeaking = false;
      });
    });
  }

  void speak(myVal) async {
    if (myVal.isNotEmpty) {
      await _flutterTts
          .setVoice({"name": "en-au-x-afh-network", "locale": "en-AU"});
      await _flutterTts.setSpeechRate(0.4);
      await _flutterTts.setPitch(0.8);
      await _flutterTts.speak(myVal);
    }
  }

  void stop() async {
    await _flutterTts.stop();
    setState(() {
      isSpeaking = false;
    });
  }

  @override
  void dispose() {
    _flutterTts.stop();

    super.dispose();
  }

  //Fetch Today's Promise from database
  bool isLoading = false;
  late String today = "$promises/todayspromise.php";

  List todaysPromise = [];

  getPromise() async {
    var response = await http.get(Uri.parse(today));
    if (response.statusCode == 200) {
      setState(() {
        todaysPromise = json.decode(response.body);
      });
    }
    //print(todaysPromise);
    return todaysPromise;
  }

  @override
  void initState() {
    super.initState();

    getPromise();
    initializeTts();
    getColor();
    countNum = UserClickCount.getNumber() ?? 0;
    checkLike = UserClickCount.getColorState() ?? false;

    // String monthName;
    // String monthTagline;
    // monthName = getMonth();
    // monthTagline = getMonth();
  }

  //saved promises
  // void _openSavedWords() {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (BuildContext context) {
  //         return Scaffold(
  //           backgroundColor: Colors.white,
  //           appBar: AppBar(
  //             leading: IconButton(
  //               icon: Unicon(
  //                 Unicons.uniArrowLeft,
  //                 size: leadingIcons,
  //                 color: globalDefault,
  //               ),
  //               onPressed: () {
  //                 Navigator.of(context).pushReplacement(CustomPageRoute(
  //                   child: BTNav(newIndex: 1),
  //                   direction: AxisDirection.left,
  //                 ));
  //               },
  //             ),
  //             backgroundColor: Colors.white,
  //             title: Text(
  //               'Saved Promises',
  //               style: TextStyle(
  //                 color: globalDefault,
  //                 fontSize: globalHeading,
  //               ),
  //             ),
  //             elevation: 1.0,
  //           ),
  //           body: Center(
  //             child: _savedPromises.length != 0
  //                 ? ListView(
  //                     padding: EdgeInsets.all(5.0),
  //                     //controller: promiseController,
  //                     //reverse: true,
  //                     children: _savedPromises
  //                         .map(
  //                           (myPromise) => Row(
  //                             mainAxisAlignment: MainAxisAlignment.start,
  //                             crossAxisAlignment: CrossAxisAlignment.center,
  //                             children: [
  //                               Expanded(
  //                                 flex: 8,
  //                                 child: Container(
  //                                   padding: EdgeInsets.all(15.0),
  //                                   decoration: BoxDecoration(
  //                                     border: Border(
  //                                       bottom: BorderSide(
  //                                           width: 1.0,
  //                                           color: inputIcon,
  //                                           style: BorderStyle.solid),
  //                                     ),
  //                                   ),
  //                                   child: Column(
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                     children: [
  //                                       Text(
  //                                         getMonth(),
  //                                         //todaysPromise[index]['Passage'],
  //                                         style: TextStyle(
  //                                           fontSize: littleTexts,
  //                                           color: iconInBar,
  //                                           fontWeight: FontWeight.w400,
  //                                         ),
  //                                       ),
  //                                       SizedBox(height: 8.0),
  //                                       Builder(
  //                                         builder: (BuildContext context) {
  //                                           return Container(
  //                                             padding: EdgeInsets.fromLTRB(
  //                                                 10.0, 2.0, 10.0, 2.0),
  //                                             decoration: BoxDecoration(
  //                                               color: globalAppColor,
  //                                               borderRadius:
  //                                                   BorderRadius.circular(50.0),
  //                                             ),
  //                                             child: Text(
  //                                               'sample',
  //                                               style: TextStyle(
  //                                                 color: Colors.white,
  //                                                 fontSize: littleTexts,
  //                                               ),
  //                                             ),
  //                                           );
  //                                         },
  //                                       ),
  //                                       SizedBox(height: 15.0),
  //                                       Text(
  //                                         myPromise,
  //                                         style: TextStyle(
  //                                           fontSize: globalTagline,
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ),
  //                               SizedBox(width: 5.0),
  //                               Expanded(
  //                                 flex: 2,
  //                                 child: IconButton(
  //                                   onPressed: () {
  //                                     setState(() {
  //                                       _savedPromises.remove(myPromise);
  //                                       return _openSavedWords();
  //                                     });
  //                                   },
  //                                   icon: Unicon(
  //                                     Unicons.uniTrash,
  //                                     size: icon3Size,
  //                                     color: globalDefault,
  //                                   ),
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         )
  //                         .toList(),
  //                   )
  //                 : Column(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     children: [
  //                       Container(
  //                         height: 80.0,
  //                         width: 80.0,
  //                         padding: EdgeInsets.all(10.0),
  //                         decoration: BoxDecoration(
  //                           image: DecorationImage(
  //                             image: AssetImage('lib/assets/heart.png'),
  //                             fit: BoxFit.cover,
  //                           ),
  //                         ),
  //                       ),
  //                       SizedBox(height: 20.0),
  //                       Text(
  //                         'No saved promises',
  //                         style: TextStyle(
  //                           color: globalInfoColor,
  //                           fontSize: BtnFnt1,
  //                         ),
  //                         textAlign: TextAlign.center,
  //                       ),
  //                     ],
  //                   ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme: _switch ? _dark : _light,
      home: WillPopScope(
        onWillPop: () async {
          final difference = DateTime.now().difference(timeBackPressed);
          final isExitWarning = difference >= Duration(seconds: 2);

          timeBackPressed = DateTime.now();
          if (isExitWarning) {
            //toast message
            final message = 'Tap back again to exit';
            Fluttertoast.showToast(
                msg: message,
                fontSize: littleTexts,
                backgroundColor: globalDefault,
                textColor: iconTip,
                toastLength: Toast.LENGTH_LONG);
            return false;
          } else {
            Fluttertoast.cancel();
            return true;
          }
        },
        child: Scaffold(
          backgroundColor: Colors.grey[150],
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(
              '365 Promises of God',
              style: TextStyle(
                color: globalDefault,
                fontWeight: FontWeight.w500,
              ),
            ),
            leading: IconButton(
              icon: Unicon(
                Unicons.uniListUl,
                size: leadingIcons,
                color: globalDefault,
              ),
              onPressed: () {
                scaffoldKey.currentState!.openDrawer();
              },
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10.0),
                Container(
                  margin: EdgeInsets.only(left: 20.0, top: 8.0),
                  child: Row(
                    children: [
                      Unicon(
                        Unicons.uniSun,
                        size: iconTipSize,
                        color: globalAppColor,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        "Today's Promise",
                        style: TextStyle(
                          color: globalDefault,
                          fontSize: globalHeading,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 30.0, top: 8.0),
                  height: 18.0,
                  //width: double.infinity,
                  child: PageView.builder(
                      itemCount: todaysPromise.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Row(
                            children: [
                              Text(
                                getMonth(),
                                //todaysPromise[index]['Passage'],
                                style: TextStyle(
                                  fontSize: globalTagline,
                                  color: iconInBar,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                todaysPromise[index]['Day'],
                                style: TextStyle(
                                  fontSize: globalTagline,
                                  color: iconInBar,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
                Container(
                  height: 300.0,
                  width: double.infinity,
                  child: PageView.builder(
                      itemCount: todaysPromise.length,
                      itemBuilder: (context, index) {
                        final myVal = todaysPromise[index]['Promise'] +
                            "." +
                            todaysPromise[index]['Passage'];
                        //final dPromise = todaysPromise[index]['Day'];
                        return Container(
                          margin: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 5.0),
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding:
                                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                //alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: globalAppColor,
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                child: Text(
                                  todaysPromise[index]['Passage'],
                                  style: TextStyle(
                                    fontSize: globalHeading,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(height: 15.0),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      todaysPromise[index]['Promise'],
                                      style: TextStyle(
                                        fontSize: BtnFnt1,
                                        color: globalDefault,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    TextButton(
                                      child: Text(
                                        'See more',
                                        style: TextStyle(
                                          color: globalAppColor,
                                          fontSize: BtnFnt2,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      onPressed: () {
                                        value = TodayList[index]['value'];
                                        value2 =
                                            TodayList[index]['monthtagline'];
                                        value3 = TodayList[index]['pictureUrl'];

                                        Navigator.of(context)
                                            .push(CustomPageRoute(
                                          child: CurrentMonth(
                                              value: value,
                                              value2: value2,
                                              value3: value3),
                                          direction: AxisDirection.right,
                                        ));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Divider(color: globalAppColor),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  likeButtonWid(),
                                  // buildRow(todaysPromise[index]['Promise'] +
                                  //     " -- " +
                                  //     todaysPromise[index]['Passage']),
                                  Container(
                                    child: Row(
                                      children: [
                                        OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            side: BorderSide(
                                                width: 1,
                                                color: iconTip,
                                                style: BorderStyle.solid),
                                          ),
                                          child: Unicon(
                                            Unicons.uniShare,
                                            size: leadingIcons,
                                            color: globalDefault,
                                          ),
                                          onPressed: () {
                                            Share.share(todaysPromise[index]
                                                    ['Promise'] +
                                                " " +
                                                todaysPromise[index]
                                                    ['Passage']);
                                          },
                                        ),
                                        SizedBox(width: 5.0),
                                        OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            side: BorderSide(
                                                width: 1,
                                                color: iconTip,
                                                style: BorderStyle.solid),
                                          ),
                                          onPressed: () {
                                            isSpeaking ? stop() : speak(myVal);
                                          },
                                          child: isSpeaking
                                              ? Unicon(
                                                  Unicons.uniVolumeUp,
                                                  size: leadingIcons,
                                                  color: globalAppColor,
                                                )
                                              : Unicon(
                                                  Unicons.uniVolumeOff,
                                                  size: leadingIcons,
                                                  color: globalDefault,
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                ),
                SizedBox(height: 5.0),
                isLoaded
                    ? Container(
                        height: 80,
                        child: AdWidget(
                          ad: bannerAd!,
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          drawer: Drawer(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  drawerHeader(),
                  SizedBox(height: 20.0),
                  buildMenuItem(
                    text: 'Favorites',
                    unicon: Unicons.uniHeart,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  //SizedBox(height: 15.0),
                  buildMenuItem(
                    text: 'My Notes',
                    unicon: Unicons.uniNotes,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  //SizedBox(height: 15.0),
                  buildMenuItem(
                    text: 'Appearance',
                    unicon: Unicons.uniPalette,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  Divider(color: globalInfoColor),
                  //SizedBox(height: 25.0),
                  buildMenuItem(
                    text: 'About',
                    unicon: Unicons.uniInfoCircle,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  //SizedBox(height: 15.0),
                  buildMenuItem(
                    text: 'Feedback',
                    unicon: Unicons.uniFeedback,
                    onClicked: () => selectedItem(context, 4),
                  ),
                  //SizedBox(height: 15.0),
                  // buildMenuItem(
                  //   text: 'Share App',
                  //   unicon: Unicons.uniShare,
                  //   onClicked: () => selectedItem(context, 5),
                  // ),
                ],
              ),
            ),
            // child: SingleChildScrollView(
            //   child: Container(
            //     child: Column(
            //       children: [
            //         drawerHeader(),
            //         drawerList(),
            //       ],
            //     ),
            //   ),
            // ),
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required UniconData unicon,
    VoidCallback? onClicked,
  }) {
    //final color = globalDefault;
    return Material(
      child: InkWell(
        onTap: onClicked,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Unicon(
                  unicon,
                  animationDuration: Duration(milliseconds: 300),
                  animationCurve: Curves.fastOutSlowIn,
                  mainAxisAlignment: MainAxisAlignment.start,
                  size: leadingIcons,
                  color: globalDefault,
                  fit: BoxFit.contain,
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: BtnFnt1,
                    color: globalDefault,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // leading: Unicon(
      //   unicon,
      //   animationDuration: Duration(milliseconds: 300),
      //   animationCurve: Curves.fastOutSlowIn,
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   size: leadingIcons,
      //   color: globalDefault,
      //   fit: BoxFit.contain,
      // ),
      // title: Text(
      //   text,
      //   style: TextStyle(
      //     fontSize: BtnFnt1,
      //     color: globalDefault,
      //     fontWeight: FontWeight.w400,
      //   ),
      // ),
      // onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        //return OpenSavedWords();
        Navigator.pushNamed(context, '/open_saved');
        break;
      case 1:
        Navigator.pushNamed(context, '/note_list');
        break;
      case 2:
        Navigator.pushNamed(context, '/theme_mode');
        break;
      case 3:
        Navigator.pushNamed(context, '/about_365');
        break;
      case 4:
        Navigator.pushNamed(context, '/rating');
        break;
      // case 5:
      //   setState(() {
      //     Navigator.pushNamed(context, '/share_app');
      //   });
      // Share.share(
      //     'Check out 365 Promises of God for all year round NIV Bible promises');
      // break;
    }
  }

  Widget likeButtonWid() {
    final double buttonSize = leadingIcons;

    return LikeButton(
      likeCountPadding: EdgeInsets.only(left: 15.0),
      size: buttonSize,
      circleColor:
          CircleColor(start: Color(0XFF6E5AE2), end: Color(0XFFF0AC20)),
      bubblesColor: BubblesColor(
        dotPrimaryColor: globalAppColor,
        dotSecondaryColor: Color(0XFFF0AC20),
      ),
      isLiked: checkLike,
      likeBuilder: (isLiked) {
        final color = checkLike ? globalAppColor : globalDefault;
        return Unicon(
          Unicons.uniThumbsUp,
          //isLiked ? Unicons.uniHeart : Unicons.uniHeartAlt,
          color: color,
          size: buttonSize,
        );
      },
      likeCount: countNum,
      countBuilder: (countNum, checkLike, text) {
        final color = checkLike ? globalAppColor : globalDefault;

        return Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: inputIconSize,
          ),
        );
      },
      onTap: (isLiked) async {
        this.checkLike = !isLiked;
        countNum += this.checkLike ? 1 : -1;
        await UserClickCount.setNumber(countNum);
        await UserClickCount.setColorState(checkLike);

        return !isLiked;
        // return !isLiked;
      },
    );
  }

  String getMonth() {
    String monthName = "";
    String monthTagline = "";
    switch (month) {
      case 1:
        {
          monthName = "January";
          monthTagline = "Assurance";
          break;
        }
      case 2:
        {
          monthName = "February";
          monthTagline = "Supply";
          break;
        }
      case 3:
        {
          monthName = "March";
          monthTagline = "Victory & Dominion";
          break;
        }
      case 4:
        {
          monthName = "April";
          monthTagline = "Deliverance";
          break;
        }
      case 5:
        {
          monthName = "May";
          monthTagline = "Consecration";
          break;
        }
      case 6:
        {
          monthName = "June";
          monthTagline = "Healing & Recovery";
          break;
        }
      case 7:
        {
          monthName = "July";
          monthTagline = "Mercy & Grace";
          break;
        }
      case 8:
        {
          monthName = "August";
          monthTagline = "Peace & Joy";
          break;
        }
      case 9:
        {
          monthName = "September";
          monthTagline = "Protection";
          break;
        }
      case 10:
        {
          monthName = "October";
          monthTagline = "Remembrance";
          break;
        }
      case 11:
        {
          monthName = "November";
          monthTagline = "Growth & Maturity";
          break;
        }
      case 12:
        {
          monthName = "December";
          monthTagline = "Thanksgiving";
          break;
        }
    }
    return monthTagline + " - " + monthName;
  }
} // Stateful widget close here

//Theme Appearance Stateful Widget
class ThemeAppearance extends StatefulWidget {
  @override
  _ThemeAppearanceState createState() => _ThemeAppearanceState();
}

class _ThemeAppearanceState extends State<ThemeAppearance> {
  bool isClicked = false;

  BannerAd? bannerAd;
  bool isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    bannerAd = BannerAd(
      size: AdSize.largeBanner,
      adUnitId:
          "ca-app-pub-3940256099942544/6300978111", //ca-app-pub-9924483658315994/4845698301
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            isLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          print("Ad failed to load");
        },
      ),
      request: AdRequest(),
    );
    bannerAd!.load();
  }

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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1.0,
          title: Text(
            'Change Appearance',
            style: TextStyle(
              color: globalDefault,
              fontSize: globalHeading,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(CustomPageRoute(
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
        body: Padding(
          padding: EdgeInsets.only(bottom: 15.0),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 80.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          globalAppColor.withOpacity(0.2), BlendMode.darken),
                      image: AssetImage('lib/assets/consecration.jpg'),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50.0),
                      bottomRight: Radius.circular(50.0),
                    ),
                  ),
                  child: isClicked
                      ? Text(
                          'Change Appearance',
                        )
                      : Text(
                          'Theme appearance updated!',
                          style: TextStyle(
                            color: globalAppColor,
                            fontSize: globalHeading,
                          ),
                        ),
                  alignment: Alignment.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButtonWidget(
                              onClicked: () {
                                globalAppColor = Colors.red;
                                setColor(1);
                                setState(() {});
                              },
                              text: 'Deep Red',
                              color1: Colors.red,
                              color2: Colors.white,
                            ),
                            TextButtonWidget(
                              onClicked: () {
                                globalAppColor = Colors.blue;
                                setColor(2);
                                setState(() {});
                              },
                              text: 'Light Blue',
                              color1: Colors.blue,
                              color2: Colors.white,
                            ),
                            TextButtonWidget(
                              onClicked: () {
                                globalAppColor = Colors.blueGrey;
                                setColor(3);
                                setState(() {});
                              },
                              text: 'Blue Grey',
                              color1: Colors.blueGrey,
                              color2: Colors.white,
                            ),
                            TextButtonWidget(
                              onClicked: () {
                                globalAppColor = Colors.pink;
                                setColor(4);
                                setState(() {});
                              },
                              text: 'Hot Pink',
                              color1: Colors.pink,
                              color2: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButtonWidget(
                              onClicked: () {
                                globalAppColor = Colors.green;
                                setColor(5);
                                setState(() {});
                              },
                              text: 'Light Green',
                              color1: Colors.green,
                              color2: Colors.white,
                            ),
                            TextButtonWidget(
                              onClicked: () {
                                globalAppColor = Colors.deepPurple;
                                setColor(6);
                                setState(() {});
                              },
                              text: 'Deep Purple',
                              color1: Colors.deepPurple,
                              color2: Colors.white,
                            ),
                            TextButtonWidget(
                              onClicked: () {
                                globalAppColor = Colors.purpleAccent;
                                setColor(7);
                                setState(() {});
                              },
                              text: 'Light Purple',
                              color1: Colors.purpleAccent,
                              color2: Colors.white,
                            ),
                            TextButtonWidget(
                              onClicked: () {
                                globalAppColor = Colors.deepOrangeAccent;
                                setColor(8);
                                setState(() {});
                              },
                              text: 'Deep Orange',
                              color1: Colors.deepOrangeAccent,
                              color2: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.0),
                TextButtonWidget(
                  onClicked: () {
                    globalAppColor = Colors.amberAccent;
                    setColor(8);
                    setState(() {});
                  },
                  text: 'Revert to Default',
                  color1: Colors.transparent,
                  color2: Colors.amberAccent,
                ),
                SizedBox(height: 10.0),
                isLoaded
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Container(
                            height: 100,
                            child: AdWidget(
                              ad: bannerAd!,
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Drawer Sections
// enum DrawerSections {
//   home,
//   favorites,
//   notes,
//   appearance,
//   about,
//   feedback,
//   share_app
// }
