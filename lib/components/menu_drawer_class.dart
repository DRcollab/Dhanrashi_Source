/// This code is written by Shubhadee

import 'package:dhanrashi_mvp/components/settings_sheet.dart';
import 'package:dhanrashi_mvp/dashboard.dart';
import 'package:dhanrashi_mvp/data/global.dart';
import 'package:dhanrashi_mvp/data/user_access.dart';
import 'package:dhanrashi_mvp/goal_input.dart';
import 'package:dhanrashi_mvp/info_page.dart';
import 'package:dhanrashi_mvp/investmentinput.dart';
import 'package:dhanrashi_mvp/main.dart';
import 'package:dhanrashi_mvp/models/profile.dart';
import 'package:dhanrashi_mvp/profile_view.dart';
import 'package:dhanrashi_mvp/profiler.dart';
import 'package:dhanrashi_mvp/sip_calculator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sizer/sizer.dart';


import '../login_screen.dart';

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
   // print(widget.currentUser.profileImage);
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
            height: 30.h,
            child: DrawerHeader(

              child: Stack(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Image.asset('images/goldsrain.png'),
                  CircleAvatar(
                    radius: 4.h,backgroundColor: kPresentTheme.accentColor,
                    backgroundImage: AssetImage(userHasProfile  ? widget.currentUser.profileImage: 'images/profiles/question.png'),
                  ),
                  Align(
                      alignment: Alignment.topRight,

                      child: Text('Dhanrashi', style:DefaultValues.kH1(context),)),
                  Align(
                      alignment: Alignment.bottomLeft,

                      child: widget.currentUser!=null ? Padding(
                        padding:  EdgeInsets.all(2.w),
                        child: Row(
                          children: [
                            Text(
                              widget.currentUser.email,
                              style:DefaultValues.kNormal2(context),
                            ),

                          ],
                        ),
                      ) : SizedBox(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left:2.w, top:10.h),
                    child: Text(userHasProfile ? '${widget.currentUser.firstName} ${widget.currentUser.lastName}'
                        :'', style: DefaultValues.kH2(context),),
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
                    title: Text('Dashboard', style: DefaultValues.kNormal2(context)),
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
                    title: Text('Add Investments', style: DefaultValues.kNormal2(context)),
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
                    title: Text('Add Goals', style: DefaultValues.kNormal2(context)),
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
                    title: Text('SIP Calculator', style: DefaultValues.kNormal2(context)),
                    subtitle:DefaultValues.screenHeight(context)>600 ? Text('Dhanrashi SIP calculator. find how to plan on your investments'):null,
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
                    title:  userHasProfile ? Text('Update profile' ,style:DefaultValues.kNormal2(context), )
                        : Text('Add profile' ,style:DefaultValues.kNormal2(context), ) ,
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
                                ProfilerPage(currentUser: widget.currentUser,isItForUpdate: true)));
                      }
                    }
                    ,

                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.idBadge, size: 24.sp,color:kPresentTheme.accentColor),
                    title: Text('About', style: DefaultValues.kNormal2(context)),
                    subtitle:DefaultValues.screenHeight(context)>600 ? Text('Credits , where it is due'):null,
                    onTap: (){
                      Navigator.pop(context);
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>
                            InfoPage(),),);
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
                title: Text('Logout',style: DefaultValues.kNormal2(context)),
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
                    print(widget.currentUser.email);
                  });


                },
              )
          )
        ],
      ),
    );
  }
}
