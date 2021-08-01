

import '/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  String hintText = "";
  bool passWord = false;
  var key;
  Function validator;
  TextEditingController controller;
  IconData icon;
  Function validate;
  String errorText;

  CustomTextField({this.hintText, this.passWord=false, this.key, this.controller, this.validator, this.icon, this.validate,this.errorText});

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 50.0,
      alignment: Alignment.bottomCenter,
      // color: Colors.amber,


      child: TextFormField(
        controller: this.controller,

        obscureText: this.passWord,
        textInputAction: TextInputAction.next,
        style: kInputTextStyle,
        validator: this.validator,
        decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                 // errorBorder: kPresentTheme.formTextBorder,
                  //focusedErrorBorder: kPresentTheme.formTextBorder,
                  prefixIcon: Icon(icon,color: kPresentTheme.inputTextColor,),
                  fillColor: kPresentTheme.inputTextColor,
                  border:kPresentTheme.formTextBorder,
                  hintText: this.hintText,
                  hintStyle: kPresentTheme.hintTextStyle,
                  errorText: errorText,

        ),

        onEditingComplete: validate,
        onTap: validate,
      ),
    );
  }
}







class EditableTextField extends StatefulWidget {
  //const EditableText({Key? key}) : super(key: key);

  bool isEditing = false;
  TextEditingController editingController;
  String initialText = "Initial Text";
  TextStyle style;

  EditableTextField({this.isEditing,this.initialText,this.style, this.editingController});


  @override
  _EditableTextFieldState createState() => _EditableTextFieldState();
}


class _EditableTextFieldState extends State<EditableTextField> {


  @override
  void initState() {
    super.initState();
  //  widget._editingController = TextEditingController(text: widget.initialText);
  }
  @override
  void dispose() {
    widget.editingController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    print('88888888');
    print(widget.isEditing);
    if(widget.isEditing) {
      return TextField(
        controller: widget.editingController,
        onSubmitted: (value) {
          setState(() {
            widget.initialText = value;
            //widget.isEditing = false;
          });

        },
        onEditingComplete:(){
          setState(() {

            widget.isEditing = false;
          });
        } ,
        onChanged: (value){
          setState(() {
            widget.initialText = value;

          });
        },
      );
    }else{
      print(":::::::::::${widget.initialText}");
      print(Text(widget.initialText));
      return Text(widget.initialText);

    }
  }
}
