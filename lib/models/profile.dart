
import 'package:flutter/cupertino.dart';

class Profile {

  Profile(
      {

        required this.firstName,
        required this.lastName,
        required this.incomeRange,
        required this.DOB,
         this.docId,

      });

  Profile.create(){
    this.firstName ='';
    this.lastName = '';
    this.incomeRange = '';
    this.DOB = DateTime.now();
    this.docId = '';
  }

  late String  firstName;
   late String lastName;
   late String incomeRange;
   late DateTime DOB;
   late String? docId;

}
