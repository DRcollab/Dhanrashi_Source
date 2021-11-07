


import 'package:dhanrashi_mvp/components/custom_scaffold.dart';
import 'package:dhanrashi_mvp/components/work_done.dart';
import 'package:dhanrashi_mvp/dashboard.dart';
import 'package:dhanrashi_mvp/data/profile_access.dart';
import 'package:dhanrashi_mvp/data/user_access.dart';
import 'package:dhanrashi_mvp/empty_page_inputs.dart';
import 'package:dhanrashi_mvp/profile_view.dart';
import 'package:dhanrashi_mvp/profiler.dart';
import 'package:flutter/cupertino.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sizer/sizer.dart';
import 'models/profile_collector.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'components/constants.dart';
import 'components/band_class.dart';
import 'models/profile.dart';
import 'models/user_data_class.dart';
import 'components/buttons.dart';
import 'data/user_handler.dart';
import 'data/database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'components/utilities.dart';
import 'components/constants.dart';

class ConfirmationPage extends StatefulWidget {


  Collector collector; // defined in profile_collector.dart
  var currentUser;
   bool isItForUpdate = false;

  ConfirmationPage({
    required this.collector,
    required this.currentUser,
    this.isItForUpdate = false,
  });



  @override
  _ConfirmationPageState createState() => _ConfirmationPageState();
}


class _ConfirmationPageState extends State<ConfirmationPage> {

  late Profile profile;  // Used to store profile data of the user
  bool isComplete = false; // to see whether a task assign to async service is complete .. see _save and _update
  bool isSubmitted = false; // to see if any task has been assign
  bool isTimedOut = false;
  var dobController = TextEditingController();
  var incomeController  = TextEditingController();
  late FirebaseFirestore fireStore;
  late DRProfileAccess profileAccess;

