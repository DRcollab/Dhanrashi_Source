/// This code is written by Arvind Ganesan  part of Dhanrashi_MVP project

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhanrashi_mvp/data/goal_db.dart';
import 'package:dhanrashi_mvp/data/investment_db.dart';

class DRInvestAccess{
  final _firestore= FirebaseFirestore.instance;
  final _auth=FirebaseAuth.instance;
  Future storeInvestment(
      List<InvestDB> listInvestments,) async {
    DateTime currentPhoneDate = DateTime.now();
    print(listInvestments[0].name);
    for (var i = 0; i < listInvestments.length; i++){
      try {
        print('i am here');
        await _firestore.collection('pjdhan_investment').add({
          'email': listInvestments[i].email,
          'Uuid': listInvestments[i].userID,
          'Updated_id': 'system',
          'investment_name': listInvestments[i].name,
          'currInvestAmt': listInvestments[i].currentInvestmentAmount,
          'annualInvestAmt': listInvestments[i].annualInvestmentAmount,
          'investRoI': listInvestments[i].investmentRoi,
          'investment_duration': listInvestments[i].investmentDuration,
          'insert_dts': Timestamp.fromDate(currentPhoneDate),
          'update_dts': Timestamp.fromDate(currentPhoneDate),
          'status': 'Active',
        })
            .then((value)=>print("Investment added"));
      }
      catch (e) {
        print('Exception while inserting Investment $e');
      }
    }
  }
  Future<dynamic> updateInvestment(
      List<InvestDB> listInvestment,
      String documentStatus,) async {
    DateTime currentPhoneDate = DateTime.now();
    for (var j = 0; j< listInvestment.length; j++) {
      var docID= listInvestment[j].investmentDocumentID;
      try {
        _firestore.collection('pjdhan_investment').doc(listInvestment[j].investmentDocumentID).update({
          'email': listInvestment[j].email,
          'Uuid': listInvestment[j].userID,
          'Updated_id': 'system',
          'investment_name': listInvestment[j].name,
          'currInvestAmt': listInvestment[j].currentInvestmentAmount,
          'annualInvestAmt': listInvestment[j].annualInvestmentAmount,
          'investRoI': listInvestment[j].investmentRoi,
          'investment_duration': listInvestment[j].investmentDuration,
          'update_dts': Timestamp.fromDate(currentPhoneDate),
          'status': documentStatus,
        })
            .then((value)=>print("Investment updated"));
      }
      catch (e) {
        print( 'Exception while updating $docID $e');
      }
    }
  }
  Future fetchInvestmentbyUser(
      String user,
      ) async{
    List<InvestDB> listInvest=[];
    _firestore.collection('pjdhan_investment').where('Uuid', isEqualTo: user)
        .get()
        .then((QuerySnapshot snapshot){
      snapshot.docs.forEach((f) {
        String email=f.get('email');
        String userID=f.get('Uuid');
        String docID=_firestore.collection('pjdhan_investment').doc().id;
        String investmentName=f.get('investment_name');
        double currInvestAmt=f.get('currInvestAmt');
        double annualInvestAmt=f.get('annualInvestAmt');
        double investRoI=f.get('investRoI');
        double duration=f.get('investment_duration');
        listInvest.add(InvestDB(email, docID, userID, investmentName,currInvestAmt , annualInvestAmt,investRoI,duration));
      });
      return listInvest;
    }
    );
  }
}


