import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton {

  //Primary Button
 Widget primaryButton({
    required double height,
    required double width,
    VoidCallback? onPressed,
    required String buttonText,
    required Color buttonTextColor,
    required Color buttonBackgroundColor,
    double fontSize = 14,
  }) {
    return GestureDetector(
      onTap:  onPressed == null ? null : () => onPressed!(),
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: buttonBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Text(buttonText ,style: TextStyle(fontSize: fontSize, color: buttonTextColor),textAlign: TextAlign.center,),
      ),
    );
  }
}
