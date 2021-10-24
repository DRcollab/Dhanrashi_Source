/// This code is written by Shubhadeep

import 'package:dhanrashi_mvp/components/settings_sheet.dart';
import 'package:dhanrashi_mvp/dashboard.dart';
import 'package:dhanrashi_mvp/data/user_access.dart';
import 'package:dhanrashi_mvp/goal_input.dart';
import 'package:dhanrashi_mvp/investmentinput.dart';
import 'package:dhanrashi_mvp/main.dart';
import 'package:dhanrashi_mvp/models/profile.dart';
import 'package:dhanrashi_mvp/profile_view.dart';
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


  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    future: Firebase.initializeApp().whenComplete(() => fireAuth = FirebaseAuth.instance );


  }




  @override
  Widget build(BuildContext context) {

   // if()
    if(widget.currentUser != null){
      isUserLoggedIn = true;
      if(widget.currentUser.firstName != 'N/A'){
        userHasProfile = true;
      }
      else{
        userHasProfile = false;
      }
    }

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
                    //contentPadding: EdgeInsets.all(10),
                    enabled: widget.currentUser!=null,
                    leading: FaIcon(FontAwesomeIcons.userFriends,size: 24.sp,color:kPresentTheme.accentColor, ),
                    title: Text('Update profile' ,style:DefaultValues.kNormal2(context), ),
                    subtitle: DefaultValues.screenHeight(context)>600 ? Text('Change your name , date of birth and income'):null,
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              ProfileView(currentUser: widget.currentUser,)));
                    }
                    ,

                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.chartPie,size: 24.sp,color:kPresentTheme.accentColor),
                    title: Text('Dashboard', style: DefaultValues.kNormal2(context)),
                    subtitle:DefaultValues.screenHeight(context)>600 ? Text('It is your homepage where we find the analysis of your portfolio and can manage it'):null,
                    enabled: widget.currentUser!=null,
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              Dashboard(currentUser: widget.currentUser,)));
                    },
                  ),
                  ListTile(
                    enabled: widget.currentUser!=null,
                    leading: FaIcon(FontAwesomeIcons.plus,size: 24.sp,color:kPresentTheme.accentColor),
                    title: Text('Add Investments', style: DefaultValues.kNormal2(context)),
                    subtitle: DefaultValues.screenHeight(context)>600 ?Text('Add your investments by choosing from a list'):null,
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              InvestmentInputScreen(currentUser: widget.currentUser,)));
                    },
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.plusCircle, size: 24.sp,color:kPresentTheme.accentColor),
                    title: Text('Add Goals', style: DefaultValues.kNormal2(context)),
                    subtitle:DefaultValues.screenHeight(context)>600 ? Text('Add your goals by choosing from a list'):null,
                    enabled: widget.currentUser!=null,
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              GoalsInputScreen(currentUser: widget.currentUser,)));
                    },
                  ),

                  // ListTile(
                  //   enabled: widget.currentUser!=null,
                  //   leading: FaIcon(FontAwesomeIcons.wrench, size: 24.sp,color:kPresentTheme.accentColor),
                  //   title: Text('Settings', style: DefaultValues.kNormal2(context)),
                  //   onTap: (){
                  //     showModalBottomSheet(
                  //         isScrollControlled: true,
                  //         context: context,
                  //         builder: (context) => SingleChildScrollView(
                  //           child: Container(
                  //             padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  //             child: SettingSheet(
                  //
                  //               // titleMessage: name,
                  //               // investedAmount: 10,
                  //               // investmentDuration: 10,
                  //               // expectedRoi: 12,
                  //               // imageSource: 'images/products.png',
                  //
                  //             ),
                  //           ),
                  //         ));
                  //
                  //   },
                  // ),

                  Container(height: 2,width: double.infinity,color: Colors.black12,),
                  SizedBox(height: 10,width: double.infinity,),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.calculator, size: 24.sp,color:kPresentTheme.accentColor),
                    title: Text('SIP Calculator', style: DefaultValues.kNormal2(context)),
                    subtitle:DefaultValues.screenHeight(context)>600 ? Text('Dhanrashi SIP calculator. find how to plan on your investments'):null,
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              SIPCalculator(),),);
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

                 // if(fireAuth.currentUser == null){
                 //
                 // }

                },
              )
          )
        ],
      ),
    );
  }
}
