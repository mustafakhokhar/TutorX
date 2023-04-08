import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorx/models/user_model.dart';
import 'package:tutorx/utils/base_client.dart';

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

  static Future<void> StoreUserDetailsInCache(String uid) async {
      var response = await BaseClient().get("/user/$uid").catchError((err) {});
      var user = usersFromJson(response);
      // print('Here: ${user.fullname}');
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('fullname', user.fullname);
      await prefs.setString('uid', user.uid);
      await prefs.setBool('student', user.student);
      await prefs.setBool('isLoggedIn', true);
    }

  static Future<void> ClearUserDetailsFromCache() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('fullname', '');
      await prefs.setString('uid', '');
      await prefs.setBool('student', false);
      await prefs.setBool('isLoggedIn', false);
    }
}
