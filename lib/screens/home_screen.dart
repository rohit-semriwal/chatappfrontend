import 'package:chatappfrontend/models/user_model.dart';
import 'package:chatappfrontend/screens/chat_screen.dart';
import 'package:chatappfrontend/screens/login_screen.dart';
import 'package:chatappfrontend/screens/search_screen.dart';
import 'package:chatappfrontend/services/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final UserModel myUser;
  const HomeScreen({ Key? key, required this.myUser }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void showSignOutConfirmation() {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Sign Out?"),
        content: Text("Your details will be erased from the device"),
        actions: [

          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),

          TextButton(
            onPressed: () async {
              await LocalStorage.clearUserDetails();

              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacement(context, CupertinoPageRoute(
                builder: (context) => LoginScreen()
              ));
            },
            child: Text("Sign Out", style: TextStyle(
              color: Colors.red
            ),),
          ),

        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        actions: [

          IconButton(
            onPressed: () {
              showSignOutConfirmation();
            },
            icon: Icon(Icons.exit_to_app),
          ),

        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [

            // ListTile(
            //   onTap: () {
            //     Navigator.push(context, CupertinoPageRoute(
            //       builder: (context) => ChatScreen()
            //     ));
            //   },
            //   leading: CircleAvatar(
            //     child: Text("RS"),
            //   ),
            //   title: Text("Rohit Semriwal"),
            //   subtitle: Text("hey, how's it going?"),
            // ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, CupertinoPageRoute(
            builder: (context) => SearchScreen(
              myUser: widget.myUser,
            )
          ));
        },
        child: Icon(Icons.search),
      ),
    );
  }
}