import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {
  // static Future<String?> getUsername() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('username');
  // }
  static Future<String> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString('fullname') ?? '';
    return userName;
  }

  static Future<bool> getisLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    return isLoggedIn;
  }

  static Future<bool> getisStudent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isStudent = prefs.getBool('student') ?? false;
    return isStudent;
  }

  static Future<String> getUID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('uid') ?? '';
    return uid;
  }
}
