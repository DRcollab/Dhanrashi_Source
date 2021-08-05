import 'package:flutter/material.dart';


String validEmailMessage= 'email must  look like a12b@ijk.xyz or similar';

String validPasswordMessage = 'length of the password must be atleast 6 ';

mixin InputValidationMixin{

  bool eMailValid(String email){
    String pattern =  r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))';

    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(email);



  }

  bool passWordValid(String pwd){

    return pwd.length>5;

  }
}



String emailValidator(String value){

  if(value.isEmpty){
    return "please enter your email";

  }
  else if(!value.contains('@') & (!value.contains('.'))){
    return "email must contain '@' and '.' ";
  }
  else{
    return '';
  }
}




String passWordValidator(String value){
  if(value.isEmpty){
    return "password length cannot be zero";

  }
  else{
    return '';
  }


}