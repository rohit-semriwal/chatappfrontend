import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final bool? textHidden;
  const MyTextField({ Key? key, required this.controller, this.hintText, this.textHidden }) : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {

  late bool isHidden;

  @override
  void initState() {
    super.initState();
    isHidden = widget.textHidden ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12
      ),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(7)
      ),
      child: Row(
        children: [

          Flexible(
            child: TextField(
              controller: widget.controller,
              obscureText: isHidden,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintText ?? ""
              ),
            ),
          ),

          (widget.textHidden == true) ? CupertinoButton(
            onPressed: () {
              setState(() {
                isHidden = !isHidden;
              });
            },
            padding: EdgeInsets.all(0),
            child: (isHidden == false) ? Icon(CupertinoIcons.eye_fill) : Icon(CupertinoIcons.eye_slash_fill),
          ) : Container(),

        ],
      ),
    );
  }
}