import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String title;
  final Function onPress;
  final dynamic color;
  final double padding;
  final double fontSize;
  final double buttonSize;

  MyButton({
    required this.title,
    required this.onPress,
    this.color,
    this.padding = 5.0,
    this.fontSize = 24.0,
    this.buttonSize = 70.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: ElevatedButton(
        onPressed: () => onPress(),
        child: Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: color is Color ? color : null,
          minimumSize: Size(buttonSize, buttonSize),
        ),
      ),
    );
  }
}
