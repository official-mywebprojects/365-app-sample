import 'package:flutter/material.dart';
import 'package:promises_of_god/Module/global_settings.dart';

class TextFieldWidget extends StatelessWidget {
  final String dHintText;
  final Widget dPrefixIcon;
  final bool dObText;
  final String dObCharacter;
  final TextInputType dKeyboardType;

  const TextFieldWidget({
    Key? key,
    required this.dHintText,
    required this.dPrefixIcon,
    required this.dObText,
    required this.dObCharacter,
    required this.dKeyboardType,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: globalAppColor,
      keyboardType: dKeyboardType,
      obscureText: dObText,
      //onChange: (){},
      obscuringCharacter: dObCharacter,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: globalInfoColor, width: 1),
          //borderRadius: BorderRadius.circular(30.0),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: globalAppColor, width: 1),
          //borderRadius: BorderRadius.circular(30.0),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: globalAppColor, width: 1),
          //borderRadius: BorderRadius.circular(30.0),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: globalAppColor, width: 1),
          //borderRadius: BorderRadius.circular(30.0),
        ),
        hintText: dHintText,
        prefixIcon: dPrefixIcon,
      ),
    );
  }
}


//The PrefixIcon
Widget dPrefixIcon(IconData dIcon){
  return Icon(
    dIcon,
    color: inputIcon,
    size: inputIconSize,
    );
}


//How to use your TextFieldWidget

// child: TextFieldWidget(
//   text: 'The text in the button',
// ),