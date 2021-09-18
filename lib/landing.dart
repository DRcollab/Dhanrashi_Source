import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhanrashi_mvp/components/custom_scaffold.dart';
import 'package:dhanrashi_mvp/dashboard.dart';
import 'package:dhanrashi_mvp/data/profile_access.dart';
import 'package:dhanrashi_mvp/main.dart';
import 'package:dhanrashi_mvp/profiler_option_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'models/profile.dart';


class Landing extends StatefulWidget {

  var currentUser;

  Landing({this.currentUser});

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  late FirebaseFirestore fireStore;

  late DRProfileAccess profileAccess;

  Profile profile = Profile.create();


  // _fetchProfile() async {
  //
  //   try{
  //     profile = await profileAccess.fetchProfile().whenComplete(() {
  //       print('Profile pf : ${profile.firstName}');
  //
  //
  //     });
  //   }catch(e){
  //     print(' the follwing error found...... @@@@ ${widget.currentUser.email}');
  //     print(e.toString());
  //   }
  //
  //
  // }

  Future fetchProfile() async {

   // late Profile profile;

    try {
      fireStore.collection('pjdhan_users').where(
          'Uid', isEqualTo: widget.currentUser.uid)
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((f) {
          String email = f.get('email');
          String userID = f.get('Uid');
          String docID = fireStore
              .collection('pjdhan_users')
              .doc()
              .id;

          String firstName = f.get('first_name');
          String lastName = f.get('last_name');
          Timestamp dob = f.get('DOB');
          String incomeRange = f.get('income');

          setState(() {
            profile = Profile(
              firstName: firstName,
              lastName: lastName,
              DOB: dob.toDate(),
              incomeRange: incomeRange,
              docId: docID,
            );
          });



        });
      });
      //return profile;
    }catch(e){
      print('This is the error : -> $e');
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   future: Firebase.initializeApp().whenComplete(() {
      fireStore = FirebaseFirestore.instance;
      profileAccess = DRProfileAccess(fireStore, widget.currentUser);

      //profile = await profileAccess.fetchProfile();
      fetchProfile();
      //     .whenComplete((){
      //   if(profile.docId !=''){
      //     Navigator.pop(context);
      //     Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => Dashboard(currentUser: widget.currentUser,)));
      //   }
      //   else{
      //     Navigator.pop(context);
      //     Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => ProfilerOptionPage(currentUser: widget.currentUser,)));
      //   }
      //
      // });



    });

  }


  @override
  Widget build(BuildContext context) {

      Future.delayed( Duration(seconds: 30));

        if(profile.docId !=''){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>
                  Dashboard(currentUser: widget.currentUser,)));
        }
        else{
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>
                  ProfilerOptionPage(currentUser: widget.currentUser,)));
        }



    return CustomScaffold(
        child: Container(
          child: Column(
            children: [
              Text(widget.currentUser.email),
              Text(profile.docId! ),
            ],
          ),


        )

    );
  }
}
