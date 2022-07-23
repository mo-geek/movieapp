import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static void setString(String key, String value) {
    sharedPreferences.setString(key, value);
  }

  static void setBool(String key, bool value) {
    sharedPreferences.setBool(key, value);
  }


  static String? getString(String key) {
    return sharedPreferences.getString(key);
  }

  static bool? getBool(String key) {
    return sharedPreferences.getBool(key);
  }

  @override
  String toString() => sharedPreferences.toString();
}
