

import 'package:dhanrashi_mvp/components/buttons.dart';
import 'package:dhanrashi_mvp/data/user_access.dart';
import 'package:dhanrashi_mvp/tnc.dart';
import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sizer/sizer.dart';
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



class ProfilerOptionPage extends StatelessWidget {

  final  currentUser;

  ProfilerOptionPage({
    required this.currentUser,
  }){

    // currentUserName = currentUser.whenComplete(() => null)
    // print(currentUser.user!.email);
  }

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      builder: Builder(
        builder: (context) {
          return ProfilerOptionPager(currentUser: this.currentUser);
        }
      ),
    );
  }
}







class ProfilerOptionPager extends StatefulWidget {
  //const ProfilerOptionPage({Key? key}) : super(key: key);

  final  currentUser;

  ProfilerOptionPager({required this.currentUser}){

   // currentUserName = currentUser.whenComplete(() => null)
   // print(currentUser.user!.email);
  }

  @override
  _ProfilerOptionPagerState createState() => _ProfilerOptionPagerState();
}

class _ProfilerOptionPagerState extends State<ProfilerOptionPager> {


  bool isComplete = false;
  bool isSubmitted = false;
  final String currentUserName = "";
  late DRProfileAccess profileAccess;
  late FirebaseFirestore fireStore;

  GlobalKey _helpSCKey = GlobalKey();
  GlobalKey _menuSCKey = GlobalKey();
  GlobalKey _showCaseKey1 = GlobalKey();
  GlobalKey _showCaseKey2 = GlobalKey();
  GlobalKey _firstSCKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    isSubmitted = false;
    super.initState();
    future:Firebase.initializeApp().whenComplete(() {
      fireStore =  FirebaseFirestore.instance;
      profileAccess = DRProfileAccess(fireStore, widget.currentUser);

    });

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ShowCaseWidget.of(context)!.startShowCase([_firstSCKey,_helpSCKey,_showCaseKey1,_showCaseKey2,]);
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
              EmptyPage(currentUser: profile,message:'Well you can always change the profile later' ,messageColor: Colors.amber,)));
    }).catchError((onError){

    });


  }



  @override
  Widget build(BuildContext context) {




    return CustomScaffold(
          //  helpSCKey: _helpSCKey,
            menuSCKey: _menuSCKey,
            // helper: (){
            //   ShowCaseWidget.of(context)!.startShowCase([_showCaseKey1,_showCaseKey2,_menuSCKey,_helpSCKey]);
            // },
            rightButton: Showcase(

              key: _helpSCKey,
              description:' Click here to get tour tips at any time',
              shapeBorder: CircleBorder(),
              overlayPadding: EdgeInsets.all(4),
              child: IconButton(icon: Icon(Icons.help),
                iconSize: 20.sp,
                onPressed: (){
                  ShowCaseWidget.of(context)!.startShowCase([_firstSCKey,_showCaseKey1,_showCaseKey2,_helpSCKey]);
                },),
            ),
            currentUser: this.widget.currentUser,
            child: isSubmitted ?  Image.asset(kPresentTheme.progressIndicator, scale: 3) : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [
                Container(height: 10, width: double.infinity,),
                Padding(
                  padding:  EdgeInsets.only(top: 0.h, left: 1.w, right: 1.w,bottom: 3.h),
                  child: Center(
                    child: Showcase.withWidget(
                      key: _firstSCKey,
                      height: 200,
                      width: double.infinity,
                      container: Center(
                        child: Container(
                            child:Column  (
                             // crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Center(child: Text('Welcome', style: TextStyle(fontSize: 35.sp,fontWeight: FontWeight.bold, color: Colors.white),)),
                                  Text('Take a tour of this app', style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold, color: Colors.white),),
                                  Text('Tap any where on the screen to begin', style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold, color: Colors.white),),
                                ]
                            )

                        ),
                      ),
                      child: Text("",
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: kPresentTheme.accentColor,
                          )
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:1.h,left: 4.w,right: 4.w, bottom: 1.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(


                        ),
                        child: Image.asset('images/info.png',
                          height: 25.h,
                          width: 100.w,),
                      ),


                      Padding(
                        padding: EdgeInsets.only(top: 1.h),
                        child: Text("Update your profile now.",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: kPresentTheme.accentColor,
                            )
                        ),
                      )
                    ],
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 6.w),
                //   child: Text("",
                //     style: TextStyle(
                //       fontSize: 16.sp,
                //       color: kPresentTheme.accentColor,
                //     ),
                //   ),
                // ),

                 Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Padding(
                          padding: EdgeInsets.only(top:1.h, left:2.w, bottom: 1.h,right: 2.w),
                          child:  Showcase(
                            key:_showCaseKey1,
                            description: 'Click here to Update your profile',
                            shapeBorder: CircleBorder(),
                            overlayPadding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 8),
                            child: CommandButton(
                              textSize: 14.sp,
                              textColor: Colors.black,
                              borderRadius: BorderRadius.circular(20),
                              buttonColor: kPresentTheme.alternateColor,
                              buttonText: "Update profile",
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
                        ),
                        Center(
                          // padding: EdgeInsets.only(top:1.h, left:2.w, bottom: 1.h,right: 2.w),
                          child:  Showcase(
                            key:_showCaseKey2,
                            description: 'Click here to cancel',
                            shapeBorder: CircleBorder(),
                            overlayPadding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 8),
                            child: LinkText(
                              displaySize: 14.sp,
                              //buttonColor: kPresentTheme.influenceColors[0],
                              // textColor: Colors.white,
                                type: LinkTextType.DARK,
                                linkText: "Skip to continue",
                                onPressed: (){

                                    Profile profile = Profile(
                                      firstName: 'N/A',
                                      lastName: 'N/A',
                                      DOB:DateTime.now(),
                                      incomeRange: 'N/A',
                                      profileImage: 'question.png',
                                      uid:this.widget.currentUser.uid,
                                      email: this.widget.currentUser.email,
                                    );

                                    Future.any(
                                        [
                                          _save(profile),
                                          Utility.timeoutAfter(sec: 10, onTimeout:(){
                                            if(!isComplete)
                                            Utility.showErrorMessage(context, DefaultValues.messages['timed_out']!);
                                          }),
                                        ]
                                    );

                                }, ),
                          ),
                        )
                      ]

                    ),
                  ),
                ),

                Center(child: Text("",
                style: DefaultValues.kAdviceTextStyleDark(context),)),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom:48.0),
                    child: LinkText(
                        linkText: "Privacy Policy",
                        displaySize: 14.sp,
                        type: LinkTextType.DARK,
                        onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TnC(),
                              )
                          );
                        }),
                  ),
                ),

              ],
            ),

          );

  }
}
