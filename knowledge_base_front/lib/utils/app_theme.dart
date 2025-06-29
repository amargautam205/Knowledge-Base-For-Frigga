
import 'package:flutter/material.dart';

class AppTheme{

  // App Bar Color
   static final Color appBarColor = hexToColor("#0ebe7e");
   static final Color appBarTextColor = hexToColor("#ffffff");

   // Button Color
   static final Color primaryButtonTextColor =  hexToColor("#ffffff");
   static final Color primaryButtonBackgroundColor = hexToColor("#0ebe7e");

   //Selected item Color  Bottom Bar
   static final Color selectedItemColor = hexToColor("#0ebe7e"); 

   // Common Text Size
   static const double smallTextSize = 12.0;
   static const double mediumTextSize = 16.0;
   static const double largeTextSize = 18.0;

   // Commmon  Heading Text Style
   static const TextStyle headingTextStyle = TextStyle(
      fontSize: largeTextSize,
      fontWeight: FontWeight.bold,
      color: Colors.black
   );
      // Commmon Sub-Heading Text Style
   static const TextStyle subHeadingTextStyle = TextStyle(
      fontSize: mediumTextSize,
      fontWeight: FontWeight.w500,
      color: Colors.black
   );

   // Commmon  Body Text Style
   static const TextStyle bodyTextStyle = TextStyle(
      fontSize: smallTextSize,
      color: Colors.black
   );


    // Method to convert hex to Color
    static Color hexToColor(String hex) {
    return Color(int.parse(hex.replaceFirst('#', '0xFF')));
  }

}