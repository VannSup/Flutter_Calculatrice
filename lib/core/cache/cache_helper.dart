import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String?> read(String key) async {
    try {
      final SharedPreferences prefs = await _prefs;
      final String? data = prefs.getString(key);
      print(data);
      return data;
    } catch (e) {
      return null;
    }
  }

  Future save(String key, String data) async {
    try {
      final SharedPreferences prefs = await _prefs;
      prefs.setString(key, data);
    } catch (e) {
      print(e);
    }
  }

  Future remove(String key) async {
    try {
      final SharedPreferences prefs = await _prefs;
      prefs.remove(key);
    } catch (e) {
      print(e);
    }
  }
}
