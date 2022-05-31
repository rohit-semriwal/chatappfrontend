import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {

  static Future<void> saveUserDetails(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", email);
    prefs.setString("password", password);

    log("User details saved!");
  }

  static Future<Map<String, dynamic>> fetchUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString("email") ?? "";
    String password = prefs.getString("password") ?? "";

    return {
      "email": email,
      "password": password
    };
  }

  static Future<void> clearUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", "");
    prefs.setString("password", "");

    log("User details cleared!");
  }

}