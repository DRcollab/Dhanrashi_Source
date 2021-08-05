
import 'dart:math';

import 'package:dhanrashi_mvp/components/dounut_charts.dart';
import 'package:dhanrashi_mvp/components/irregular_shapes.dart';
import 'package:dhanrashi_mvp/constants.dart';
import 'package:flutter/material.dart';
import 'custom_text_field.dart';
import 'package:dhanrashi_mvp/components/buttons.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dhanrashi_mvp/components/labeled_slider.dart';

class ActionSheet extends StatefulWidget {
 // const ActionSheet({Key? key}) : super(key: key);

  String titleMessage;
  var textVar = TextEditingController();
  String display = '';
  final String? Function(String?) validator;

  ActionSheet({this.titleMessage='', required this.validator });
  @override
  _ActionSheetState createState() => _ActionSheetState();
}

class _ActionSheetState extends State<ActionSheet> {


  //String display = '';
  double sliderValue = 5;

  double investAmount = 0;
  int year = 0;
  int roi = 0;

  double investedAmount = 0;
  double expectedRoi = 0;
  double investmentDuration = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0x00000000),
      child: Wrap(
         // shrinkWrap: true,
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Center(child: Text(widget.titleMessage, style: kH1,)),
         ),


         Container(
           height: 180,width: 180,
             child: DonutChart()),

         Padding(
           padding: const EdgeInsets.only(left:8.0, right: 8.0),
           child: LabeledSlider(
             collector: investAmount,
             controller: widget.textVar,
             validator: widget.validator,
             sliderValue: 5,
             min: 1,
             max: 100,
             labelText: 'Invested Amount (in Lakhs)',
           ),
         ),
          Padding(
            padding: const EdgeInsets.only(left:8.0, right: 8.0),
            child: LabeledSlider(
              collector: expectedRoi,
              controller: widget.textVar,
              validator: widget.validator,
              min: 1,
              max:30,
              labelText: 'Expected return ',
              sliderValue: 15,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:8.0, right: 8.0),
            child: LabeledSlider(
              collector: investmentDuration,
              controller: widget.textVar,
              validator: widget.validator,
              min: 1,
              max: 30,
              labelText: 'Time Period',
              sliderValue: 5,
            ),
          ),
          Center(
            child: CommandButton(
              buttonColor: kPresentTheme.navigationColor,
              //icon: Icons.save,
              textColor: kPresentTheme.inputTextColor,
              buttonText: 'Save Investment',
              onPressed:(){

            }, borderRadius: BorderRadius.circular(10),),
          ),

        ],
      ),
    );
  }
}




