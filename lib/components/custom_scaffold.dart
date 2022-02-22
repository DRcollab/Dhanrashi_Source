import 'package:dhanrashi_mvp/data/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import '../screens/dashboard.dart';
import '../screens/goal_input.dart';

import '../screens/investmentinput.dart';
import '../screens/sip_calculator.dart';
import 'constants.dart';
import 'package:dhanrashi_mvp/components/menu_drawer_class.dart';
import 'package:connectivity/connectivity.dart';

class CustomScaffold extends StatefulWidget {
  Widget child;
  String title = '';
  Widget? trailing;
  late Widget foot;
  //Widget? bottomNavigationBar;
  int selectedBottomNavtab;
  bool showBottomNavBar = true;
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
    // this.bottomNavigationBar =  const SizedBox(
    //   height: 0,
    //   width: 0,
    // ),
   //this.currentUser,
    this.selectedBottomNavtab = 0,
    this.showBottomNavBar = true,
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

  late int _currentTabIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentTabIndex = widget.selectedBottomNavtab;





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
              child: widget.showBottomNavBar ? BottomNavigationBar(
                type: BottomNavigationBarType.fixed,

                currentIndex: _currentTabIndex,
                unselectedFontSize:  DefaultValues.screenHeight(context)<600? 8:12,
                onTap: (index){
                  setState(() {
                    _currentTabIndex = index;
                  });

                  switch(index){

                    case 0:
                    // Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GoalsInputScreen(currentUser: widget.currentUser,),
                        ),
                      );
                      break;
                    case 1:
                    //  Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InvestmentInputScreen(currentUser: widget.currentUser,),
                        ),
                      );
                      break;
                    case 2:
                    //  Navigator.pop(context);
                      print('index is $index');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Dashboard(currentUser: widget.currentUser,),
                        ),
                      );

                      break;
                    case 3:

                      print('index is $index');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SIPCalculator(currentUser: widget.currentUser,),
                        ),
                      );
                      break;
                  }
                },

                items: [
                  BottomNavigationBarItem(
                    icon: FaIcon(
                      FontAwesomeIcons.bullseye,
                      size: kScreenHeight >600 ? 15.sp : 10.sp,
                    ),
                    label: 'Goals',
                    tooltip: 'Goto add goal page',
                  ),
                  BottomNavigationBarItem(
                      icon: FaIcon(
                        FontAwesomeIcons.chartLine,
                        size: kScreenHeight >600 ? 15.sp : 10.sp,
                      ),
                      label: 'Investments',
                      tooltip: 'Goto add investment page'

                  ),
                  BottomNavigationBarItem(
                    icon: FaIcon(
                      FontAwesomeIcons.chartPie,
                      color: kPresentTheme.accentColor,
                      size: kScreenHeight >600 ? 15.sp : 10.sp,
                    ),
                    label: 'Dashboard',
                    tooltip: 'Goto dashboard',
                  ),
                  BottomNavigationBarItem(
                    icon: FaIcon(
                      FontAwesomeIcons.calculator,
                      size: kScreenHeight >600 ? 15.sp : 10.sp,
                      color: Colors.orange,
                    ),
                    label: 'SIP Calculator',
                    tooltip: 'Open SIP calculator',
                  ),
                ],
              ): SizedBox() ,


          ),
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
