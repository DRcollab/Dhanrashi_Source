


import 'package:dhanrashi_mvp/components/custom_scaffold.dart';
import 'package:dhanrashi_mvp/data/profile_access.dart';
import 'package:dhanrashi_mvp/data/user_access.dart';
import 'package:dhanrashi_mvp/empty_page_inputs.dart';
import 'package:dhanrashi_mvp/profiler.dart';
import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';
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

class ConfirmationPage extends StatefulWidget {


  Collector collector;
  var currentUser;
  UserData currentUserProfile = UserData.create();
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


  var _userHandler = UserHandeler(userTable, userProfileTable);
  var dobController = TextEditingController();
  var incomeController  = TextEditingController();
  late FirebaseFirestore fireStore;
  late DRProfileAccess profileAccess;


  @override
  void initState() {
    // TODO: implement initState
    Collector profileCollector = widget.collector;
    future:Firebase.initializeApp().whenComplete(() {
      fireStore =  FirebaseFirestore.instance;
      profileAccess = DRProfileAccess(fireStore, widget.currentUser);
    });
    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    // print(widget.collector.dateOfBirth);
    // print(widget.collector);
    // print(widget.collector.dateOfBirth);

    double age = (widget.collector.dateOfBirth.difference(DateTime.now()).inDays/365);

    String ageAsString = age.ceil().toString();

    return CustomScaffold(
      currentUser: widget.currentUser,
      child: Container(

        child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,

            children : [

              Image.asset('images/confirmed.png',
                height: 25.h,
                width: 100.w,

              ),
              Padding(
                padding:  EdgeInsets.only(left:2.w, bottom: 0),
                child: Text(" Confirm your entries", style:DefaultValues.kH1(context),),
              ),
              Padding(
                padding: EdgeInsets.only(left:4.w, top:0),
                child: Text(widget.currentUser.email, style:DefaultValues.kNormal2(context),),
              ),
              Column(
                children: [
                  Band(
                    //toggleBandState: this.bandClickCallBack,
                    headingChild: Icon(Icons.drive_file_rename_outline, color: kPresentTheme.alternateColor,),
                    title: "Name",
                    text: widget.collector.fName.text,
                    subText: "",
                    controller: widget.collector.fName,
                    buttonIcon:Icons.edit,
                    alternateIcon : Icons.subdirectory_arrow_right,


                  ),
                  Band(
                    //toggleBandState: this.bandClickCallBack,
                    headingChild: Icon(Icons.drive_file_rename_outline,color: kPresentTheme.alternateColor),
                    title: "Last Name",
                    text: widget.collector.lName.text,
                    controller: widget.collector.lName,
                    subText: "",
                    buttonIcon:   Icons.edit ,
                    alternateIcon:  Icons.subdirectory_arrow_right,



                  ),

                  Band(

                    controller: dobController,
                    headingChild: Icon(Icons.drive_file_rename_outline,color: kPresentTheme.alternateColor),
                    title: "Date of Birth",
                    text: '${widget.collector.dateOfBirth.day}/${widget.collector.dateOfBirth.month}/${widget.collector.dateOfBirth.year}',


                    subText: 'Age:${ageAsString} years',
                    buttonIcon:  Icons.edit ,
                   alternateIcon: Icons.subdirectory_arrow_right,

                  ),
                  Band(

                    controller: incomeController,
                    headingChild: Icon(Icons.drive_file_rename_outline, color: kPresentTheme.alternateColor),
                    title: "Annual Income",
                    text:  widget.collector.annualIncome.toString(),
                    subText: "",
                    buttonIcon:   Icons.edit ,
                    alternateIcon: Icons.subdirectory_arrow_right,

                  ),

                ],
              ),

          Padding(
            padding:  EdgeInsets.only(left:4.w, right: 4.w, top: 1.h,),
            child: CommandButton(
              textColor: Colors.white,
              textSize: 12.sp,
              //icon:Icons.save,
              borderRadius: BorderRadius.circular(20),
              buttonText: widget.isItForUpdate ? "Add User Details" : 'Update User Profile',
              buttonColor: kPresentTheme.accentColor,

              onPressed:(){

                /// on pressing this button data will be saved in database ...
                setState(() {
                  Profile profile = Profile(
                    firstName: widget.collector.fName.text,
                    lastName: widget.collector.lName.text,
                    DOB:widget.collector.dateOfBirth,
                    incomeRange: widget.collector.annualIncome.toString(),
                    uid:widget.currentUser.uid,
                    email: widget.currentUser.email,
                    profileImage: widget.collector.profileImage,
                  );

                 profileAccess.storeProfile(profile);


                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EmptyPage(currentUser: widget.currentUser,)));
                });

              },
            ),
          ),

             widget.isItForUpdate ? Padding(
                padding:  EdgeInsets.only(left:4.w, right: 4.w, top: 1.h,),
                child: CommandButton(
                  textColor: Colors.white,
                  textSize: 12.sp,
                  //icon:Icons.save,
                  borderRadius: BorderRadius.circular(20),
                  buttonText:  'OOps I changed my mind ',
                  buttonColor: kPresentTheme.accentColor,

                  onPressed:(){

                    /// on pressing this button data will be saved in database ...

                    Navigator.pop(context);

                  },
                ),
              ) : SizedBox(),

            ]
        ),



      ),
    );
  }
}