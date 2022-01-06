import 'package:dhanrashi_mvp/components/theme_class.dart';
import 'package:dhanrashi_mvp/data/global.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

var keyValue =
    "1//0g3rWVkbDBZi0CgYIARAAGBASNwF-L9IryMTSaus23u7smtHXfWADwbeTz4MN46YMJUnkshgW4nhz5FDVmNusXwmmZi3NTV3lOwM";

/// The above key is important for deployment -- need for dhanrashi team member

DhanrashiTheme kLimeTheme = DhanrashiTheme(
  progressIndicator: 'images/gifs/rolling.gif',
  themeColor: Color(0xFFfafafa),
  influenceColors: [Color(0xfff0f0f0), Color(0xFFf7f7f7)],
  alternateColor: Color(0xffb5c210),
  accentColor: Color(0xFF004752),
  shadowColor: Colors.black12,
  linkTextColor: Color(0xFF193F6C),
  borderColor: Colors.white24,
  highLightColor: Color(0xFF004752),
  lightWeightColor: Color(0xffb5c210),

  errorAccentColor: Colors.redAccent,




 );





DhanrashiTheme kPresentTheme = kLimeTheme;

int kInitialYear = 1950;

final kFormTextBorder = OutlineInputBorder(
    gapPadding: 2.0,
    borderRadius: BorderRadius.circular(25.0),
    borderSide: BorderSide(
      color: Color(0xFF004752),
    ));

final kFormErrorTextBorder = OutlineInputBorder(
    gapPadding: 2.0,
    borderRadius: BorderRadius.circular(25.0),
    borderSide: BorderSide(
      color: Colors.red,
    ));



class DefaultValues {
  static final textFormat =
      NumberFormat.simpleCurrency(locale: 'en-in', decimalDigits: 0);
  static final textFormatWithDecimal =
      NumberFormat.simpleCurrency(locale: 'en-in', decimalDigits: 1);
  static final textShortFormat =
      NumberFormat.compactSimpleCurrency(locale: 'en-in');
  static final String directoryOfPhoto = 'images/profiles';
  static final threshold = 9999999999;  // 1 less than 1000 Cr.
  static final maxSlideYear = 60.0; // defines the max Sliding year in goal / investment and SIP Calc
  static final goalDuration = 10;
  static final investmentDuration = 10;
  static final minReturn = 0.0;



  static var messages = {
    'welcome':'Welcome',
    'inv_choice':'Click on any one of the investments',
    'goal_choice':'Click on any one of the goals',
    'ask_for_profile':'Update your profile now',
    'timed_out':
        'It seems there is an issue with your internet connection. Check your settings or watch for an wifi hotspot.\n\n'
            ' Your data will be stored as soon as internet restores. Meanwhile you are free to do other things.',
    'success_update_profile': 'Your profile has been successfully updated.',
    'empty':
        'Let us start your financial planning by adding your first Goal and Investment',
    'empty_goal': 'You do not have any GOAL.\n\nLet\'s add your first Goal',
    'empty_inv':
        'You do not have any INVESTMENT.\n\nLet\'s add your first Investment ',
    '': '', // important donot remove//
    'date_picker': 'Select a date to continue',
    'profile_pic_change': 'Click the image to Edit',
    'first_name_empty': 'First Name should not be empty',
    'last_name_empty': 'Last Name should not be empty',
    'login_link_text': "Trouble logging in? Click here",
    'tnc_link_text': 'terms and conditions',
    'tnc': 'I agree to ',
    'ask_for_login': 'Already have a login id?',
  };

  static var showcaseMessages = {};

  static var titles = {
        'app_name':'Dhanrashi',
        'login_button_text': 'Login',
        'signup_option':"New User? Sign Up",
        'login_page_title': 'Login Page',
        'signup_title':'Signup Page',
        'signup_button_text':'Sign Up',
        'ask_login_button_text':'Click Here to Login',
        'inv_time_title':'Investment Duration',
        'inv_start_title':'Initial Investment',
        'inv_rec_title':'Annual Investment',
        'goal_period_title':'Goal duration',
        'update_profile_button_text':'Update profile',
        'link_text_skip': 'Skip to continue',
        'privacy_policy':'Privacy police',

        //Goal tiles titles . // in goal input menu
        'car':'My Dream\nCar',
        'house':'My Dream\nHouse',
        'education':'Child\nEducation',
        'retirement':'Retirement',
        'travel':'Travel',
        'family':'Family \nEvents',
        'health':'Health',
        'others':'Others',

          'car_st':'Buy my very own car\n',
          'house_st':'My sweet home\n',
          'education_st':'Education empowers life\n',
          'retirement_st':'A blissful life\n',
          'travel_st': 'Tours and travels\n',
          'family_st':'Moments of Togetherness',
          'health_st':'Health related expenses\n',
           'others_gol_st':'Anything not listed here\n',




        //Investment tiles titles . // in investment input menu
        'mf':'Mutual\nFund',
        'equity':'Equity',
        'fd':'Fixed\nDeposits',
        'real':'Real\nEstate',
        'gold':'Gold',
        'insurance':'Insurance',
        'bonds':'Bonds',
        'others_inv':'Other',

    //subtext

    'mf_st':'Equity and debt funds\n',
    'equity_st':'Stock market investments\n',
    'fd_st':'Fixed deposits\n',
    'real_st':'Lands,houses,complexes\n',
    'gold_st':'Physical and digital gold\n',
    'insurance_st':'Life insurance \n',
    'bonds_st':'Govt, corporate bonds\n',
    'others_st':'Any other asset class\n',

    'tab_1':'Analytics',
    'tab_2':'Goals',
    'tab_3':'Investments',
    'tab_header':'Dashboard',

    'bottom_tab_1':'Goals',
    'bottom_tab_2':'Investments',
    'bottom_tab3':'Dashboard',
    'bottom_tab4':'SIP Calculator',

    'chart_view_tab1':'Chart',
    'chart_view_tab2':'Table',

  };



