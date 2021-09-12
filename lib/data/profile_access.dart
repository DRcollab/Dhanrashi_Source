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
    List<GoalDB> listGoal = [];
    try {
      _firestore.collection('pjdhan_goal').where(
          'Uuid', isEqualTo: _currentUser.uid)
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((f) {
          String email = f.get('email');
          String userID = f.get('Uuid');
          String docID = _firestore
              .collection('pjdhan_goal')
              .doc()
              .id;
          String goalName = f.get('goal_name');
          String goalDescription = f.get('goal_description');
          double amount = f.get('goal_amount');
          int duration = f.get('goal_duration');
          //double inflation = f.get('inflation');

          listGoal.add(
              GoalDB(
                email: email,
                goalDocumentID: docID,
                user: userID,
                goal: Goal(
                  name: goalName,
                  description: goalDescription,
                  goalAmount: amount,
                  duration: duration,
                  inflation: 4.5,
                ),
              )
          );
        });
        print('++++++++++++++++++++++++++++++');
        print(listGoal.length);
        if (listGoal.length > 0) {
          return listGoal;
        }
        else {
          return null;
        }
      }
      );
    } catch (e) {
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
