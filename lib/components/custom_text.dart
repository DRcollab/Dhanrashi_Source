import 'package:flutter/material.dart';




class ErrorText extends StatelessWidget {

  String errorText;

  ErrorText({this.errorText = ""});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(this.errorText , style: TextStyle(color:Colors.red),)
    );
  }
}
