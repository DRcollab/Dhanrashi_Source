
import 'package:flutter/material.dart';

 class DhanrashiTheme {

   final String progressIndicator;
   final Color themeColor; /// Used as main concept of the theme like light and dark  theme

       final  List<Color> influenceColors;
        final Color shadowColor;  /// Defines the shadow of  elevated component
        final Color accentColor; /// This is the  color in the theme that defines the button  and other components
        final Color alternateColor; /// This color is for buttons and other componants that contrasts each other ;
        /// Like say active and inactive color
        final Color highLightColor; /// This color defines the heading of text and mostly has contrasted value with the background
        final Color lightWeightColor; /// This color defines the normal text color
        final Color linkTextColor; /// Takes the color of a link text after being clicked;
        final Color errorAccentColor;
        final Color defaultAccentColor;
      //  final Color accentButtonColor;
        final Color borderColor; /// Equirpped for darker themes holds the boreder color;






  DhanrashiTheme({
    required this.progressIndicator,
    required this.themeColor,
    required this.influenceColors,
    required this.accentColor,
    required this.alternateColor,
    required this.errorAccentColor,
    required this.highLightColor,
    required this.lightWeightColor,
    required this.borderColor,

  required this.shadowColor,

  required this.linkTextColor,
    required this.defaultAccentColor,




});




}