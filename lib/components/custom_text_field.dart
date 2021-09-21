

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {

  late String hintText = "";
  bool passWord = false;
  bool hidePassword = true;
  //var key;
  final String? Function(String?) validator;
  TextEditingController? controller;
  late IconData icon;
  final Function()? validate;
   Function()? showPassword;
  String errorText = '';
  double radius;
  String label;
  TextInputAction? textInputAction;


  CustomTextField({
    this.hintText='',
    this.passWord=false,
    this.hidePassword = true,
    //this.key,
    this.controller,
    required this.validator,
    this.icon = Icons.add_chart_outlined,
    this.showPassword,
    this.validate,
    this.radius = 25,
    this.label='',
    this.textInputAction = TextInputAction.next,
    this.errorText='',


  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {




  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 50.0 - 50.0 * DefaultValues.adaptForSmallDevice(context),
      alignment: Alignment.bottomCenter,
      // color: Colors.amber,


      child: TextFormField(
        controller: this.widget.controller,

        obscureText: widget.passWord && this.widget.hidePassword,
        textInputAction: this.widget.textInputAction,
        style: DefaultValues.kH3(context),
        validator: this.widget.validator,
        decoration: InputDecoration(
                  isDense : true,
                  contentPadding: DefaultValues.kDefaultPaddingAllSame(context),
                  enabledBorder: kFormTextBorder,
                  errorBorder: kFormTextBorder,
                  focusedErrorBorder: kFormTextBorder,
                  prefixIcon: Icon(widget.icon,color: kPresentTheme.accentColor,),
                  suffixIcon: this.widget.passWord ? IconButton(
                      onPressed:widget.showPassword,
                      icon:  this.widget.hidePassword ? Icon(Icons.remove_red_eye_outlined) : Icon(Icons.remove_red_eye_sharp),
                  ) : null,
                  fillColor: kPresentTheme.accentColor,

                  border: OutlineInputBorder(

                          gapPadding: 1.0,
                         borderRadius: BorderRadius.circular(25.0),

                          borderSide: BorderSide(
                               color: Color(0xFF004752),
                                    )
                            ),
                  hintText: this.widget.hintText,
                  hintStyle: DefaultValues.kHintTextStyle(context),
                  errorText: widget.errorText,
                  labelText: widget.label,
                  //labelStyle:
        ),

      onEditingComplete: (){
          if(widget.validate!=null)
          widget.validate!();


      },
       onTap: () {
         if(widget.validate!=null)
          widget.validate!();

       }
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


class NumberInputField extends StatefulWidget {
 // const LabeledTextField({Key? key}) : super(key: key);

  String hintText = "";
  bool passWord = false;

 // final String? Function(String?) validator;
  TextEditingController controller;

  final Function()? getValue;
  String errorText;
  double radius;
  String label;
  String suffix ='';
  bool enabled;

  NumberInputField({
    this.hintText = '',
    this.passWord=false,

    required this.controller,
    //required this.validator,
    this.getValue,
    this.radius = 25,
    this.label='',
    this.errorText='',
    this.suffix='',
    this.enabled = true,

  });


  @override
  _NumberInputFieldState createState() => _NumberInputFieldState();
}

class _NumberInputFieldState extends State<NumberInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
          children: [
            Expanded(
              flex:2,
              child: Padding(
                padding: const EdgeInsets.only(left: 0.0, right: 8.0, top:8.0, bottom: 0.0),
                child: Text(widget.label),
              ),
            ),
            Flexible(child: Padding(
              padding: const EdgeInsets.only(left: 0.0, right: 8.0, top:8.0, bottom: 0.0),
              child: Container(
                height: 60 * DefaultValues.adaptForSmallDevice(context),
                width: 120,
                child: TextField(
                    textAlign: TextAlign.end,
                    enableInteractiveSelection: false,
                    enabled: widget.enabled,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[.0-9]')),],
                    controller: widget.controller,

                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    style:DefaultValues.kInputTextStyle(context),
                    //validator: widget.validator,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        disabledBorder: InputBorder.none,

                        errorBorder: OutlineInputBorder(

                            gapPadding: 2.0,
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                              color: Colors.red,//Colors.black12,
                            )
                        ),
                        focusedErrorBorder:  OutlineInputBorder(

                            gapPadding: 2.0,
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                              color: Colors.black12,
                            )
                        ),
                        //enabledBorder: kFormTextBorder,
                        fillColor: kPresentTheme.accentColor,
                        border: OutlineInputBorder(
                            gapPadding: 1.0,
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: Color(0xFF004752),
                            )
                        ),
                    hintText: widget.hintText,
                   // errorText: widget.errorText,

                      //labelStyle:
                    ),

                  onEditingComplete: widget.getValue,

                  // onTap: widget.validate,

            ),
              ),),
            ),
            Text(widget.suffix),
          ]

      ),
    );
  }
}
