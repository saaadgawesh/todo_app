import 'package:shared_preferences/shared_preferences.dart';

class Applocal {
  static String imagekey = 'image_key';
  static String namekey = 'name_key';
  static Future<void> storagedata(String data, String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, data);
  }

  static Future<String> getdata(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }
}
