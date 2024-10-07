import 'package:shared_preferences/shared_preferences.dart';

class CacheNetwork {
  static late SharedPreferences sharedPref;
  static Future cacheInitialization() async {
    sharedPref = await SharedPreferences.getInstance();
  }

//insert

  static Future<bool> insertToCache(
      {required String key, required String val}) async {
    return await sharedPref.setString(key, val);
  }

//get

  static String getFromCache({required String key}) {
    return sharedPref.getString(key) ?? ''; // if has no data
  }

//delete
  static Future<bool> deletFromCache({required String key}) async {
    return await sharedPref.remove(key);
  }
//clear

  static Future<bool> clearall() async {
    return await sharedPref.clear();
  }
}
