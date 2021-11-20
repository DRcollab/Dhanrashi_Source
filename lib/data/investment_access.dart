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



  Future storeInvestmentSolo(
     Investment investment,) async {
    DateTime currentPhoneDate = DateTime.now();

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
            .then((value){
              return true;
            });
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



}


