/// This code is written by Arvind Ganesan  part of Dhanrashi_MVP project

import 'package:dhanrashi_mvp/models/investment.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhanrashi_mvp/models/goal_db.dart';
import 'package:dhanrashi_mvp/models/investment_db.dart';

class DRInvestAccess{
  late final _firestore;
  late final _currentUser;

  DRInvestAccess(FirebaseFirestore firestore, var currentUser){
        this._firestore = firestore;
        this._currentUser = currentUser;

  }

  Future storeInvestment(
      List<InvestDB> listInvestments,) async {
    DateTime currentPhoneDate = DateTime.now();
   // print(listInvestments[0].name);
    for (var i = 0; i < listInvestments.length; i++){
      try {
        print('i am here');
        await _firestore.collection('pjdhan_investment').add({
          'email': listInvestments[i].email,
          'Uuid': listInvestments[i].userId,
          'Updated_id': 'system',
          'investment_name': listInvestments[i].investment.name,
          'currInvestAmt': listInvestments[i].investment.currentInvestmentAmount,
          'annualInvestAmt': listInvestments[i].investment.annualInvestmentAmount,
          'investRoI': listInvestments[i].investment.investmentRoi,
          'investment_duration': listInvestments[i].investment.duration,
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

  Future storeInvestmentSolo(
     Investment investment,) async {
    DateTime currentPhoneDate = DateTime.now();
   // print(listInvestments[0].name);

      try {
        print('i am here');
        await _firestore.collection('pjdhan_investment').add({
          'email': this._currentUser.email,
          'Uuid': this._currentUser.uid,
          'Updated_id': 'system',
          'investment_name': investment.name,
          'currInvestAmt': investment.currentInvestmentAmount,
          'annualInvestAmt': investment.annualInvestmentAmount,
          'investRoI': investment.investmentRoi,
          'investment_duration': investment.duration,
          'insert_dts': Timestamp.fromDate(currentPhoneDate),
          'update_dts': Timestamp.fromDate(currentPhoneDate),
          'status': 'Active',
        })
            .then((value)=>print("Investment added"));
      }
      catch (e) {
        throw e;
      }
  }

  Future<dynamic> updateInvestmentSolo( InvestDB investDB, String documentStatus,) async {
    DateTime currentPhoneDate = DateTime.now();

      var docID= investDB.investmentId;
      try {
        _firestore.collection('pjdhan_investment').doc(investDB.investmentId).update({
          'email': investDB.email,
          'Uuid': investDB.userId,
          'Updated_id': 'system',
          'investment_name': investDB.investment.name,
          'currInvestAmt': investDB.investment.currentInvestmentAmount,
          'annualInvestAmt': investDB.investment.annualInvestmentAmount,
          'investRoI': investDB.investment.investmentRoi,
          'investment_duration': investDB.investment.duration,
          'update_dts': Timestamp.fromDate(currentPhoneDate),
          'status': documentStatus,
        })
            .then((value)=>print("Investment updated"));
      }
      catch (e) {
        print( 'Exception while updating $docID $e');
      }

  }


  Future fetchInvestment() async{
    List<InvestDB> listInvest=[];
    _firestore.collection('pjdhan_investment').where('Uuid', isEqualTo: _currentUser.uid)
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
        int duration=f.get('investment_duration');
        listInvest.add(
            InvestDB(
                email:email,
                investmentDocumentID: docID,
                userID: userID,
                investment: Investment(
                  name: investmentName,
                  currentInvestmentAmount: currInvestAmt,
                  annualInvestmentAmount: annualInvestAmt,
                  investmentRoi: investRoI,
                  duration: duration,
        ) ));
      });
      return listInvest;
    }
    );
  }
}


