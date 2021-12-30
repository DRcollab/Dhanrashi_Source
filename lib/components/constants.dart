import 'package:dhanrashi_mvp/components/theme_class.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';





var keyValue = "1//0g3rWVkbDBZi0CgYIARAAGBASNwF-L9IryMTSaus23u7smtHXfWADwbeTz4MN46YMJUnkshgW4nhz5FDVmNusXwmmZi3NTV3lOwM";


DhanrashiTheme kLimeTheme =  DhanrashiTheme(

  progressIndicator:  'images/gifs/rolling.gif',
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

int kInitialYear = 1950;

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

  static final textFormat = NumberFormat.simpleCurrency(locale:'en-in', decimalDigits: 0);
  static final textFormatWithDecimal = NumberFormat.simpleCurrency(locale:'en-in', decimalDigits: 1);
  static final textShortFormat = NumberFormat.compactSimpleCurrency(locale:'en-in');
  static final String directoryOfPhoto = 'images/profiles';
  static final threshold = 9999999999;  // 1 less than 1000 Cr.


  static String financialFormat( final format, double value){

      String formattedString = format.format(value);
      if(formattedString.contains('-')){
         return '(${formattedString.substring(1)})';
      }
      else{
        return formattedString;
      }
  }


 // static final textFormat1 =
  static double adaptForSmallDevice(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // For tiny devices.

    if (size.height < 600) {
      return 0.6;
    }
    // For normal devices.
    return 1.0;
  }

  static double reduceWidthAsPerScreen(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // For tiny devices.

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

  static screenHeight(BuildContext context){
    print(MediaQuery.of(context).size.height);
    return MediaQuery.of(context).size.height;

  }

  static screenWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
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
      Colors.purple,
      Colors.amber,
      Color(0xff005213),
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


class Messages{

  static String welcomeMessage = 'Welcome';
  static String investmentChoiceHeader = 'Click on any one of the investments';
  static String goalChoiceHeader = 'Click on any one of the goals';


}