 static var hints = {
      'email':'enter email',
      'pwd': 'enter password',
      'email_signup': 'enter your email to signup',
      're_pwd': 're-enter the password',
      'roi_hint':'Last 5 years Nifty grew at ${Global.stockReturn*100}%',
      'roi_hint_mf':'Last 5 years Debt funds grew at ${Global.stockReturn*100}%\n,Equity fund grew at ${Global.stockReturn*100}%\n& Balanced Fund grew at ${Global.stockReturn*100}%',

 };

  static var errors = {
    'not_match': 'password and confirm password must be same',
    'anonymous': 'something went wrong please restart the app',
  };

  static var recom_message = [
    'You are ahead of your goals at',
    'You are behind your goals at',
  ];

  static String minimumDate = '1900-01-01';
  static String minimumDateTime = '1900-01-01 00:00:00.000';

  static String financialFormat(final format, double value) {
    String formattedString = format.format(value);
    if (formattedString.contains('-')) {
      return '(${formattedString.substring(1)})';
    } else {
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


  // static String reduceAsPerDeviceSize(BuildContext context){
  //   final size = MediaQuery.of(context);
  //
  //   if(size.height < )
  // }

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

  static screenHeight(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    return MediaQuery.of(context).size.height;
  }

  static screenWidth(BuildContext context) {
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
        fontSize: 16.sp, // * adaptFontsForSmallDevice(context),
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
  ///
  static TextStyle kH4(context) => TextStyle(
        fontSize: 12.sp, //* adaptFontsForSmallDevice(context),
        height: 1,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
      );

  static const kCurveRadius = 15.0;

  static kNormal1(context) => TextStyle(
        fontSize: 20 * adaptFontsForSmallDevice(context),
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
      );

  static kNormal2(context) => TextStyle(
        fontSize: 15.sp, //* adaptFontsForSmallDevice(context) ,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
      );

  static kNormal3(context) => TextStyle(
        fontSize: 12.sp, //* adaptFontsForSmallDevice(context),
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
      );

  static kNormalTextStyle(context) => TextStyle(
        color: Colors.white,
        fontSize: 20.0 * adaptFontsForSmallDevice(context),
      );

  static kDarkTextStyle(context) => TextStyle(
        color: kPresentTheme.highLightColor,
        fontWeight: FontWeight.bold,
        fontSize: 20.0 * adaptFontsForSmallDevice(context),
      );

  static kAdviceTextStyleDark(context) => TextStyle(
        color: kPresentTheme.accentColor,
        fontSize: 18.0 * adaptFontsForSmallDevice(context),
        fontStyle: FontStyle.italic,
      );

  static kHintTextStyle(context) => TextStyle(
        fontStyle: FontStyle.italic,
        color: Color(0x88004752),
      );

  static kTextFieldPadding(context) => EdgeInsets.fromLTRB(
        6.w, //* adaptForSmallDevice(context),
        1.h, //* adaptForSmallDevice(context),
        8.w, //* adaptForSmallDevice(context),
        1.h, //* adaptForSmallDevice(context),
      );

  static kDefaultPaddingAllSame(context) => EdgeInsets.all(
        1.h, //* adaptForSmallDevice(context)
      );

  static kDefaultHorizontalSymmetricPadding(context) =>
      EdgeInsets.symmetric(horizontal: 2.w);

  static kInputTextStyle(context) => TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.bold,
      color: kPresentTheme.accentColor);

  static kAdaptedTopPadding(context, double value) =>
      EdgeInsets.only(top: value);

  static kAdaptedBottoemPadding(context, double value) =>
      EdgeInsets.only(bottom: value * adaptForSmallDevice(context));
  static kAdaptedLeftPadding(context, double value) =>
      EdgeInsets.only(left: value * adaptForSmallDevice(context));
  static kAdaptedRightPadding(context, double value) =>
      EdgeInsets.only(right: value * adaptForSmallDevice(context));

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


  /// botttom Navigation tab used accross all the screen ..
  ///
  ///
  static List<BottomNavigationBarItem>  bottomTabs = [BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.bullseye,size: 15.sp,),
                  label: 'Goals',


                ),
                  BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.chartLine,size: 15.sp,),
                    label: 'Investments',
                  ),
                  BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.chartPie, color: kPresentTheme.accentColor,size: 15.sp,),
                    label: 'Dashboard',

                  ),
                  BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.calculator,size: 15.sp,color: Colors.orange,),
                      label: 'SIP Calculator'
                  ),];
}


