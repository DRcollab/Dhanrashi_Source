
import 'package:dhanrashi_mvp/data/global.dart';
import 'package:dhanrashi_mvp/login_screen.dart';
import 'package:dhanrashi_mvp/dashboard.dart';
import 'package:dhanrashi_mvp/testing.dart';
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

   // print( DefaultValues.textShortFormat.format(10000000000));



    return Sizer(
        builder: (context, orientation, deviceType){
          return VanishKeyBoard(
            onTap: (){

            },
            child: MaterialApp(
              home:  sessionActive != true ?  LoginScreen() : Dashboard(currentUser: profile),

            ),
          );
    }
    );


  }
}



