import 'dart:developer';

import 'package:chatappfrontend/models/user_model.dart';
import 'package:chatappfrontend/widgets/my_textfield.dart';
import 'package:chatappfrontend/widgets/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../services/api.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({ Key? key }) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  bool isLoading = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();

  void createUser() async {
    setState(() {
      isLoading = true;
    });

    String fullname = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cPassword = cPasswordController.text.trim();

    if(fullname == "" || email == "" || password == "" || cPassword == "") {
      log("Please fill all the fields!");
    }
    else if(password != cPassword) {
      log("Passwords do not match!");
    }
    else {
      UserModel userModel = UserModel(
        userid: Uuid().v1(),
        fullname: fullname,
        email: email,
        password: password,
      );
      
      bool result = await API.createUser(userModel);
      if(result == true) {
        Navigator.pop(context);
      }
      else {
        // SHOW ERROR
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
        title: Text("Sign Up"),
      ),
      body: SafeArea(
        child: ListView(
          children: [

            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [

                  MyTextField(
                    controller: nameController,
                    hintText: "Full Name",
                  ),

                  SizedBox(height: 15,),

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

                  MyTextField(
                    textHidden: true,
                    controller: cPasswordController,
                    hintText: "Confirm Password",
                  ),

                  SizedBox(height: 15,),

                  (isLoading == false) ? PrimaryButton(
                    onPressed: () {
                      createUser();
                    },
                    text: "Create Account",
                  ) : Center(
                    child: CircularProgressIndicator(),
                  ),

                  SizedBox(height: 5,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text("Already have an account?", style: TextStyle(fontSize: 15),),
                      
                      CupertinoButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        padding: EdgeInsets.all(0),
                        child: Text("Sign Up", style: TextStyle(fontSize: 15),),
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