import 'dart:developer';

import 'package:chatappfrontend/models/user_model.dart';
import 'package:chatappfrontend/providers/chat_provider.dart';
import 'package:chatappfrontend/screens/chat_screen.dart';
import 'package:chatappfrontend/screens/login_screen.dart';
import 'package:chatappfrontend/screens/search_screen.dart';
import 'package:chatappfrontend/services/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  void initState() {
    super.initState();
    Provider.of<ChatProvider>(context, listen: false).initialize(widget.myUser);
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
        child: Consumer<ChatProvider>(
          builder: (context, chatprovider, child) {

            if(chatprovider.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if(chatprovider.chatrooms.length > 0) {
              return ListView.builder(
                itemCount: chatprovider.chatrooms.length,
                itemBuilder: (context, index) {

                  log(chatprovider.chatrooms[index].participants.toString());

                  UserModel targetUser = chatprovider.chatrooms[index].participants!.firstWhere((user) {
                    log(user.id.toString());
                    return user.id != widget.myUser.id;
                  }, orElse: () {
                    log("No user found!");
                    return UserModel();
                  });

                  return ListTile(
                    onTap: () {
                      Navigator.push(context, CupertinoPageRoute(
                        builder: (context) => ChatScreen(myUser: widget.myUser, targetUser: targetUser)
                      ));
                    },
                    leading: CircleAvatar(
                      child: Text(targetUser.fullname![0].toString()),
                    ),
                    title: Text(targetUser.fullname.toString()),
                    subtitle: Text("Say hi to your new friend!"),
                  );

                },
              );
            }
            else{
              return Center(
                child: Text("No chatrooms found!"),
              );
            }

          },
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