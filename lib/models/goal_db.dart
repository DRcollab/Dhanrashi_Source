/// This code is written by Arvind Ganesan

import 'package:flutter/material.dart';
import 'package:dhanrashi_mvp/models/goal.dart';
class GoalDB {

  GoalDB({
    required String email,
    required String user,
    required String goalDocumentID,
    required Goal goal,
    // this.name,
    // this.goalDocumentID,
    // this.description,
    // this.goalAmount,
    // this.goalDuration
  }
      ){

    this._email = email;
    this._user = user;
    this._goalDocumentID = goalDocumentID;
    this._goal = goal;

  }

  late String _email;
  late String _user;
  late String _goalDocumentID='';

  late Goal _goal;


  String get email => _email;
  String get user => _user;
  String get goalDocumentID => _goalDocumentID;
  Goal get goal => _goal;

  set email(email) => _email = email;
  set user(user) => _user = user;
  set goalDocumentID(id) => _goalDocumentID = id;
  set goal(goal) => _goal = goal;


  // String name;
  // String description;
  // double goalAmount;
  // double goalDuration;
}