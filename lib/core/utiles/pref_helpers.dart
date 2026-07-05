import 'package:shared_preferences/shared_preferences.dart';

class PrefHelpers {
  static const String _tokenKey = 'auth_token';
  static SharedPreferences? _prefs;

  static Future<SharedPreferences> get _instance async {
    return _prefs ??= await SharedPreferences.getInstance();
  }

  static Future<void> setToken(String token) async {
    final prefs = await _instance;
    prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await _instance;
    return prefs.getString(_tokenKey);
  }

  static Future<void> clearToken() async {
    final prefs = await _instance;
    prefs.remove(_tokenKey);
  }
}
