import 'package:flutter/material.dart';
import 'package:knowledge_base_front/utils/app_theme.dart';

class CustomTextField {
  Widget primaryTextField({
    required BuildContext context,
    required TextEditingController textEditingController,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool? obscureText = false,
    IconData? prefixIcon,
    Color? textColor = Colors.black,
    Color borderColor = Colors.grey,
    double borderRadius = 50.0,
    double? fontSize = 14,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width/2,
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: TextField(
        cursorColor: Colors.grey.withOpacity(0.5),
        controller: textEditingController,
        obscureText: obscureText!,
        keyboardType: keyboardType,
        style: TextStyle(color: textColor, fontSize: fontSize),
        decoration: InputDecoration(
            hintText: hintText,
            prefix: prefixIcon != null ? Icon(prefixIcon) : null,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: AppTheme.appBarColor),
            ),
            enabledBorder: OutlineInputBorder(
               borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: AppTheme.appBarColor.withOpacity(0.5)),
            ),
            
           
      ),
    ));
  }
}
