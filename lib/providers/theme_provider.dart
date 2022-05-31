import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  ThemeProvider(String theme) {
    if(theme == "light") {
      themeMode = ThemeMode.light;
    }
    else {
      themeMode = ThemeMode.dark;
    }

    notifyListeners();
  }

  void toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
      await prefs.setString("theme", "dark");
    }
    else {
      themeMode = ThemeMode.light;
      await prefs.setString("theme", "light");
    }

    notifyListeners();
  }

}

// 1. ChangeNotifier (TV)
// 2. ChangeNotifierProvider (TV SHOP)
// 3. Consumer (User)