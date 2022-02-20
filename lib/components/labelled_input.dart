

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'constants.dart';
import 'custom_text_field.dart';


class LabeledInput extends StatefulWidget {
  String hintText = "";
  bool passWord = false;

  // final String? Function(String?) validator;

  double initialValue;
  //late final Function(dynamic value)? getValue;
  Function()? onCompleteEditing;
  String errorText = '';
  double radius = 0;
  late String label;
  String suffix ='';
  late bool enabled;
  late final Function()? validator;
  late final Function()? onFocusLost;
  late Icon? icon;
  var controller = TextEditingController();
  bool mute = false;

 LabeledInput({
    this.hintText = '',
    this.passWord=false,
    this.onCompleteEditing,
    // required this.controller,
    //required this.validator,

    this.radius = 25,
    this.label='',
    this.errorText='',
    this.suffix='',
    this.enabled = true,
    this.validator,
    this.onFocusLost,
   this.icon,
   this.initialValue = 0,
    this.mute = false,
   required this.controller,
  });



  @override
  _LabeledInputState createState() => _LabeledInputState();
}

class _LabeledInputState extends State<LabeledInput> {




  var numberFormat;

  double variableMax = 0;
  double variableMin = 0;
  late Color activeColor;
  String label = '';
  String textLabel = '';
  late String _currency;
  bool autofocus = false;
 // FocusNode numericFocusNode = FocusNode();

  @override
  void initState() {

    numberFormat = NumberFormat.decimalPattern();
    widget.controller.text =DefaultValues.textFormat.format(widget.initialValue);

     super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //controller.dispose();
    print('labelled input disposed');
  }



  @override
  Widget build(BuildContext context) {

    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment:  Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left:2.w,top:1.h),
              child: Text(widget.label),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 1.h, left: 4.w, right:14.w,bottom:1.h),
            child: Row(
              children: [
                Container(
                  width:60.w,
                  height:!widget.mute ? 6.h:3.h,
                  child: !widget.mute ?TextField(
                   // focusNode: numericFocusNode,
                      autofocus: false,
                      textAlign: TextAlign.end,
                      enableInteractiveSelection: false,
                      enabled: widget.enabled,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),

                      ],
                      controller: widget.controller,
                      onSubmitted: (_){
                        FocusScope.of(context).unfocus();
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus &&
                            currentFocus.focusedChild != null) {
                          FocusManager.instance.primaryFocus!.unfocus();
                        }

                      }
                      ,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      style:DefaultValues.kInputTextStyle(context),
                      //validator: widget.validator,
                      decoration: InputDecoration(
                        // prefixText: _currency,
                        contentPadding: EdgeInsets.all(2.w),
                        disabledBorder: InputBorder.none,
                        icon: widget.icon,
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

                      onEditingComplete: widget.onCompleteEditing,



                      onTap: (){
                       //
                       widget.controller.text = widget.initialValue.toStringAsFixed(0);
                        widget.validator!();
                      }
                      ,
                  ):Text( DefaultValues.textFormat.format(widget.initialValue), style: DefaultValues.kInputTextStyle(context),),
                ),
                // Padding(

              ],
            ),
          ),
        ],
      ),
    );
  }
}
