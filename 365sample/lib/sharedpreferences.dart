import 'package:promises_of_god/Module/global_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserClickCount {
  static late SharedPreferences _preferences; //changed all from static to final

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

//the setNumber method
  static Future setNumber(int number) async {
    await _preferences.setInt('num', number);
  }

  //getting the stored value
  static int? getNumber() => _preferences.getInt('num');

//the setColor method
  static Future setColorState(bool color) async {
    await _preferences.setBool('col', color);
  }

//getting the stored color state
  static bool? getColorState() => _preferences.getBool('col');

  //the persistPromise method
  static Future savePromise(List<String> promises) async {
    await _preferences.setStringList('listString', promises);
  }

  //getting the stored promises state
  static List<String>? getSavedPromise() =>
      _preferences.getStringList('listString');
}

// getColorState(bool color) {
//   bool isLiked = false;
//   switch (color) {
//     case true:
//       isLiked = !isLiked;
//       break;
//     case false:
//       isLiked = isLiked;
//       break;
//   }
//   //default app color
//   return color;
// }
