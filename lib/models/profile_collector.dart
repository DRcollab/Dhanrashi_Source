import 'package:flutter/material.dart';


class Collector{


  DateTime _dateOfBirth = DateTime.now();
  String _annualIncome = '' ;
  var  _fName = TextEditingController() ;
  var _lName = TextEditingController();
  String profileImage = 'images/profiles/profile_image0.png';

  /// Constructor of  the class

  Collector(){

    _dateOfBirth = DateTime.now();
    _annualIncome = '';
    _fName = TextEditingController();
    _lName = TextEditingController();
    profileImage = 'images/profiles/profile_image0.png';


  }



  /// setter of first Name

  set fName(TextEditingController txt){

    _fName = txt;
  }

  /// setter of Lastname
  set lName(TextEditingController txt){

    _lName = txt;
  }

  /// setter of DOB
  set dateOfBirth(DateTime dt){

    _dateOfBirth = dt;
  }


  /// setter of Annual Income
  set annualIncome(String income){

    _annualIncome = income;

  }


  /// getter of firstname
  TextEditingController get fName{

    return _fName;
  }

  /// getter of Lastname
  TextEditingController get lName{

    return _lName;
  }


  /// getter of DOB
  DateTime get dateOfBirth{

    return _dateOfBirth;
  }

  /// getter of Income
  String get annualIncome{

    return _annualIncome;

  }

  String dateAsString(){

    return '${_dateOfBirth.day}/${_dateOfBirth.month}/${_dateOfBirth.year}';
  }

}