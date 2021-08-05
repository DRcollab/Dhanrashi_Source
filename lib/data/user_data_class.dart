import 'dart:core';

import 'package:flutter/material.dart';

class UserData{

  String _eMail = '';
  String _fName = '';
  String _lName = '';
  String _dob = '';
  String _income = '';

  UserData( this._eMail, this._fName,this._lName, this._dob,this._income);

  UserData.create(){
    _eMail = '';
    _fName = '';
    _lName = '';
    _dob = '';
    _income = '';

  }


  void setFName(String name){

     _fName = name;
  }


  void setLName(String lname){

    _lName = lname;

  }

  void setDOB(String dob){

    _dob = dob;

  }

  void setEmail(String email){

    _eMail = email;

  }

  void setIncome(String income){


    _income = income;

  }

  String firstName(){
     return _fName;

  }

  String lastName(){
    return _lName;

  }

  String eMail(){
    return _eMail;

  }

  String dob(){

    return _dob;
  }

  String income(){
    return _income;

  }

  String fullName(){

    return _fName + " "+_lName;

  }

  bool contains(String str){

    if(_eMail == str)
      return true;
    else
      return false;


  }
}