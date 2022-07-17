import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static SharedPreferences? sharedPref;

  static Future<bool> saveDataInCash(
      {required String key, required dynamic value}) async {
    if (value is String) return await sharedPref!.setString(key, value);
    if (value is int) return await sharedPref!.setInt(key, value);
    if (value is bool) return await sharedPref!.setBool(key, value);
    return await sharedPref!.setDouble(key, value);
  }

  static dynamic getCashData({required dynamic key}) {
    return sharedPref!.get(key);

  }

  static Future<bool> removeCashData({required dynamic key}) async {
    return await sharedPref!.remove(key);
  }
}
