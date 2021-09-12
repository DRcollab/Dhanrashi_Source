/// This code is written by Arvind Ganesan

import 'package:flutter/material.dart';
import 'package:dhanrashi_mvp/models/profile.dart';
class GoalDB {

  GoalDB({
    required String email,
    required String user,
    required String goalDocumentID,
    required Profile profile,
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
    this._profile = goal;

  }

  late String _email;
  late String _user;
  late String _goalDocumentID='';

  late Profile _profile;


  String get email => _email;
  String get user => _user;
  String get goalDocumentID => _goalDocumentID;
  Profile get goal => _profile;

  set email(email) => _email = email;
  set user(user) => _user = user;
  set goalDocumentID(id) => _goalDocumentID = id;
  set goal(profile) => _profile = profile;


// String name;
// String description;
// double goalAmount;
// double goalDuration;
}