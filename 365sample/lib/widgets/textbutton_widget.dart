import 'package:flutter/material.dart';
import 'package:promises_of_god/Module/global_settings.dart';

class TextButtonWidget extends StatelessWidget {
  final String text;
  final Color color1;
  final Color color2;
  final VoidCallback onClicked;

  const TextButtonWidget({
    Key? key,
    required this.text,
    required this.color1,
    required this.color2,
    required this.onClicked,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color1), /*Colors.grey[100]*/
      ),
      child: Text(
        text, //'GO TO PROMISE',
        style: TextStyle(
          color: color2,
          fontSize: globalHeading,
          fontWeight: FontWeight.w400,
        ),
      ),
      onPressed: onClicked,
      // onPressed: () {
      //   value = TodayList[index]['value'];
      //   value2 = TodayList[index]['monthtagline'];
      //   value3 = TodayList[index]['pictureUrl'];
      //
      //   Navigator.of(context).push(
      //       CustomPageRoute(child: CurrentMonth(value: value, value2: value2, value3: value3), direction: AxisDirection.right,)
      //   );
      // },
    );
  }
}

