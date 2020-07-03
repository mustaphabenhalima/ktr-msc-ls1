import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color color;
  final Color backgroundColor;

  RoundedButton({
    @required this.text,
    @required this.onPressed,
    this.color = Colors.black,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 25.0),
      color: backgroundColor,
      child: Text(
        text,
        style: TextStyle(
            color: color, fontWeight: FontWeight.bold, fontSize: 18.0),
      ),
    );
  }
}
