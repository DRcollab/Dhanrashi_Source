/// This code is written by Shubhadeep

import 'package:dhanrashi_mvp/components/settings_sheet.dart';
import 'package:dhanrashi_mvp/dashboard.dart';
import 'package:dhanrashi_mvp/data/user_access.dart';
import 'package:dhanrashi_mvp/goal_input.dart';
import 'package:dhanrashi_mvp/investmentinput.dart';
import 'package:dhanrashi_mvp/main.dart';
import 'package:dhanrashi_mvp/profile_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stacked/stacked_annotations.dart';


import '../login_screen.dart';

class MenuDrawer extends StatefulWidget {
 // const MenuDrawer({Key? key}) : super(key: key);
 late final currentUser;


  MenuDrawer({this.currentUser});

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
          DrawerHeader(

            child: Stack(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Image.asset('images/goldsrain.png'),
                CircleAvatar(
                  radius: 40,backgroundColor: kPresentTheme.accentColor,
                  backgroundImage: AssetImage(userHasProfile  ? widget.currentUser.profileImage: 'images/profiles/question.png'),
                ),
                Align(
                    alignment: Alignment.topRight,

                    child: Text('Dhanrashi', style:DefaultValues.kH1(context),)),
                Align(
                    alignment: Alignment.bottomLeft,

                    child: widget.currentUser!=null ? Padding(
                      padding: const EdgeInsets.all(8.0),
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
                  padding: EdgeInsets.only(left:8, top:80),
                  child: Text(userHasProfile ? '${widget.currentUser.firstName} ${widget.currentUser.lastName}'
                      :'', style: DefaultValues.kH2(context),),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: kPresentTheme.alternateColor,
            ),


          ),
          Flexible(
            child: Container(
              child: ListView(
                children: [


                  ListTile(
                    //contentPadding: EdgeInsets.all(10),
                    leading: FaIcon(FontAwesomeIcons.userFriends,size: 30,color:kPresentTheme.accentColor, ),
                    title: Text('Update profile' ,style:DefaultValues.kNormal2(context), ),
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              ProfileView(currentUser: widget.currentUser,)));
                    }
                    ,

                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.chartPie,size: 30,color:kPresentTheme.accentColor),
                    title: Text('Go to Dashboard', style: DefaultValues.kNormal2(context)),
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              Dashboard(currentUser: widget.currentUser,)));
                    },
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.plus,size: 30,color:kPresentTheme.accentColor),
                    title: Text('Add Investments', style: DefaultValues.kNormal2(context)),
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              InvestmentInputScreen(currentUser: widget.currentUser,)));
                    },
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.bullseye, size: 30,color:kPresentTheme.accentColor),
                    title: Text('Add Goals', style: DefaultValues.kNormal2(context)),
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              GoalsInputScreen(currentUser: widget.currentUser,)));
                    },
                  ),

                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wrench, size: 30,color:kPresentTheme.accentColor),
                    title: Text('Settings', style: DefaultValues.kNormal2(context)),
                    onTap: (){
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                              child: SettingSheet(

                                // titleMessage: name,
                                // investedAmount: 10,
                                // investmentDuration: 10,
                                // expectedRoi: 12,
                                // imageSource: 'images/products.png',

                              ),
                            ),
                          ));

                    },
                  ),

                  Container(height: 2,width: double.infinity,color: Colors.black12,),
                  SizedBox(height: 10,width: double.infinity,),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.calculator, size: 30,color:kPresentTheme.accentColor),
                    title: Text('SIP Calculator', style: DefaultValues.kNormal2(context)),
                  ),
                ],
              ),
            ),
          ),
          Container(
              child: ListTile(
                leading:Icon(Icons.logout,size: 35,color:kPresentTheme.accentColor),
                title: Text('Logout',style: DefaultValues.kNormal2(context)),
               enabled: widget.currentUser!=null,
                onTap: () async {
                  setState(() {
                   // currentUser.
                    fireAuth.signOut();
                    print(widget.currentUser);
                    //userLoggedIn = false;
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
