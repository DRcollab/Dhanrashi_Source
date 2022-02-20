import 'package:dhanrashi_mvp/data/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'constants.dart';
import 'package:dhanrashi_mvp/components/menu_drawer_class.dart';
import 'package:connectivity/connectivity.dart';

class CustomScaffold extends StatefulWidget {
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
    this.currentUser,
    this.foot = const SizedBox(
      height: 0,
      width: 0,
    ),
    this.bottomNavigationBar =  const SizedBox(
      height: 0,
      width: 0,
    ),
   //this.currentUser,
    this.allowToSeeBottom = false,
    this.helper,
    this.rightButton,
    this.leftButton,
    this.helpSCKey,
    this.menuSCKey,
  });

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: kPresentTheme.themeColor, //Color(0xffb5c210),
          systemNavigationBarIconBrightness: Brightness.dark,
          // systemNavigationBarColor: Colors.black,
        ),
        child: Scaffold(
          backgroundColor: kPresentTheme.themeColor,
          key: _scaffoldKey,
          resizeToAvoidBottomInset: this.widget.allowToSeeBottom,

          // backgroundColor: kPresentTheme.scaffoldColors[0],

          body: safeAreaWidgets(),

          drawer: MenuDrawer(
            currentUser: this.widget.currentUser,
          ),
          bottomNavigationBar: SizedBox(
              height: DefaultValues.screenHeight(context) < 600 ? 48 : 58,
              child: widget.bottomNavigationBar),
        ),
      ),
    );
  }

  Widget safeAreaWidgets() {
    return SafeArea(
      child: StreamBuilder<Object>(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData && snapshot.data != ConnectivityResult.none) {
              Global.internetAvailable = true;
            } else {
              Global.internetAvailable = false;
            }
            return Stack(
              children: [
                this.widget.child,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 2.w),
                      child: this.widget.leftButton == null
                          ? IconButton(
                              icon: Icon(
                                Icons.menu,
                              ),
                              onPressed: () {
                                _scaffoldKey.currentState!.openDrawer();
                              },
                            )
                          : this.widget.leftButton,
                    ),
                    Text(
                      this.widget.title,
                      style: DefaultValues.kH3(context),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 2.w),
                      child: this.widget.rightButton == null
                          ? IconButton(
                              icon: Icon(Icons.help),
                              iconSize: 20.sp,
                              onPressed: () {
                                widget.helper!();
                              },
                            )
                          : this.widget.rightButton,
                    ),
                  ],
                ),
                //),
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: this.widget.foot,
                ),
              ],
            );
          }),
    );
  }
}
