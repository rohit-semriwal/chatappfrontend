import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogServices {

  static void showSnackbar(BuildContext context, { required String content, Color? backgroundColor, Duration? duration }) {
    SnackBar snackBar = SnackBar(
      content: Text(content),
      backgroundColor: backgroundColor ?? Colors.red,
      duration: duration ?? Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}