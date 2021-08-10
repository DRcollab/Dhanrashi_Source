

import '/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  late String hintText = "";
  bool passWord = false;
  bool hidePassword = true;
  var key;
  final String? Function(String?) validator;
  TextEditingController controller;
  late IconData icon;
  final Function()? validate;
   Function()? showPassword;
  String errorText = '';
  double radius;
  String label;


  CustomTextField({
    this.hintText='',
    this.passWord=false,
    this.hidePassword = true,
    this.key,
    required this.controller,
    required this.validator,
    this.icon = Icons.add_chart_outlined,
    this.showPassword,
    this.validate,
    this.radius = 25,
    this.label='',
    this.errorText=''});

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 50.0,
      alignment: Alignment.bottomCenter,
      // color: Colors.amber,


      child: TextFormField(
        controller: this.controller,

        obscureText: passWord && this.hidePassword,
        textInputAction: TextInputAction.next,
        style: kH3,
        validator: this.validator,
        decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),

                  errorBorder: kFormTextBorder,
                  focusedErrorBorder: kFormTextBorder,
                  prefixIcon: Icon(icon,color: kPresentTheme.accentColor,),
                  suffixIcon: this.passWord ? IconButton(
                      onPressed:showPassword,
                      icon:  this.hidePassword ? Icon(Icons.remove_red_eye_outlined) : Icon(Icons.remove_red_eye_sharp),
                  ) : null,
                  fillColor: kPresentTheme.accentColor,
                  border: OutlineInputBorder(
                          gapPadding: 2.0,
                         borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                               color: Color(0xFF004752),
                                    )
                            ),
                  hintText: this.hintText,
                  hintStyle: kHintTextStyle,
                  errorText: errorText,
                  labelText: label,
                  //labelStyle:
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


  EditableTextField({
    this.isEditing=false,
    this.initialText = 'Initial Text',
    this.style = const TextStyle(fontSize: 10),
    required this.editingController });


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


class LabeledTextField extends StatefulWidget {
 // const LabeledTextField({Key? key}) : super(key: key);

  String hintText = "";
  bool passWord = false;
  var key;
  final String? Function(String?) validator;
  TextEditingController controller;

  final Function()? getValue;
  String errorText;
  double radius;
  String label;
  String suffix ='';

  LabeledTextField({
    this.hintText = '',
    this.passWord=false,
    this.key,
    required this.controller,
    required this.validator,
    this.getValue,
    this.radius = 25,
    this.label='',
    this.errorText='',
    this.suffix='',
  });


  @override
  _LabeledTextFieldState createState() => _LabeledTextFieldState();
}

class _LabeledTextFieldState extends State<LabeledTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
          children: [
            Expanded(
              flex:3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.label),
              ),
            ),
            Flexible(child: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: Container(
                height: 60,width: 60,
                child: TextFormField(
                    controller: widget.controller,
                    obscureText: widget.passWord,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    style: kInputTextStyle,
                    validator: widget.validator,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        focusedBorder:  kFormTextBorder,
                        enabledBorder: kFormTextBorder,
                        fillColor: kPresentTheme.accentColor,
                        border: OutlineInputBorder(
                            gapPadding: 1.0,
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                              color: Color(0xFF004752),
                            )
                        ),
                    hintText: widget.hintText,
                    hintStyle: kHintTextStyle,
                    errorText: widget.errorText,

                      //labelStyle:
                    ),

                   onEditingComplete: widget.getValue,

                   //onTap: widget.validate,

            ),
              ),),
            ),
            Text(widget.suffix),
          ]

      ),
    );
  }
}
