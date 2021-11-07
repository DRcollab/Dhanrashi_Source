
import 'package:dhanrashi_mvp/components/irregular_shapes.dart';
import 'package:dhanrashi_mvp/components/on_error_screen.dart';
import 'package:dhanrashi_mvp/data/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dhanrashi_mvp/components/menu_drawer_class.dart';
import 'package:dhanrashi_mvp/network/connectivity_checker.dart';
import 'package:connectivity/connectivity.dart';
import 'package:showcaseview/showcaseview.dart';

class CustomScaffold extends StatelessWidget {
  Widget child;
  String title = '';
  Widget? trailing;
  late Widget foot;
  Widget? bottomNavigationBar;
  var currentUser;
  //final Widget svg = Svg
  bool allowToSeeBottom = false;
  Function()? helper;
  Widget? rightButton;
  Widget? leftButton;
  GlobalKey? helpSCKey = GlobalKey(); // used for showcase for help
  GlobalKey? menuSCKey = GlobalKey(); // used for showcase for menu

  CustomScaffold({
    required this.child,
    this.title = '',
    this.trailing,
    this.foot = const SizedBox(height: 0,width: 0,),
    this.bottomNavigationBar = const  SizedBox(height: 0, width: 0,),
    this.currentUser,
    this.allowToSeeBottom = false,
    this.helper,
    this.rightButton,
    this.leftButton,
    this.helpSCKey,
    this.menuSCKey,
  });

  final  _scaffoldKey = GlobalKey<ScaffoldState>();
 // final _keyShowCase = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle(
         statusBarColor: kPresentTheme.themeColor,//Color(0xffb5c210),
          systemNavigationBarIconBrightness: Brightness.dark,
         // systemNavigationBarColor: Colors.black,
        ) ,

        child: Scaffold(

                  backgroundColor: kPresentTheme.themeColor,
                  key: _scaffoldKey,
                  resizeToAvoidBottomInset: this.allowToSeeBottom,

                 // backgroundColor: kPresentTheme.scaffoldColors[0],

                  body:  safeAreaWidgets(),


                  drawer: MenuDrawer(currentUser: this.currentUser, ),
                  bottomNavigationBar:bottomNavigationBar,
                ),

      ),
    );
  }

  Widget safeAreaWidgets(){
    return SafeArea(
      child: StreamBuilder<Object>(
          stream: Connectivity().onConnectivityChanged,
          builder: (context,
              AsyncSnapshot snapshot) {

            if( snapshot.hasData &&
                snapshot.data != ConnectivityResult.none){
              Global.internetAvailable = true;
            }else{
              Global.internetAvailable = false;
            }
            return Stack(
              children: [
                this.child,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left:2.w),
                      child: this.leftButton==null ? IconButton(icon: Icon(Icons.menu,),

                        onPressed: (){
                          _scaffoldKey.currentState!.openDrawer();
                        },):this.leftButton,
                    ),
                    Text(this.title, style: DefaultValues.kH3(context),),
                    Padding(
                      padding: EdgeInsets.only( right:2.w),
                      child: this.rightButton==null ? IconButton(icon: Icon(Icons.help),
                        iconSize: 20.sp,
                        onPressed: (){
                          helper!();
                      },):this.rightButton,
                    ),

                  ],
                ),
                //),
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: this.foot,
                ),
              ],
            );


          }
      ),
    );
  }


}




