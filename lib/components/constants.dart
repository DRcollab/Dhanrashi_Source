import 'package:dhanrashi_mvp/components/theme_class.dart';
import 'package:flutter/material.dart';


//var userLoggedIn = false; // used to determine whether

//int kDefaultPadding = 8;

//late final gCurrentUser;

// const kTitleTextStyle = TextStyle(
//       fontSize: 20.0,
//       fontFamily: 'Fredoka',
//       color: Colors.white38,
//     );


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





//

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



class DefaultValues {

  static double adaptForSmallDevice(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // For tiny devices.
    if (size.height < 600) {
      return 0.6;
    }
    // For normal devices.
    return 1.0;
  }

  static TextStyle kTitleTextStyle(context) {
    var kTitleTextStyle = TextStyle(
      fontSize: 20.0 * adaptForSmallDevice(context),
      fontFamily: 'Fredoka',
      color: Colors.white38,
    );

    return kTitleTextStyle;
  }



  static TextStyle kH1(context) => TextStyle(
    fontSize: 24 * adaptForSmallDevice(context),
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
  );


  static TextStyle kH2(context) => TextStyle(
    fontSize: 20 * adaptForSmallDevice(context),
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
  );

  static TextStyle kH3(context) => TextStyle(
    fontSize: 18 * adaptForSmallDevice(context),
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
  );
  ///
  ///





  static  kNormal1(context) => TextStyle(
    fontSize: 20 * adaptForSmallDevice(context),
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,

  );

  static kNormal2(context) => TextStyle(
    fontSize: 18* adaptForSmallDevice(context) ,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
  );

  static kNormal3(context) => TextStyle(
    fontSize: 12* adaptForSmallDevice(context),
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
  );

  static kNormalTextStyle(context) => TextStyle(
    color: Colors.white,
    fontSize: 20.0* adaptForSmallDevice(context) ,
  );

  static  kDarkTextStyle(context) => TextStyle(
    color: kPresentTheme.highLightColor,
    fontWeight: FontWeight.bold,
    fontSize: 20.0* adaptForSmallDevice(context) ,
  );

  static kAdviceTextStyleDark(context) => TextStyle(
    color: kPresentTheme.accentColor,
    fontSize: 18.0 *adaptForSmallDevice(context),
    fontStyle: FontStyle.italic,
  );

  static kHintTextStyle(context) =>  TextStyle(
    fontStyle: FontStyle.italic,
    color: Color(0x88004752),
  );

  static kTextFieldPadding(context) =>  EdgeInsets.fromLTRB(
  18.0 * adaptForSmallDevice(context),
  8.0 * adaptForSmallDevice(context),
  18.0 * adaptForSmallDevice(context),
  8.0 * adaptForSmallDevice(context),

  );

  static kDefaultPaddingAllSame(context) => EdgeInsets.all
    (8.0 * adaptForSmallDevice(context));


}

