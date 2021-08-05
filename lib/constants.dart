import 'package:dhanrashi_mvp/components/theme_class.dart';
import 'package:flutter/material.dart';

// DhanrashiTheme kDefaultTheme =  DhanrashiTheme(
//
//    scaffoldColors: [Color(0xFF193F6C),Color(0xFF193F6C)],
//    cardColors: [Colors.white38,Colors.white24],
//    accentButtonColor: Color(0xFF193F6C),
//    shadowColor: Colors.black54,
//    lightTextColor: Colors.white,
//    darkTextColor: Color(0xFF193F6C),
//    linkTextColor: Color(0xFF193F6C),
//    titleColor: Colors.amber,
//    accentColor: Color(0xFF193F6C),
//    titleTextColor:Color(0xFF193F6C),
//    navigationColor: Colors.amber,
//     insetBorderColor: Color(0xFF4d37dd),
//     inputTextColor: Colors.white38,
//     titleTextStyle: TextStyle(
//       fontSize: 20.0,
//       fontFamily: 'Fredoka',
//       color: Colors.white38,
//     )
//
//   titleTextStyle: TextStyle(
//   fontSize: 20.0,
//   fontFamily: 'Fredoka',
//   color: Color(0xFF004752),
// ),
//
//     formTextBorder: OutlineInputBorder(
//
// gapPadding: 2.0,
// borderRadius: BorderRadius.circular(25.0),
// borderSide: BorderSide(
// color: Color(0xFF004752),
// )
// ),
//
// hintTextStyle: TextStyle(
// fontStyle: FontStyle.italic,
// color: Color(0x88004752),
// ),
//
//
// );


DhanrashiTheme kLimeTheme =  DhanrashiTheme(

    scaffoldColors: [Colors.white,Colors.white],
    cardColors: [Color(0xffe3dfdf),Color(0xFFf7f7f7)],
    accentButtonColor: Color(0xFF004752),
    shadowColor: Colors.black54,
    lightTextColor: Colors.white,
    darkTextColor: Color(0xFF004752),
    linkTextColor: Color(0xFF193F6C),
    titleColor: Color(0x00f7f7f7),
    accentColor: Color(0xFF193F6C),
    titleTextColor:Color(0xFF004752),
    navigationColor: Color(0xffb5c210), // Color(0xFFe8f54a),
    insetBorderColor: Colors.white24,
    inputTextColor: Color(0xFF004752),
    reportCardColor: [Color(0xFFe8f54a), Color(0xFF004752),],
    titleTextStyle: TextStyle(
      fontSize: 20.0,
      fontFamily: 'Fredoka',
      color: Color(0xFF004752),
    ),

    formTextBorder: OutlineInputBorder(

        gapPadding: 2.0,
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(
          color: Color(0xFF004752),
        )
    ),

  hintTextStyle: TextStyle(
      fontStyle: FontStyle.italic,
      color: Color(0x88004752),
  ),
 );




//  DhanrashiTheme kDarkTheme =  DhanrashiTheme(
//
//   scaffoldColors: [Color(0xFF2c2a3d),Color(0xFF272362)],
//   cardColors: [Color(0xFF242a3f),Color(0xFF2d2a3e)],
//   accentButtonColor: Color(0xFF193F6C),
//   shadowColor: Color(0xff6a55f7),
//   lightTextColor: Colors.white,
//   darkTextColor: Color(0xFF193F6C),
//   linkTextColor: Color(0xFF193F6C),
//   titleColor: Color(0xFF242a3f),
//   accentColor: Color(0xFFb14bd5),
//   titleTextColor:Colors.white,
//   navigationColor: Colors.amber,
//   insetBorderColor: Color(0xFF4d37dd),
//   inputTextColor: Colors.white38,
//    titleTextStyle: TextStyle(
//      fontSize: 20.0,
//      fontFamily: 'Fredoka',
//      color: Colors.white38,
//    )
//
// );

 DhanrashiTheme kPresentTheme = kLimeTheme;


const kDarkColor = Color(0xFF193F6C);
const kDarkColor2 =Color(0xA193F6C);//Color(0xFFd234eb); //Color(0xFF197F6D);//Color(0xFF197F6D);// Color(0xFFd234eb);//
const kLightButtonColor = Colors.white24;
const kLightHeader = Colors.white24;
const kDarkButtonColor = Color(0xFF193F6C);
const kNormalTextColor = Colors.white;
const kLightTextColor = Colors.white;
const kDarkTextColor = Color(0xFF193F6C);
const kSpecialTextColor = 0;
const kNegativeTextColor = Colors.red;
final kBorderRadiusOfCommandButton = BorderRadius.circular(25.0);
const kNormalTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 20.0,
);

 var kDarkTextStyle = TextStyle(
  color: kPresentTheme.darkTextColor,
  fontWeight: FontWeight.bold,
  fontSize: 20.0,
);

const kTextFieldPadding = const EdgeInsets.fromLTRB(18.0, 8.0, 18.0, 8.0);
//EdgeInsets.only(left: 18, top: 8, right: 18, bottom: 0),
var kAdviceTextStyleLight = TextStyle(
  color: kPresentTheme.lightTextColor,
  fontSize: 20.0,
  fontStyle: FontStyle.italic,
);

var kAdviceTextStyleDark = TextStyle(
  color: kPresentTheme.darkTextColor,
  fontSize: 20.0,
  fontStyle: FontStyle.italic,
);

var kInputTextStyle = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,
    color: kPresentTheme.inputTextColor);

var kDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: kPresentTheme.scaffoldColors,
  ),
);


var kCardDecoration = BoxDecoration(
  
  borderRadius: BorderRadius.circular((20)),

  boxShadow: [BoxShadow(
    color: kPresentTheme.shadowColor,
    
  ),],
  gradient:  LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: kPresentTheme.cardColors

  )
);


var kOptionTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color:kPresentTheme.inputTextColor,

);

var kAlternateOptionTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color:kPresentTheme.lightTextColor,

);

var kH1 = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: Colors.black,

);

var kH3 = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.normal,
  color: Colors.black,

);