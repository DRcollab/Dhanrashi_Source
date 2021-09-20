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
import 'package:provider/provider.dart';
import 'components/theme_class.dart';
import 'data/filemanagr_class.dart';
import 'data/user_access.dart';
import 'investmentinput.dart';
//import 'goalinput.dart';

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

class _DhanrashiMVPState extends State<DhanrashiMVP> {

    late FirebaseAuth fireAuth ;
    var userLoggedIn;
  // late FirebaseFirestore firestore;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    future: Firebase.initializeApp().whenComplete(() => fireAuth = FirebaseAuth.instance);




  }


  void _login() async {
  var currentUser=DRUserAccess(fireAuth);

   // var loggedInUser = await userAccess.authUser('subhaaspa@gmail.com','shubha123');

    if(fireAuth.currentUser!=null){

      userLoggedIn = true;
    }
    else{

      userLoggedIn = false;
    }
    print(loginState);
  }


  @override
  Widget build(BuildContext context) {
    //fireAuth = FirebaseAuth.instance;

   // _login();


   // context.read<FileController>().readSettings();
  // kPresentTheme = context.select((FileController controller) => controller.settings !=null ? controller.settings.theme:kPresentTheme);
    return MaterialApp(
      title: 'Flutter Demo',
   //    routes: {
   //      '/': (context) => LoginPage(),
   //      '/profiler_opt': (context) => ProfilerOptionPage(currentUser: currentUser,),
   //      '/profiler': (context) => ProfilerPage(currentUser: currentUser),
   // //     '/profiler_confirm':(context) => ConfirmationPage(collector: collector, currentUser: currentUser)
   //    },

      //home:ProfilerPage(currentUser: currentUser),
      //
     // home: !userLoggedIn ? LoginPage() : Dashboard(currentUser: currentUser),
      home:LoginScreen(),
     // home: InvestmentInputScreen(currentUser: currentUser,),
    );
  }
}



