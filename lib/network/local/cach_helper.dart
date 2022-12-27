import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences shrdprfs;
  static init() async {
    shrdprfs = await SharedPreferences.getInstance();
  }

  static Future<bool> putBool({
    required String key,
    required bool value,
  }) async {
    return await shrdprfs.setBool(key, value);
  }

  static bool? getBool({
    required String key,
  }) {
    return shrdprfs.getBool(key);
  }

  static dynamic getData({
    required String key,
  }) {
    return shrdprfs.get(key);
  }

  static Future<bool?> saveDate({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await shrdprfs.setString(key, value);
    }

    if (value is int) {
      return await shrdprfs.setInt(key, value);
    }
    if (value is bool) {
      return await shrdprfs.setBool(key, value);
    }
    return shrdprfs.setDouble(key, value);
  }

  static Future<bool> removeData({required String key}) async {
    return await shrdprfs.remove(key);
  }
}
