
import 'package:flutter/material.dart';

 class DhanrashiTheme {

         List<Color> scaffoldColors = [];
         List<Color> cardColors = [];
   final Color shadowColor;
   final Color accentButtonColor;
   final Color influencedButtonColor;
   final Color navigationColor;
   final Color lightTextColor;
   final Color darkTextColor;
   final Color linkTextColor;
   final Color titleColor; // used for appbars of card title
  final Color titleTextColor;
    final Color accentColor; // used for illumination on part of components;
  final Color insetBorderColor;
  final Color outsetBorderColor;
   List<Color> gradientColors = [];
   final Color inputTextColor;
    final TextStyle titleTextStyle;
    List<Color> reportCardColor = [];
    OutlineInputBorder formTextBorder;
    TextStyle hintTextStyle;



  DhanrashiTheme({
   this.scaffoldColors,
  this.cardColors,
  this.shadowColor,
  this.accentColor,
  this.navigationColor,
  this.accentButtonColor,
  this.influencedButtonColor,
  this.linkTextColor,
  this.lightTextColor,
   this.darkTextColor,
  this.titleColor,
  this.titleTextColor,
  this.insetBorderColor,
  this.outsetBorderColor,

   this.gradientColors,
    this.inputTextColor,
  this.titleTextStyle,
    this.reportCardColor,

    this.formTextBorder,
    this.hintTextStyle
});




}