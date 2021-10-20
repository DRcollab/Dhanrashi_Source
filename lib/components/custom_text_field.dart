

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';



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
  Function() onSubmit;


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
    required this.onSubmit,

  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {




  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.h, //- 50.0 * DefaultValues.adaptForSmallDevice(context),
      alignment: Alignment.bottomCenter,
      // color: Colors.amber,


      child: TextFormField(
        controller: this.widget.controller,
        onFieldSubmitted: (_){
          FocusScope.of(context).nextFocus();
          widget.onSubmit();

        },
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

                          gapPadding: 1.h,
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
  late TextStyle style;
  late Function()? onTap;

  EditableTextField({
    this.isEditing=false,
    this.initialText = 'Initial Text',
    required this.style,
    required this.editingController,
    this.onTap,
  });


  @override
  _EditableTextFieldState createState() => _EditableTextFieldState();
}


class _EditableTextFieldState extends State<EditableTextField> {


  @override
  void initState() {
    super.initState();
   widget.editingController = TextEditingController(text: widget.initialText);
  }
  @override
  void dispose() {
    // widget.editingController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {


    if(widget.isEditing) {
      return TextFormField(
        textInputAction: TextInputAction.done,
        style: widget.style,
        controller: widget.editingController,
        onFieldSubmitted: (value) {
          setState(() {
            widget.initialText = value;
            print(' here is the value: $value');

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
        onTap: widget.onTap,
      );
    }else{

      return Text(widget.initialText,style: widget.style,);

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
  Function()? onCompleteEditing;
  String errorText;
  double radius;
  String label;
  String suffix ='';
  bool enabled;
  final Function()? validator;
  final Function()? onFocusLost;

  NumberInputField({
    this.hintText = '',
    this.passWord=false,
    this.onCompleteEditing,
    required this.controller,
    //required this.validator,
    this.getValue,
    this.radius = 25,
    this.label='',
    this.errorText='',
    this.suffix='',
    this.enabled = true,
    this.validator,
    this.onFocusLost,
  });


  @override
  _NumberInputFieldState createState() => _NumberInputFieldState();
}

class _NumberInputFieldState extends State<NumberInputField> {

  bool autofocus = false;
  FocusNode numericFocusNode = FocusNode();




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    numericFocusNode.addListener(() {
      if(!numericFocusNode.hasFocus){
        setState(() {
          widget.onFocusLost!();
          print('done');
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
          children: [
            Expanded(
              flex:2,
              child: Padding(
                padding:  EdgeInsets.only(left: 0.0, right: 2.w, top:2.h, bottom: 0.0),
                child: Text(widget.label),
              ),
            ),
            Flexible(child: Padding(
              padding:  EdgeInsets.only(left: 0.0, right: 2.w, top:2.h, bottom: 0.0),
              child: Container(
                height: 6.h,
                width: 52.w,
                child: TextField(
                     focusNode: numericFocusNode,
                    autofocus: this.autofocus,
                    textAlign: TextAlign.end,
                    enableInteractiveSelection: false,
                    enabled: widget.enabled,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[.0-9]')),],
                    controller: widget.controller,
                    onSubmitted: (_)=> FocusScope.of(context).unfocus(),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    style:DefaultValues.kInputTextStyle(context),
                    //validator: widget.validator,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(2.w),
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

                  onEditingComplete: (){
                      setState(() {
                        autofocus = false;
                        widget.getValue!();
                        widget.onCompleteEditing!();
                      });

                      },

                  onTap: widget.validator,

            ),
              ),),
            ),
            Text(widget.suffix),
          ]

      ),
    );
  }
}
