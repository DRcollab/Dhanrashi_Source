/// This code is written by Shubhadee


import 'package:dhanrashi_mvp/screens/dashboard.dart';

import 'package:dhanrashi_mvp/screens/goal_input.dart';
import 'package:dhanrashi_mvp/screens/info_page.dart';
import 'package:dhanrashi_mvp/screens/investmentinput.dart';

import 'package:dhanrashi_mvp/screens/profile_view.dart';
import 'package:dhanrashi_mvp/screens/profiler.dart';
import 'package:dhanrashi_mvp/screens/sip_calculator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sizer/sizer.dart';


import '../screens/login_screen.dart';

class MenuDrawer extends StatefulWidget {
 // const MenuDrawer({Key? key}) : super(key: key);
 late final currentUser;


  MenuDrawer({required this.currentUser});

  @override
  _MenuDrawerState createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  late FirebaseAuth fireAuth ;
  var userParticular;
  bool isUserLoggedIn = false;
  bool userHasProfile = false;
  bool profileEmpty = true;


  @override
  void initState()  {
    // TODO: implement initState

    super.initState();
    future: Firebase.initializeApp().whenComplete(() => fireAuth = FirebaseAuth.instance );

    if(widget.currentUser != null){
      isUserLoggedIn = true;
      if(widget.currentUser.firstName != 'N/A' && widget.currentUser.firstName !=''){
        userHasProfile = true;
      }
      else if(widget.currentUser.firstName == 'N/A') {
        userHasProfile = false;
        profileEmpty = false;
      }else{
        profileEmpty = true;
        userHasProfile = false;
      }

    }
    else{
      isUserLoggedIn = false;
      userHasProfile = false;
      profileEmpty = false;
    }

  }




  @override
  Widget build(BuildContext context) {

    
   // if()



    return Drawer(

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 35.h,
            child: DrawerHeader(

              child: Column(

                children: [

                  DefaultValues.setLogo(context),
                  Padding(
                    padding:  EdgeInsets.only(top: DefaultValues.screenHeight(context)>600 ?20.0:5),
                    child: CircleAvatar(
                      radius: 4.h,backgroundColor: kPresentTheme.accentColor,
                      backgroundImage: AssetImage(userHasProfile  ? widget.currentUser.profileImage: 'images/profiles/question.png'),
                    ),
                  ),



                  Align(
                    alignment: Alignment.bottomCenter,
                    //padding: const EdgeInsets.only(top:98.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.h),
                          child: Text(userHasProfile ? '${widget.currentUser.firstName} ${widget.currentUser.lastName}'
                              :'', style: DefaultValues.kH2(context),),
                        ),

                        widget.currentUser!=null ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.currentUser.email,
                              style:DefaultValues.kNormal2(context),
                            ),

                          ],
                        ) : SizedBox(),
                      ],
                    ),
                  ),

                ],
              ),
              decoration: BoxDecoration(
                color: kPresentTheme.alternateColor,

              ),


            ),
          ),
          Flexible(
            child: Container(
              child: ListView(
                children: [



                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.chartPie,size: 24.sp,color:kPresentTheme.accentColor),
                    title: Text(DefaultValues.menuItems['menu_dashboard']!, style: DefaultValues.kNormal2(context)),
                    subtitle:DefaultValues.screenHeight(context)>600 ? Text('Analyse your portfolio'):null,
                    enabled: widget.currentUser!=null,
                    onTap: (){
                      Navigator.pop(context);

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              Dashboard(currentUser: widget.currentUser,)));
                    },
                  ),
                  ListTile(
                    enabled: widget.currentUser!=null,
                    leading: FaIcon(FontAwesomeIcons.plus,size: 24.sp,color:kPresentTheme.accentColor),
                    title: Text(DefaultValues.menuItems['menu_inv']!, style: DefaultValues.kNormal2(context)),
                    //subtitle: DefaultValues.screenHeight(context)>600 ?Text('Add your investments by choosing from a list'):null,
                    onTap: (){
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              InvestmentInputScreen(currentUser: widget.currentUser,)));
                    },
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.plusCircle, size: 24.sp,color:kPresentTheme.accentColor),
                    title: Text(DefaultValues.menuItems['menu_goal']!, style: DefaultValues.kNormal2(context)),
                   // subtitle:DefaultValues.screenHeight(context)>600 ? Text('Add your goals by choosing from a list'):null,
                    enabled: widget.currentUser!=null,
                    onTap: (){
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              GoalsInputScreen(currentUser: widget.currentUser,)));
                    },
                  ),


                  // Container(height: 2,width: double.infinity,color: Colors.black12,),
                  SizedBox(height: 10,width: double.infinity,),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.calculator, size: 24.sp,color:kPresentTheme.accentColor),
                    title: Text(DefaultValues.menuItems['menu_sip_calc']!, style: DefaultValues.kNormal2(context)),
                    subtitle:DefaultValues.screenHeight(context)>600 ? Text(DefaultValues.messages['sip_calc_menusubtext']!):null,
                    onTap: (){
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              SIPCalculator(),),);
                    }
                    ,
                  ),
                  ListTile(
                    //contentPadding: EdgeInsets.all(10),
                    enabled: (widget.currentUser!=null && widget.currentUser.firstName!=''),
                    leading: FaIcon(FontAwesomeIcons.userFriends,size: 24.sp,color:kPresentTheme.accentColor, ),
                    title:  userHasProfile ? Text(DefaultValues.menuItems['menu_update_profile']! ,style:DefaultValues.kNormal2(context), )
                        : Text(DefaultValues.menuItems['menu_add_profile']! ,style:DefaultValues.kNormal2(context), ) ,
                    //  subtitle: DefaultValues.screenHeight(context)>600 ? Text('Change your name , date of birth and income'):null,
                    onTap: (){
                      if(widget.currentUser.firstName !='N/A') {
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>
                                ProfileView(currentUser: widget.currentUser,)));
                      }else{
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>
                                ProfilerPage(currentUser: widget.currentUser,isItForUpdate: false)));
                      }
                    }
                    ,

                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.idBadge, size: 24.sp,color:kPresentTheme.accentColor),
                    title: Text(DefaultValues.menuItems['menu_about']!, style: DefaultValues.kNormal2(context)),
                   // subtitle:DefaultValues.screenHeight(context)>600 ? Text(''):null,
                    onTap: (){
                      Navigator.pop(context);
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>
                            InfoPage(currentUser:widget.currentUser,),),);
                    }
                    ,
                  ),
                ],
              ),
            ),
          ),
          Container(
              child: ListTile(
                leading:Icon(Icons.logout,size: 26.sp,color:kPresentTheme.accentColor),
                title: Text(DefaultValues.menuItems['menu_logout']!,style: DefaultValues.kNormal2(context)),
               enabled: widget.currentUser!=null,
                onTap: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.remove('session_active');
                  prefs.remove('user_id');
                  prefs.remove('email');
                  prefs.remove('f_name');
                  prefs.remove('l_name');
                  prefs.remove('dob');
                  prefs.remove('doc_id');
                  prefs.remove('image');
                  prefs.remove('income');
                  setState(() {
                   // currentUser.
                    fireAuth.signOut();

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));

                  });


                },
              )
          )
        ],
      ),
    );
  }
}
