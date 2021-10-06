

import 'package:dhanrashi_mvp/components/buttons.dart';
import 'package:dhanrashi_mvp/data/user_access.dart';
import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/custom_card.dart';
import 'components/custom_scaffold.dart';
import 'components/constants.dart';
import 'dashboard.dart';
import 'empty_page_inputs.dart';
import 'models/profile.dart';
import 'profiler.dart';
import 'models/user_data_class.dart';
import 'data/profile_access.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'components/utilities.dart';

class ProfilerOptionPage extends StatefulWidget {
  //const ProfilerOptionPage({Key? key}) : super(key: key);

  final  currentUser;

  ProfilerOptionPage({required this.currentUser}){

   // currentUserName = currentUser.whenComplete(() => null)
   // print(currentUser.user!.email);
  }

  @override
  _ProfilerOptionPageState createState() => _ProfilerOptionPageState();
}

class _ProfilerOptionPageState extends State<ProfilerOptionPage> {


  bool isComplete = false;
  bool isSubmitted = false;
  final String currentUserName = "";
  late DRProfileAccess profileAccess;
  late FirebaseFirestore fireStore;

  @override
  void initState() {
    // TODO: implement initState
    isSubmitted = false;
    super.initState();
    future:Firebase.initializeApp().whenComplete(() {
      fireStore =  FirebaseFirestore.instance;
      profileAccess = DRProfileAccess(fireStore, widget.currentUser);
    });
  }


  Future _save(Profile profile,) async {
    DateTime currentPhoneDate = DateTime.now();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print('from _save in profile: ${profile.firstName}');
    await fireStore.collection('pjdhan_users').add({
      'email': widget.currentUser.email,
      'Uid': widget.currentUser.uid,
      'first_name': profile.firstName,
      'last_name': profile.lastName,
      'image_source':profile.profileImage,
      'DOB': profile.DOB,
      'income': profile.incomeRange,


      'created_dts': Timestamp.fromDate(currentPhoneDate),
      'update_dts': Timestamp.fromDate(currentPhoneDate),
      'user_status': 'Active',
    }).whenComplete((){
      setState((){
        isComplete = true;
        prefs.setBool('session_active', true);
        prefs.setString('user_id',widget.currentUser.uid);
        prefs.setString('email', widget.currentUser.email!);

        prefs.setString('f_name', profile.firstName);
        prefs.setString('l_name', profile.lastName);
        prefs.setString('dob', profile.DOB.toString());

        prefs.setString('income', profile.incomeRange);
        prefs.setString('doc_id', profile.docId??'');
        prefs.setString('image', profile.profileImage);
      });
      Navigator.push(context,
          MaterialPageRoute(builder: (context) =>
              EmptyPage(currentUser: profile,message:'Well we will try to  make out something from nothing' ,messageColor: Colors.amber,)));
    }).catchError((onError){

    });


  }



  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      currentUser: this.widget.currentUser,
      child: isSubmitted ?  Image.asset(circularProgressIndicator, scale: 5) : Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [
          Padding(
            padding: const EdgeInsets.only(top:8,left: 18,right: 18, bottom: 8.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(


                  ),
                  child: Image.asset('images/info.png',
                    height: 200,
                    width: 200,),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18, left: 8, right: 8,bottom: 8),
                  child: Text("Hey ! ${widget.currentUser!.email}  \nThanks for choosing us",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: kPresentTheme.accentColor,
                  )
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text("Looks like we dont know much of you.",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: kPresentTheme.accentColor,
                      )
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 28),
            child: Text("Knowing you more, will help us to help you more. How about getting some information about you ?",
              style: TextStyle(
                fontSize: 20.0,
                color: kPresentTheme.accentColor,
              ),
            ),
          ),

           Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:  CommandButton(
                      textSize: 18,
                      textColor: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                      buttonColor: kPresentTheme.alternateColor,
                      buttonText: "OK",
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) => ProfilerPage(currentUser: this.widget.currentUser,),
                        )
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:  CommandButton(
                      textSize: 18,
                      buttonColor: kPresentTheme.accentColor,
                      textColor: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        buttonText: "No, I am not sharing",
                        onPressed: (){

                            Profile profile = Profile(
                              firstName: 'N/A',
                              lastName: 'N/A',
                              DOB:DateTime.now(),
                              incomeRange: 'N/A',
                              profileImage: 'images/profiles/profile_image0.png',
                              uid:this.widget.currentUser.uid,
                              email: this.widget.currentUser.email,
                            );

                            Future.any(
                                [
                                  _save(profile),
                                  Utility.timeoutAfter(sec: 10, onTimeout:(){
                                    if(!isComplete)
                                    Utility.showErrorMessage(context, Utility.messages['timed_out']!);
                                  }),
                                ]
                            );

                        }, ),
                  )
                ]

              ),
            ),
          ),

          Center(child: Text("Worried about safety of your information?",
          style: DefaultValues.kAdviceTextStyleDark(context),)),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: LinkText(
                  linkText: "Click here to know our Privacy Policy",
                  type: LinkTextType.DARK,
                  onPressed: (){}),
            ),
          ),

        ],
      ),

    );
  }
}