  GlobalKey _showCaseKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    profile = Profile.create();
    Collector profileCollector = widget.collector;
    print('init statet confirmation page page:${widget.currentUser.profileImage}');
    isSubmitted = false;
    isComplete = false;
    isTimedOut = false;
    future:Firebase.initializeApp().whenComplete(() {
      fireStore =  FirebaseFirestore.instance;
      profileAccess = DRProfileAccess(fireStore, widget.currentUser);
    });
    super.initState();
  }



  Future _update(Profile profile) async {
    DateTime currentPhoneDate = DateTime.now();
    var docID = widget.currentUser.docId;
    profile.docId = docID;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print('profile _update:${widget.currentUser.profileImage}');
      fireStore.collection('pjdhan_users').doc(docID).update({
        'email': profile.email,
        'Uid': profile.uid,
        'first_name': profile.firstName,
        'last_name': profile.lastName,
        'image_source': profile.profileImage,
        'DOB':profile.DOB,
        'income': profile.incomeRange,

        'insert_dts': Timestamp.fromDate(currentPhoneDate),
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
          prefs.setString('image','${DefaultValues.directoryOfPhoto}/${profile.profileImage}');
          profile.profileImage = '${DefaultValues.directoryOfPhoto}/${profile.profileImage}';
        });

        Fluttertoast.showToast(
          msg:'Your profile updated  successfully',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        Navigator.pop(context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>
            widget.isItForUpdate ? Dashboard(currentUser: profile)
                : EmptyPage(currentUser: profile,message:'Great! Your profile is saved successfully',)));
      }).catchError((onError){
        Utility.showErrorMessage(context, onError.toString());
      });

  }


  Future _save(Profile profile,) async {
    DateTime currentPhoneDate = DateTime.now();
    SharedPreferences prefs = await SharedPreferences.getInstance();

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
         // prefs.setString('image', profile.profileImage);
          prefs.setString('image','${DefaultValues.directoryOfPhoto}/${profile.profileImage}');
          profile.profileImage = '${DefaultValues.directoryOfPhoto}/${profile.profileImage}';
        });




        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>
              widget.isItForUpdate ? Dashboard(currentUser: profile)
              : EmptyPage(currentUser: profile,message:'Great! Your profile is saved successfully',)));
      }).catchError((onError){
        Utility.showErrorMessage(context, onError.toString());
      }).then((DocumentReference docRefs){
          this.profile.docId = docRefs.id;
      });


  }




  @override
  Widget build(BuildContext context) {

    print('confirmation page:${widget.currentUser.profileImage}');
    double age = (widget.collector.dateOfBirth.difference(DateTime.now()).inDays/365);

    String ageAsString = age.ceil().toString();

    return ShowCaseWidget(
      builder : Builder(
        builder: (context) {
          return CustomScaffold(
            helper: (){
              ShowCaseWidget.of(context)!.startShowCase([_showCaseKey]);
            },
            currentUser: widget.currentUser,
            child: isSubmitted ? Center(
                child: Image.asset(kPresentTheme.progressIndicator, scale: 3),): Container(

              child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,

                  children : [

                    Image.asset('images/confirmed.png',
                      height: 25.h,
                      width: 80.w,

                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(left:2.w, bottom: 0),
                          child: Text(" Confirm Profile", style:DefaultValues.kH1(context),),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left:6.w, top:0,right: 4.w,bottom: 0.h),
                          child: Showcase(
                              key: _showCaseKey,
                              description:'change the entries from here',
                              shapeBorder: CircleBorder(),
                              overlayPadding: EdgeInsets.only (top:2,bottom:2,left:10,right: 10),
                              contentPadding: EdgeInsets.all(10),
                            child: CommandButton(
                                onPressed: (){


                                  var profile = Profile(
                                    firstName: widget.collector.fName.text,
                                    lastName: widget.collector.lName.text,
                                    DOB: widget.collector.dateOfBirth,
                                    incomeRange: widget.collector.annualIncome
                                        .toString(),
                                    uid: widget.currentUser.uid,
                                    email: widget.currentUser.email,
                                    profileImage: widget.collector.profileImage,

                                  );
                                  Navigator.pop(context);
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) =>
                                          ProfilerPage(currentUser: profile,isItForUpdate: false,)));
                                },
                                buttonColor: kPresentTheme.accentColor,
                                borderRadius: BorderRadius.circular(15),
                                buttonText: 'Edit',
                                textColor: kPresentTheme.alternateColor),
                          ),
                        ),
                      ],
                    ),


                    Padding(
                      padding:  EdgeInsets.only(top: 2.h,left: 2.w, right: 2.w),
                      child: Card(
                        child: Column(

                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.only(left:10.w),
                              visualDensity: VisualDensity.standard,

                              title: Text('First Name'),

                              subtitle: Text(widget.collector.fName.text, style: DefaultValues.kH2(context),),

                            ),
                            ListTile(
                              contentPadding: EdgeInsets.only(left:10.w),
                              visualDensity: VisualDensity.standard,
                              title: Text("Last Name"),

                              subtitle: Text(widget.collector.lName.text,style: DefaultValues.kH2(context)),




                            ),

                            ListTile(
                              dense: false,
                              visualDensity: VisualDensity.standard,
                              contentPadding: EdgeInsets.only(left:10.w),
                              title: Text("Date of Birth"),

                              subtitle: Text('${widget.collector.dateOfBirth.day}/${widget.collector.dateOfBirth.month}/${widget.collector.dateOfBirth.year} (Age:${ageAsString} years)',
                                  style: DefaultValues.kH2(context),
                              ),


                            ),
                            ListTile(

                              contentPadding: EdgeInsets.only(left:10.w),
                              visualDensity: VisualDensity.standard,
                              title: Text("Annual Income"),

                              subtitle: Text(widget.collector.annualIncome.toString(),style: DefaultValues.kH2(context)),


                            ),

                          ],
                        ),
                      ),
                    ),

                Padding(
                  padding:  EdgeInsets.only(left:20.w, right: 20.w, top: 1.h,),
                  child:CommandButton(
                    textColor: Colors.white,
                    textSize: 12.sp,
                    //icon:Icons.save,
                    borderRadius: BorderRadius.circular(20),
                    buttonText: !widget.isItForUpdate ? "Confirm" : 'Confirm',
                    buttonColor: kPresentTheme.accentColor,

                    onPressed:() {


                      /// on pressing this button data will be saved in database ...
                      setState(() {
                        this.isSubmitted = true;
                        this.profile = Profile(
                          firstName: widget.collector.fName.text,
                          lastName: widget.collector.lName.text,
                          DOB:widget.collector.dateOfBirth,
                          incomeRange: widget.collector.annualIncome.toString(),
                          uid:widget.currentUser.uid,
                          email: widget.currentUser.email,
                          profileImage: widget.collector.profileImage,

                        );

                        if(!widget.isItForUpdate){
                          Future.any(
                              [
                                _save(this.profile),
                                Utility.timeoutAfter(sec: 10, onTimeout:(){
                                  if(!isComplete){
                                    Utility.showErrorMessage(context, Utility.messages['timed_out']!);
                                  }
                                }),
                              ]
                          );
                        } else{
                          Future.any(
                              [
                                _update(this.profile),
                                Utility.timeoutAfter(sec: 10, onTimeout:(){
                                  if(!isComplete){
                                    Utility.showErrorMessage(context, Utility.messages['timed_out']!);
                                  }
                                }),
                              ]
                          );

                        }
                      });

                    },
                  ),
                ),

                   widget.isItForUpdate ? Padding(
                      padding:  EdgeInsets.only(left:20.w, right: 20.w, top: 0.h,),
                      child: CommandButton(
                        textColor: Colors.white,
                        textSize: 12.sp,
                        //icon:Icons.save,
                        borderRadius: BorderRadius.circular(20),
                        buttonText:  'Cancel ',
                        buttonColor: kPresentTheme.accentColor,

                        onPressed:(){
                          Navigator.pop(context);
                        },
                      ),
                    ) : SizedBox(),

                  ]
              ),



            ),
          );
        }
      ),
    );
  }
}