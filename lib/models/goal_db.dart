import 'package:flutter/material.dart';
class GoalDB {
  GoalDB(this.email,this.user,this.name,this.goalDocumentID, this.description, this.goalAmount, this.goalDuration);

  String email;
  String user;
  String goalDocumentID;
  String name;
  String description;
  double goalAmount;
  double goalDuration;
}