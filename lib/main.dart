import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhanrashi_mvp/confirmation_page.dart';
import 'package:dhanrashi_mvp/login_screen.dart';
import 'package:dhanrashi_mvp/models/user_data_class.dart';
import 'package:dhanrashi_mvp/empty_page_inputs.dart';
import 'package:dhanrashi_mvp/dashboard.dart';
import 'package:dhanrashi_mvp/components/on_error_screen.dart';
//import 'package:dhanrashi_mvp/goalinput.dart';
import 'package:dhanrashi_mvp/profiler_option_page.dart';
import 'package:dhanrashi_mvp/sip_calculator.dart';
import 'package:dhanrashi_mvp/test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'components/theme_class.dart';
import 'data/filemanagr_class.dart';
import 'data/user_access.dart';
import 'investmentinput.dart';
//import 'goalinput.dart';
import 'components/vanish_keyboard.dart';

import 'models/profile.dart';
import 'network/connectivity_checker.dart';
import 'profiler.dart';
import 'signup_page.dart';

import 'package:flutter/material.dart';
//import 'goalinput.dart';
import 'investmentinput.dart';

import 'components/constants.dart';
import 'package:dhanrashi_mvp/goal_input.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//late DRUserAccess currentUser; //UserData('', '_fName', '_lName', '_dob', '_income');

bool loginState = false;

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //  statusBarColor: Colors.transparent,

      statusBarIconBrightness: Brightness.dark));
      runApp(DhanrashiMVP(),

          // MultiProvider(
          //     providers: [ChangeNotifierProvider(create: (_)=>FileController())],
          //     child:  DhanrashiMVP(),
          // )


      );
}

class DhanrashiMVP extends StatefulWidget {
  // late FirebaseAuth fireAuth ;
  // late FirebaseFirestore firestore;


  // This widget is the root of your application.



  @override
  _DhanrashiMVPState createState() => _DhanrashiMVPState();
}

class _DhanrashiMVPState extends State<DhanrashiMVP>  {

    late FirebaseAuth fireAuth ;
    late SharedPreferences prefs;
    late Profile? profile;
    bool? sessionActive;
    var userLoggedIn;
  // late FirebaseFirestore firestore;

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    future: Firebase.initializeApp().whenComplete(() => fireAuth = FirebaseAuth.instance);

      getSession();

  }


  void getSession() async {
    prefs = await SharedPreferences.getInstance();
          setState(() {
            sessionActive = prefs.getBool('session_active');
            print('Session Insside:  $sessionActive');
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



    print('Session: $sessionActive');

    return Sizer(
        builder: (context, orientation, deviceType){
          return VanishKeyBoard(
            child: MaterialApp(
              home:  sessionActive != true ?  LoginScreen() : Dashboard(currentUser: profile),

            ),
          );
    }
    );


  }
}



