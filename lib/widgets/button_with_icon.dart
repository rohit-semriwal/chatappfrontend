import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonWithIcon extends StatelessWidget {
  final Function onPressed;
  final String text;
  final IconData iconData;
  const ButtonWithIcon({ Key? key, required this.onPressed, required this.text, required this.iconData }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: CupertinoButton(
        onPressed: () {
          onPressed();
        },
        color: Colors.blue,
        borderRadius: BorderRadius.circular(7),
        padding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 12
        ),
        child: Stack(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(iconData, size: 18,)
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(text),
              ],
            ),

          ],
        ),
      ),
    );
  }
}