import 'package:dhanrashi_mvp/components/theme_class.dart';
import 'package:flutter/material.dart';

var userLoggedIn = false; // used to determine whether

double adaptForeSmallDevice(BuildContext context) {
  final size = MediaQuery.of(context).size;
  // For tiny devices.
  if (size.height < 600) {
    return 0.6;
  }
  // For normal devices.
  return 1.0;
}

late final gCurrentUser;

const kTitleTextStyle = TextStyle(
      fontSize: 20.0,
      fontFamily: 'Fredoka',
      color: Colors.white38,
    );


DhanrashiTheme kLimeTheme =  DhanrashiTheme(

  themeColor:Color(0xFFfafafa),
  influenceColors: [Color(0xfff0f0f0),Color(0xFFf7f7f7)],

  alternateColor: Color(0xffb5c210),
  accentColor: Color(0xFF004752),
  shadowColor: Colors.black38,
  linkTextColor: Color(0xFF193F6C),
  borderColor: Colors.white24,

  highLightColor: Color(0xFF004752),
  lightWeightColor: Color(0xffb5c210),





 );






DhanrashiTheme kPresentTheme = kLimeTheme;




const kNormalTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 20.0,
);
//
 var kDarkTextStyle = TextStyle(
  color: kPresentTheme.highLightColor,
  fontWeight: FontWeight.bold,
  fontSize: 20.0,
);
//
const kTextFieldPadding = const EdgeInsets.fromLTRB(18.0, 8.0, 18.0, 8.0);

var kAdviceTextStyleDark = TextStyle(
  color: kPresentTheme.accentColor,
  fontSize: 18.0,
  fontStyle: FontStyle.italic,
);
//
var kInputTextStyle = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,
    color: kPresentTheme.accentColor);


final kFormTextBorder = OutlineInputBorder(

gapPadding: 2.0,
borderRadius: BorderRadius.circular(25.0),
borderSide: BorderSide(
color: Color(0xFF004752),
)
);

final kFormErrorTextBorder = OutlineInputBorder(

    gapPadding: 2.0,
    borderRadius: BorderRadius.circular(25.0),
    borderSide: BorderSide(
      color: Colors.red,
    )
);

final kHintTextStyle =  TextStyle(
    fontStyle: FontStyle.italic,
    color: Color(0x88004752),
);


TextStyle kH1 = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  fontStyle: FontStyle.normal,
);


TextStyle kH2 = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  fontStyle: FontStyle.normal,
);

TextStyle kH3 = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  fontStyle: FontStyle.normal,
);
///
///





final kNormal1 = TextStyle(
fontSize: 20,
fontWeight: FontWeight.normal,
fontStyle: FontStyle.normal,

);

final kNormal2 = TextStyle(
fontSize: 18,
fontWeight: FontWeight.normal,
fontStyle: FontStyle.normal,
);

final kNormal3 = TextStyle(
fontSize: 12,
fontWeight: FontWeight.normal,
fontStyle: FontStyle.normal,
);
