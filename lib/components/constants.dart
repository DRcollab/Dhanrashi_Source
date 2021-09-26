import 'package:dhanrashi_mvp/components/theme_class.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';



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
  shadowColor: Colors.black12,
  linkTextColor: Color(0xFF193F6C),
  borderColor: Colors.white24,

  highLightColor: Color(0xFF004752),
  lightWeightColor: Color(0xffb5c210),





 );






DhanrashiTheme kPresentTheme = kLimeTheme;





//

//







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
    print('Adapted Width :${size.width} and adapted height:${size.height}' );
    if (size.height < 600) {
      return 0.6;
    }
    // For normal devices.
    return 1.0;
  }

  static double reduceWidthAsPerScreen(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // For tiny devices.
    print('Adapted Width :${size.width} and adapted height:${size.height}' );
    if (size.width < 300) {
      return 0.8;
    }
    // For normal devices.
    return 1.0;
  }


  static double adaptFontsForSmallDevice(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // For tiny devices.
    if (size.height < 600) {
      return 0.6;
    }
    // For normal devices.
    return 1.0;
  }

  static double adaptByValue(BuildContext context, double value) {
    final size = MediaQuery.of(context).size;
    // For tiny devices.
    if (size.height < 600) {
      return value;
    }
    // For normal devices.
    return 1.0;
  }



  static TextStyle kTitleTextStyle(context) {
    var kTitleTextStyle = TextStyle(
      fontSize: 20.0 * adaptFontsForSmallDevice(context),
      fontFamily: 'Fredoka',
      color: Colors.white38,
    );

    return kTitleTextStyle;
  }



  static TextStyle kH1(context) => TextStyle(
    fontSize: 18.sp, //* adaptFontsForSmallDevice(context),
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
  );


  static TextStyle kH2(context) => TextStyle(
    fontSize: 16.sp,// * adaptFontsForSmallDevice(context),
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
  );

  static TextStyle kH3(context) => TextStyle(
    fontSize: 14.sp, //* adaptFontsForSmallDevice(context),
    height: 1,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
  );
  ///
  ///
  static TextStyle kH4(context) => TextStyle(
    fontSize: 12.sp, //* adaptFontsForSmallDevice(context),
    height: 1,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
  );


  static const kCurveRadius = 15.0;

  static  kNormal1(context) => TextStyle(
    fontSize: 20 * adaptFontsForSmallDevice(context),
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,

  );

  static kNormal2(context) => TextStyle(
    fontSize: 15.sp,//* adaptFontsForSmallDevice(context) ,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
  );

  static kNormal3(context) => TextStyle(
    fontSize: 12.sp,//* adaptFontsForSmallDevice(context),
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
  );

  static kNormalTextStyle(context) => TextStyle(
    color: Colors.white,
    fontSize: 20.0* adaptFontsForSmallDevice(context) ,
  );

  static  kDarkTextStyle(context) => TextStyle(
    color: kPresentTheme.highLightColor,
    fontWeight: FontWeight.bold,
    fontSize: 20.0* adaptFontsForSmallDevice(context) ,
  );

  static kAdviceTextStyleDark(context) => TextStyle(
    color: kPresentTheme.accentColor,
    fontSize: 18.0 *adaptFontsForSmallDevice(context),
    fontStyle: FontStyle.italic,
  );

  static kHintTextStyle(context) =>  TextStyle(
    fontStyle: FontStyle.italic,
    color: Color(0x88004752),
  );

  static kTextFieldPadding(context) =>  EdgeInsets.fromLTRB(
  6.w, //* adaptForSmallDevice(context),
  1.h, //* adaptForSmallDevice(context),
  8.w, //* adaptForSmallDevice(context),
  1.h, //* adaptForSmallDevice(context),

  );

  static kDefaultPaddingAllSame(context) => EdgeInsets.all
    (1.h, //* adaptForSmallDevice(context)
       );

  static kDefaultHorizontalSymmetricPadding(context) => EdgeInsets.symmetric(
    horizontal: 2.w
  );

  static  kInputTextStyle(context) => TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.bold,
      color: kPresentTheme.accentColor);

  static kAdaptedTopPadding(context, double value)
  => EdgeInsets.only(top:value );

  static kAdaptedBottoemPadding(context, double value)
  => EdgeInsets.only(bottom:value * adaptForSmallDevice(context)

  );
  static kAdaptedLeftPadding(context, double value)
  => EdgeInsets.only(left:value * adaptForSmallDevice(context)

  );
  static kAdaptedRightPadding(context, double value)
  => EdgeInsets.only(right:value * adaptForSmallDevice(context)

  );

  static List<Color> graphColors = [

      Color(0xFF004752),
      Color(0xffb5c210),
      Color(0xff005213),
      Colors.amber,
      Colors.purple,
      Colors.orange,
      Colors.red,
      Colors.indigo,
      Colors.lightBlue,
      Colors.yellow,
      Color(0xff324d3b),
      Color(0xff4d2b69),
      Colors.deepOrange,
      Color(0xffd181de),
      Color(0xff5696c7),









  ];

}


