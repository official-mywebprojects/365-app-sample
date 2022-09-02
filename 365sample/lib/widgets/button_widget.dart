import 'package:flutter/material.dart';
import 'package:promises_of_god/Module/global_settings.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        // Container(
        //   color: Colors.transparent,
        //   padding: EdgeInsets.all(0.0), //was 10 before
        //   //width: double.infinity,
        //   child:
        ElevatedButton(
      style: ElevatedButton.styleFrom(
        //minimumSize: Size.fromWidth(double.infinity),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        primary: globalAppColor,
        onPrimary: Colors.blueGrey,
        elevation: 0,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: BtnFnt1,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      onPressed: onClicked,
      //),
    );
  }
}

