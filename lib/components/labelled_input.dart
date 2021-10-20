

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

   required this.controller,
  });



  @override
  _LabeledInputState createState() => _LabeledInputState();
}

class _LabeledInputState extends State<LabeledInput> {



  var textFormat;
  var numberFormat;
  double variableMax = 0;
  double variableMin = 0;
  late Color activeColor;
  String label = '';
  String textLabel = '';
  late String _currency;
  bool autofocus = false;
  FocusNode numericFocusNode = FocusNode();

  @override
  void initState() {
    textFormat = NumberFormat.simpleCurrency(locale:'en-in');
    numberFormat = NumberFormat.decimalPattern();
    widget.controller.text = textFormat.format(widget.initialValue);
    // if(widget.initialValue>0){
    //   if(widget.initialValue<1){
    //     controller.text = (widget.initialValue*100).toString();
    //     textLabel = 'Thousand';
    //   }else{
    //     controller.text = widget.initialValue.toString();
    //     textLabel = 'Lakh';
    //   }
    // }else{
    //   controller.text = widget.initialValue.toString();
    //   textLabel = '';
    // }

    _currency = NumberFormat.compactSimpleCurrency(locale: 'en-in').currencySymbol;


    // activeColor = widget.activeColor;
    // controller = TextEditingController(
    //   text: widget.sliderValue.toStringAsFixed(widget.textPrecision),
    // );
    // variableMax = widget.max;
    // variableMin = widget.min;
    // //
     super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //controller.dispose();
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
                  height: 6.h,
                  child: TextField(
                    onChanged: (value){
                      print(widget.controller.text);

                      value = widget.controller.text+',';
                    },
                    focusNode: numericFocusNode,
                    autofocus: this.autofocus,
                    textAlign: TextAlign.end,
                    enableInteractiveSelection: false,
                    enabled: widget.enabled,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),

                    ],
                    controller: widget.controller,
                    onSubmitted: (_){
                      FocusScope.of(context).unfocus();
                      if(!FocusScope.of(context).hasFocus){
                        String value='';
                        setState(() {
                          autofocus = false;

                          widget.onCompleteEditing!();
                          value = widget.controller.text;

                          widget.controller.text = textFormat.format(double.parse( widget.controller.text));

                          print(value);


                          //widget.getValue!(value);
                        });
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

                    onEditingComplete: (){
                      String value='';
                      setState(() {
                        autofocus = false;

                        widget.onCompleteEditing!();
                        widget.controller.text = textFormat.format(double.parse( widget.controller.text));
                        print('[[[[[[[');
                        print(widget.controller.text);
                        print(value);
                        // if(double.parse(this.controller.text)>=100000){
                        //   value = this.controller.text = (double.parse(this.controller.text)/100000).toStringAsFixed(2);
                        //   textLabel = 'Lakhs';
                        //
                        // }else if(double.parse(this.controller.text)>=1000){
                        //   value = this.controller.text = (double.parse(this.controller.text)/1000).toStringAsFixed(2);
                        //   value = (double.parse(value)/100).toStringAsFixed(2);
                        //   textLabel = 'Thousands';
                        // }else if(double.parse(this.controller.text)>=100){
                        //   value = this.controller.text = (double.parse(this.controller.text)/100).toStringAsFixed(2);
                        //   textLabel = 'Hundred';
                        //   value = (double.parse(value)/1000).toStringAsFixed(2);
                        // }
                        //widget.getValue!(value);
                      });

                    },

                    onTap: (){
                      widget.controller.text = widget.initialValue.toStringAsFixed(0);

                      widget.validator!();
                    }
                    ,
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left:8.0),
                //   child: Text(textLabel,style: DefaultValues.kNormal2(context),),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
