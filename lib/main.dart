import 'package:chatappfrontend/constants/themes.dart';
import 'package:chatappfrontend/models/user_model.dart';
import 'package:chatappfrontend/providers/theme_provider.dart';
import 'package:chatappfrontend/screens/home_screen.dart';
import 'package:chatappfrontend/screens/login_screen.dart';
import 'package:chatappfrontend/screens/signup_screen.dart';
import 'package:chatappfrontend/services/api.dart';
import 'package:chatappfrontend/services/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String theme = prefs.getString("theme") ?? "light";

  bool isLoggedIn = false;
  Map<String, dynamic> userMap = await LocalStorage.fetchUserDetails();
  if(userMap["email"] != "" && userMap["password"] != "") {
    isLoggedIn = true;
  }

  dynamic result = await API.loginUser(userMap["email"], userMap["password"]);

  UserModel? myUser;
  if(result["success"] == true) {
    myUser = UserModel.fromJson(result["data"]);
  }
  else {
    isLoggedIn = false;
  }

  runApp(MyApp(theme: theme, isLoggedIn: isLoggedIn, myUser: myUser,));
}

class MyApp extends StatelessWidget {
  final String theme;
  final bool isLoggedIn;
  final UserModel? myUser;

  const MyApp({ Key? key, required this.theme, required this.isLoggedIn, this.myUser }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(theme),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeProvider.themeMode,
            home: (isLoggedIn) ? HomeScreen(
              myUser: myUser!,
            ) : LoginScreen(),
          );
        },
      ),
    );

  }
}