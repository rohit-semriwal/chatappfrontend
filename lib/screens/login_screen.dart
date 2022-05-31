import 'dart:developer';
import 'package:chatappfrontend/models/user_model.dart';
import 'package:chatappfrontend/screens/home_screen.dart';
import 'package:chatappfrontend/screens/signup_screen.dart';
import 'package:chatappfrontend/services/api.dart';
import 'package:chatappfrontend/services/dialog_services.dart';
import 'package:chatappfrontend/services/local_storage.dart';
import 'package:chatappfrontend/widgets/my_textfield.dart';
import 'package:chatappfrontend/widgets/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool isLoading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void logIn() async {
    setState(() {
      isLoading = true;
    });

    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if(email == "" || password == "") {
      log("Please fill all the fields!");
    }
    else {
      dynamic result = await API.loginUser(email, password);
      if(result["success"] == true) {
        await LocalStorage.saveUserDetails(email, password);

        UserModel myUser = UserModel.fromJson(result["data"]);
        log(myUser.toJson().toString());

        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(context, CupertinoPageRoute(
          builder: (context) => HomeScreen(
            myUser: myUser,
          )
        ));
      }
      else {
        DialogServices.showSnackbar(context, content: result["message"]);
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sign In"),
      ),
      body: SafeArea(
        child: ListView(
          children: [

            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [

                  MyTextField(
                    controller: emailController,
                    hintText: "Email Address",
                  ),

                  SizedBox(height: 15,),

                  MyTextField(
                    textHidden: true,
                    controller: passwordController,
                    hintText: "Password",
                  ),

                  SizedBox(height: 15,),

                  PrimaryButton(
                    onPressed: () {
                      logIn();
                    },
                    text: "Sign In",
                  ),

                  SizedBox(height: 5,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text("Don't have an account?", style: TextStyle(fontSize: 15),),
                      
                      CupertinoButton(
                        onPressed: () {
                          Navigator.push(context, CupertinoPageRoute(
                            builder: (context) => SignUpScreen()
                          ));
                        },
                        padding: EdgeInsets.all(0),
                        child: Text("Create an account", style: TextStyle(fontSize: 15),),
                      ),

                    ],
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}