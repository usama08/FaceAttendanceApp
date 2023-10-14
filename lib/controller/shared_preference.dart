import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static saveLoggedIn(bool loggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("isLoggedIn", loggedIn);
  }

  static getLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? logged = preferences.getBool("isLoggedIn");
    return logged;
  }

  static saveUserName(String username) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("username", username);
  }

  static getUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? logged = preferences.getString("username");
    return logged;
  }

  static savePassword(String password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("password", password);
  }

  static getPassword() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? logged = preferences.getString("password");
    return logged;
  }
}
