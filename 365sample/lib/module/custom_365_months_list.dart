import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:promises_of_god/Module/global_settings.dart';

Widget customMonthLists(
    {required String month,
    required String monthtagline,
    required String monthimage,
    onTap}) {
  return InkWell(
    onTap: onTap,
    child: Card(
      //padding: EdgeInsets.all(10.0),
      child: Row(
        children: [
          Container(
            height: 65.0,
            width: 65.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              image: DecorationImage(
                image: AssetImage(monthimage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 15.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                month,
                style: TextStyle(
                  fontSize: globalHeading,
                  fontWeight: FontWeight.w500,
                  color: globalDefault, //globalDefault,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Month of ' + monthtagline,
                style: TextStyle(
                  color: globalDefault, //Colors.grey[650],
                  fontSize: BtnFnt1,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
