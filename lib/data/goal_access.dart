import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhanrashi_mvp/data/goal_db.dart';

class DRGoalAccess{
  final _firestore= FirebaseFirestore.instance;
  final _auth=FirebaseAuth.instance;
  Future storeGoal(
      List<GoalDB> listGoals,) async {
    DateTime currentPhoneDate = DateTime.now();
    for (var i = 0; i < listGoals.length; i++){
      try {
        await _firestore.collection('pjdhan_goal').add({
          'email': listGoals[i].email,
          'Uuid': listGoals[i].user,
          'Updated_id': 'system',
          'goal_name': listGoals[i].name,
          'goal_description': listGoals[i].description,
          'goal_duration': listGoals[i].goalDuration,
          'goal_amount': listGoals[i].goalAmount,
          'insert_dts': Timestamp.fromDate(currentPhoneDate),
          'update_dts': Timestamp.fromDate(currentPhoneDate),
          'status': 'Active',
        })
            .then((value)=>print("Goal added"));
      }
      catch (e) {
        print('Exception while inserting Goal $e');
      }
    }
  }
  Future<dynamic> updateGoal(
      List<GoalDB> listGoals,
      String docStatus
      ) async {
    DateTime currentPhoneDate = DateTime.now();
    for (var j = 0; j< listGoals.length; j++) {
      var docID= listGoals[j].goalDocumentID;
      try {
        _firestore.collection('pjdhan_goal').doc(listGoals[j].goalDocumentID).update({
          'email': listGoals[j].email,
          'Uuid': listGoals[j].user,
          'Updated_id': 'system',
          'goal_name': listGoals[j].name,
          'goal_description': listGoals[j].description,
          'goal_duration': listGoals[j].goalDuration,
          'goal_amount': listGoals[j].goalAmount,
          'insert_dts': Timestamp.fromDate(currentPhoneDate),
          'update_dts': Timestamp.fromDate(currentPhoneDate),
          'status': docStatus
        })
            .then((value)=>print("Goal updated"));
      }
      catch (e) {
        print( 'Exception while updating $docID $e');
      }
    }
  }
  Future fetchGoalbyUser(
      String user,
      ) async{
    List<GoalDB> listGoal=[];
    _firestore.collection('pjdhan_goal').where('Uuid', isEqualTo: user)
        .get()
        .then((QuerySnapshot snapshot){
      snapshot.docs.forEach((f) {
        String email=f.get('email');
        String userID=f.get('Uuid');
        String docID=_firestore.collection('pjdhan_goal').doc().id;
        String goalName=f.get('goal_name');
        String goalDescription=f.get('goal_description');
        double amount=f.get('goal_amount');
        double duration=f.get('goal_duration');
        listGoal.add(GoalDB(email,docID,userID,goalName,goalDescription,amount,duration));
      });
      return listGoal;
    }
    );
  }
}
