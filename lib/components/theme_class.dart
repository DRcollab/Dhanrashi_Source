
import 'package:flutter/material.dart';

 class DhanrashiTheme {

   final String progressIndicator;
   final Color themeColor; /// Used as main concept of the theme like light and dark  theme
   //final Color influenceColor; /// Second color of the theme , generally it takes a slight different shade from the theme color
   // for a monochromatic design
    //    List<Color> scaffoldColors = [];
       final  List<Color> influenceColors;
        final Color shadowColor;  /// Defines the shadow of  elevated component
        final Color accentColor; /// This is the  color in the theme that defines the button  and other components
        final Color alternateColor; /// This color is for buttons and other componants that contrasts each other ;
        /// Like say active and inactive color
        final Color highLightColor; /// This color defines the heading of text and mostly has contrasted value with the background
        final Color lightWeightColor; /// This color defines the normal text color
        final Color linkTextColor; /// Takes the color of a link text after being clicked;

      //  final Color accentButtonColor;
        final Color borderColor; /// Equirpped for darker themes holds the boreder color;


  // final Color influencedButtonColor;
  //  final Color navigationColor;
  //  final Color lightTextColor;
  //  final Color darkTextColor;
  //
  //  final Color titleColor; // used for appbars of card title
  // final Color titleTextColor;
  //  // final Color accentColor; // used for illumination on part of components;
  // final Color insetBorderColor;
  // //final Color outsetBorderColor;
  // // List<Color> gradientColors = [];
  //  final Color inputTextColor;
  //   final TextStyle titleTextStyle;
  //  List<Color> reportCardColor = [];
  //  OutlineInputBorder formTextBorder;
  //  TextStyle hintTextStyle;



  DhanrashiTheme({
    required this.progressIndicator,
    required this.themeColor,
    required this.influenceColors,
    required this.accentColor,
    required this.alternateColor,

    required this.highLightColor,
    required this.lightWeightColor,
    required this.borderColor,
  //  required this.scaffoldColors,
  // required this.cardColors,
  required this.shadowColor,
  //required this.accentColor,
  // required this.navigationColor,
 // required this.accentButtonColor,
 // required this.influencedButtonColor,
  required this.linkTextColor,



 //  required this.lightTextColor,
 //   required this.darkTextColor,
 //  required this.titleColor,
 //  required this.titleTextColor,
 // required this.insetBorderColor,
  //required this.outsetBorderColor,

  // required this.gradientColors,
  //   required this.inputTextColor,
  // required this.titleTextStyle,
  //  required this.reportCardColor,
  //
  //   required this.formTextBorder,
  //   required this.hintTextStyle
});




}