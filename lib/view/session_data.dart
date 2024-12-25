import 'package:shared_preferences/shared_preferences.dart';

class SessionData {
  static bool? isLogin;
  static String userName="";
  static bool isPurchased = false; // Default value, false until updated.
  static String userEmailId="";


  // Store session data (login state)
  static Future<void> storeSessionData({required bool loginData,required String userName,required String userEmailId})async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("loginSession", loginData);
    sharedPreferences.setString("userName", userName);
    sharedPreferences.setString('emailId', userEmailId);
    getSessionData();
  }

  // Get session data (login state)
  static Future<void> getSessionData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    isLogin = sharedPreferences.getBool("loginSession") ?? false; // Default to false if not set
    userName =sharedPreferences.getString("userName")??"";
    userEmailId=sharedPreferences.getString('emailId')?? "";
  }

  // Clear session data (logout)
  // static Future<void> clearSessionData() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   sharedPreferences.remove("loginSession");
  //   sharedPreferences.remove("userName");

  // }


  // Fetching the 'isPurchased' status from SharedPreferences
  static Future<void> getIsPurchased() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isPurchased= prefs.getBool('isPurchased') ?? false; // Returns false if not found
  }

  // Storing the 'isPurchased' status to SharedPreferences
  static Future<void> setIsPurchased(bool purchased) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isPurchased', purchased);
  }


  // Reset payment success to false
  static Future<void> resetPaymentSuccessToFalse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('paymentSuccess', false);
  }

  
 
}
