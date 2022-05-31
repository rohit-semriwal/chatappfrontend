import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  drawerTheme: DrawerThemeData(
    backgroundColor: Colors.blue
  ),
  // colorScheme: ColorScheme.light(
  //   primary: Color(value)
  // ),
  // primarySwatch: Color(0xff1ab7c3),
  // appBarTheme: AppBarTheme(
  //   elevation: 0,
  //   backgroundColor: Colors.white,
  //   iconTheme: IconThemeData(
  //     color: Colors.black
  //   )
  // )
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xff15161a),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black
  )
);