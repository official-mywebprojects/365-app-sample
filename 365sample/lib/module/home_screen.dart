import 'package:flutter/material.dart';
import 'package:flutter_unicons/flutter_unicons.dart';
import 'package:promises_of_god/Module/global_settings.dart';
import 'package:promises_of_god/Module/custom_365_months_list.dart';
import 'package:promises_of_god/widget/custom_home.dart';

import '../custom_page_route.dart';
//import '../spotlight.dart';
import 'months_details_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //deciding the month to list
  String value = "";
  String value2 = "";
  String value3 = "";

  //365 Promises of God Months List
  List MwgMonths = [
    {
      'month': "January",
      'monthtagline': "Assurance",
      'pictureUrl': "lib/assets/assurance.jpg",
      'value': "$promises/january.php",
    },
    {
      'month': "February",
      'monthtagline': "Supply",
      'pictureUrl': "lib/assets/February-supply.jpg",
      'value': "$promises/february.php",
    },
    {
      'month': "March",
      'monthtagline': "Victory & Dominion",
      'pictureUrl': "lib/assets/victory-dominion.jpg",
      'value': "$promises/march.php",
    },
    {
      'month': "April",
      'monthtagline': "Deliverance",
      'pictureUrl': "lib/assets/deliverance.jpg",
      'value': "$promises/april.php",
    },
    {
      'month': "May",
      'monthtagline': "Consecration",
      'pictureUrl': "lib/assets/consecration.jpg",
      'value': "$promises/may.php",
    },
    {
      'month': "June",
      'monthtagline': "Healing & Recovery",
      'pictureUrl': "lib/assets/healing-recovery.jpg",
      'value': "$promises/june.php",
    },
    {
      'month': "July",
      'monthtagline': "Mercy & Grace",
      'pictureUrl': "lib/assets/mercy-grace.jpg",
      'value': "$promises/july.php",
    },
    {
      'month': "August",
      'monthtagline': "Peace & Joy",
      'pictureUrl': "lib/assets/peace-joy (2).jpg",
      'value': "$promises/august.php",
    },
    {
      'month': "September",
      'monthtagline': "Protection",
      'pictureUrl': "lib/assets/protection.jpg",
      'value': "$promises/september.php",
    },
    {
      'month': "October",
      'monthtagline': "Remembrance",
      'pictureUrl': "lib/assets/remembrance.jpg",
      'value': "$promises/october.php",
    },
    {
      'month': "November",
      'monthtagline': "Growth & Maturity",
      'pictureUrl': "lib/assets/growth-maturity.jpg",
      'value': "$promises/november.php",
    },
    {
      'month': "December",
      'monthtagline': "Thanksgiving",
      'pictureUrl': "lib/assets/thanksgiving.jpg",
      'value': "$promises/december.php",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Unicon(
            Unicons.uniArrowLeft,
            size: leadingIcons,
            color: globalDefault,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(CustomPageRoute(
              child: BTNav(newIndex: 0),
              direction: AxisDirection.left,
            ));
          },
        ),
        title: Text(
          "Browse All Promises",
          style: TextStyle(
            color: globalDefault,
            fontWeight: FontWeight.w500,
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: MwgMonths.length,
                itemBuilder: (context, index) => customMonthLists(
                      onTap: () {
                        value = MwgMonths[index]['value'];
                        value2 = MwgMonths[index]['monthtagline'];
                        value3 = MwgMonths[index]['pictureUrl'];

                        Navigator.of(context).push(CustomPageRoute(
                          child: CurrentMonth(
                              value: value, value2: value2, value3: value3),
                          direction: AxisDirection.right,
                        ));
                      },
                      month: MwgMonths[index]['month'],
                      monthtagline: MwgMonths[index]['monthtagline'],
                      monthimage: MwgMonths[index]['pictureUrl'],
                    )),
          ),
          Container(
              //Ads goes here...
              ),
        ],
      ),
    );
  }
}


 // Home Screen and ** Drawer

// Widget homeScreenDrawer(){
//   return Container(
//     padding: EdgeInsets.all(10.0),
//     child: Drawer(
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//             'About 365',
//           style: TextStyle(
//             fontSize: globalTagline,
//             fontWeight: FontWeight.w400,
//             color: globalDefault,
//           ),
//         ),
//         Text(
//           'Share App',
//           style: TextStyle(
//             fontSize: globalTagline,
//             fontWeight: FontWeight.w400,
//             color: globalDefault,
//           ),
//         ),
//         Text(
//           'Version',
//           style: TextStyle(
//           fontSize: globalTagline,
//           fontWeight: FontWeight.w400,
//           color: globalDefault,
//           ),
//         ),
//         Text(
//           'Feedback',
//           style: TextStyle(
//             fontSize: globalTagline,
//             fontWeight: FontWeight.w400,
//             color: globalDefault,
//           ),
//         ),
//       ],
//     ),
//     ),
//   );
// }

