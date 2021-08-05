
import 'package:flutter/material.dart';

 class DhanrashiTheme {

   //final Color themeColor; /// Used as main concept of the theme like light and dark  theme
   //final Color prominentColor;
        List<Color> scaffoldColors = [];
        List<Color> cardColors = [];
   final Color shadowColor;
   final Color accentButtonColor;
  // final Color influencedButtonColor;
   final Color navigationColor;
   final Color lightTextColor;
   final Color darkTextColor;
   final Color linkTextColor;
   final Color titleColor; // used for appbars of card title
  final Color titleTextColor;
    final Color accentColor; // used for illumination on part of components;
  final Color insetBorderColor;
  //final Color outsetBorderColor;
  // List<Color> gradientColors = [];
   final Color inputTextColor;
    final TextStyle titleTextStyle;
   List<Color> reportCardColor = [];
   OutlineInputBorder formTextBorder;
   TextStyle hintTextStyle;



  DhanrashiTheme({
   required this.scaffoldColors,
  required this.cardColors,
  required this.shadowColor,
  required this.accentColor,
  required this.navigationColor,
  required this.accentButtonColor,
 // required this.influencedButtonColor,
  required this.linkTextColor,
  required this.lightTextColor,
   required this.darkTextColor,
  required this.titleColor,
  required this.titleTextColor,
 required this.insetBorderColor,
  //required this.outsetBorderColor,

  // required this.gradientColors,
    required this.inputTextColor,
  required this.titleTextStyle,
   required this.reportCardColor,

    required this.formTextBorder,
    required this.hintTextStyle
});




}