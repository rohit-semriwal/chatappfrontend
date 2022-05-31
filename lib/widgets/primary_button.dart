import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  final Function onPressed;
  final String text;
  final bool? outlined;
  const PrimaryButton({ Key? key, required this.onPressed, required this.text, this.outlined = false }) : super(key: key);

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: (widget.outlined == true) ? Colors.white : Colors.blue,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: Colors.blue,
          width: 1
        )
      ),
      child: CupertinoButton(
        onPressed: () {
          widget.onPressed();
        },
        color: Colors.transparent,
        child: Text(widget.text, style: TextStyle(
          color: (widget.outlined == true) ? Colors.blue : Colors.white
        ),),
      ),
    );
  }
}