/// Copyright goes to Dhanrashi team

import 'dart:ui';

import 'package:dhanrashi_mvp/screens/intro.dart';
import 'package:dhanrashi_mvp/screens/login_screen.dart';
import 'package:dhanrashi_mvp/screens/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'components/constants.dart';
import 'components/vanish_keyboard.dart';
import 'models/profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


bool loginState = false;

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(


      statusBarIconBrightness: Brightness.dark));
      runApp(DhanrashiMVP(),


      );
}

class DhanrashiMVP extends StatefulWidget {

  @override
  _DhanrashiMVPState createState() => _DhanrashiMVPState();
}

class _DhanrashiMVPState extends State<DhanrashiMVP>  {

    late FirebaseAuth fireAuth ;
    late SharedPreferences prefs;
    late Profile? profile;
    bool? sessionActive;
    var userLoggedIn;


  @override
  void initState()  {
    // TODO: implement initState
    DefaultValues.mediaScreenHeight = window.physicalSize.height/window.devicePixelRatio;
    print('height :${DefaultValues.mediaScreenHeight}');
    super.initState();
    future: Firebase.initializeApp().whenComplete(() => fireAuth = FirebaseAuth.instance);

      getSession();

  }


  void getSession() async {
    prefs = await SharedPreferences.getInstance();
          setState(() {
            sessionActive = prefs.getBool('session_active');

            profile = Profile(
              firstName: prefs.getString('f_name') ??  '' ,
              lastName: prefs.getString('l_name') ??  '' ,
              DOB: DateTime.parse(prefs.getString('dob')?? '1900-01-01'),
              incomeRange: prefs.getString('income') ??  '' ,
              docId: prefs.getString('doc_id') ??  '' ,
              uid: prefs.getString('user_id') ??  '' ,
              email: prefs.getString('email') ??  '' ,
              profileImage: prefs.getString('image') ??  '' ,
            );

          });


  }



  @override
  Widget build(BuildContext context) {


 //print('Height ')



    return Sizer(
        builder: (context, orientation, deviceType){
          return VanishKeyBoard(
            onTap: (){

            },
            child: MaterialApp(
              home:Intro(nav:sessionActive != true ?  LoginScreen() : Dashboard(currentUser: profile) , ),// sessionActive != true ?  LoginScreen() : Dashboard(currentUser: profile), //
              //routes: ,
            ),
          );
    }
    );


  }
}



