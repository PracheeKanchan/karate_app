import 'package:shared_preferences/shared_preferences.dart';

class SessionData {
  static bool? isLogin;

  // Store session data (login state)
  static Future<void> storeSessionData({required bool loginData}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("loginSession", loginData);
  }

  // Get session data (login state)
  static Future<void> getSessionData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    isLogin = sharedPreferences.getBool("loginSession") ?? false; // Default to false if not set
  }

  // Clear session data (logout)
  static Future<void> clearSessionData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("loginSession");
  }
}
