import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhanrashi_mvp/models/goal_db.dart';
import 'package:dhanrashi_mvp/models/goal.dart';
import 'package:dhanrashi_mvp/models/profile.dart';

class DRProfileAccess {
  late final _firestore;
  late final _currentUser;


  DRProfileAccess(FirebaseFirestore firestore, var currentUser) {
    this._firestore = firestore;
    this._currentUser = currentUser;
  }


 Future fetchProfile() async {

     Profile profile = Profile.create();

    try {
      _firestore.collection('pjdhan_users').where(
          'Uid', isEqualTo: _currentUser.uid)
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((f) {
          String email = f.get('email');
          String userID = f.get('Uid');
          String docID = _firestore
              .collection('pjdhan_users')
              .doc()
              .id;

          String firstName = f.get('first_name');
          String lastName = f.get('last_name');
          Timestamp dob = f.get('DOB');
          String incomeRange = f.get('income');

           profile =   Profile(
            firstName: firstName,
            lastName: lastName,
            DOB: dob.toDate(),
            incomeRange: incomeRange,
             docId: docID,
          );
        });
      });
        return  profile;
    }catch(e){
      throw e;
      }
  }


  Future<dynamic> updateProfile(GoalDB goalDB, String docStatus) async {
    DateTime currentPhoneDate = DateTime.now();

    var docID = goalDB.goalDocumentID;
    try {
      _firestore.collection('pjdhan_users').doc(docID).update({
        'email': goalDB.email,
        'Uuid': goalDB.user,
        'Updated_id': 'system',
        'goal_name': goalDB.goal.name,
        'goal_description': goalDB.goal.description,
        'goal_duration': goalDB.goal.duration,
        'goal_amount': goalDB.goal.goalAmount,
        'insert_dts': Timestamp.fromDate(currentPhoneDate),
        'update_dts': Timestamp.fromDate(currentPhoneDate),
        'status': docStatus
      })
          .then((value) => print("Goal updated"));
    }
    catch (e) {
      print('Exception while updating $docID $e');
    }
  }



  Future storeProfile(Profile profile,) async {
    DateTime currentPhoneDate = DateTime.now();

    try {
      await _firestore.collection('pjdhan_users').add({
        'email': _currentUser.email,
        'Uid': _currentUser.uid,
        'first_name': profile.firstName,
        'last_name': profile.lastName,

        'DOB': profile.DOB,
        'income': profile.incomeRange,


      'created_dts': Timestamp.fromDate(currentPhoneDate),
      'update_dts': Timestamp.fromDate(currentPhoneDate),
      'user_status': 'Active',
      })
          .then((value) => print("Goal added"));
    }
    catch (e) {
      throw e;
    }
  }



}
