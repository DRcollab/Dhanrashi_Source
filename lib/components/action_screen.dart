
import 'dart:math';

import 'package:dhanrashi_mvp/components/dounut_charts.dart';
import 'package:dhanrashi_mvp/components/irregular_shapes.dart';
import 'package:dhanrashi_mvp/constants.dart';
import 'package:flutter/material.dart';
import 'custom_text_field.dart';
import 'package:dhanrashi_mvp/components/buttons.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dhanrashi_mvp/components/labeled_slider.dart';



// double investedAmount = 10;
// double expectedRoi = 23;
// int investmentDuration = 8;


class ActionSheet extends StatefulWidget {
 // const ActionSheet({Key? key}) : super(key: key);

  String titleMessage;
  // var textVar1 = TextEditingController();
  // var textVar2 = TextEditingController();
  // var textVar3 = TextEditingController();

  double investedAmount = 0;
  double expectedRoi = 0;
  int investmentDuration = 0;
  String imageSource ='';

  String display = '';
 // final String? Function(String?) validator => return 0;

  ActionSheet({
    this.titleMessage='',
    required this.investedAmount,
    required this.expectedRoi,
    required this.investmentDuration,
    this.imageSource='',

  });

  @override
  _ActionSheetState createState() => _ActionSheetState();
}

class _ActionSheetState extends State<ActionSheet> {

  //var seriesPieData =  <charts.Series<Task, String>>[];
  List<Task> pieData = [];

  //String display = '';
  double sliderValue = 5;

  double investedAmount = 1;
  double expectedRoi = 1;
  int investmentDuration = 1;
  double interestValue = 0 ;        // holds calculated value of futureValue of the investment


  double calculateInterset( ){

    double roi = expectedRoi /100;
    return   investedAmount * pow(1 + roi,investmentDuration) - investedAmount;


  }




  @override
  void initState(){

    print(widget.investmentDuration);
    investedAmount = widget.investedAmount;
    expectedRoi = widget.expectedRoi;
    investmentDuration = widget.investmentDuration;
    interestValue = calculateInterset();



    super.initState();
  }

  // var pieData = [
  //   Task('PV', 23.9, Colors.deepPurpleAccent),
  //   Task('FV', 24.8,Colors.amberAccent),
  //
  // ];


  @override
  Widget build(BuildContext context) {

    interestValue = calculateInterset();
    print('PV : $investedAmount and FV:$interestValue');

     pieData = [

      Task('Investment', investedAmount, kPresentTheme.accentColor),
      Task('Interest Earned', interestValue ,kPresentTheme.alternateColor),


    ];


    return Container(
      color: Color(0x00000000),
      child: Wrap(
         // shrinkWrap: true,
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
               Image.asset(widget.imageSource, height: 50, width: 50,),
               Expanded(child: Center(child: Text(widget.titleMessage, style: kH1,))),
             ],
           ),
         ),


         Row(
           children: [
             Container(
               height: 180,width: 180,
                 child: DonutChart(pieData: pieData,)),
             Container(height: 180,width: 180,
               child: Column(
                 children: [
                   Row(
                     children: [
                       CircleAvatar(radius: 10,backgroundColor: kPresentTheme.accentColor),
                       Padding(
                         padding: const EdgeInsets.only(left : 8.0),
                         child: Text('Invested Amount'),
                       ),

                     ],
                   ),
                   Row(
                     children: [
                       CircleAvatar(radius: 10,backgroundColor: kPresentTheme.alternateColor),
                       Padding(
                         padding: const EdgeInsets.only(left : 8.0),
                         child: Text('Interest Amount'),
                       ),

                     ],
                   ),
                   SizedBox(height: 10,width: double.infinity,),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Text('Total Investment in ${widget.titleMessage}'),
                   ),
                 ],
               ),
             )
           ],
         ),

         Padding(
           padding: const EdgeInsets.only(left:8.0, right: 8.0),
           child: LabeledSlider(
             onChanged: (value){

               setState(() {
                 investedAmount = value;
               });

             },

             validator: (value){

                },
             sliderValue: investedAmount,
             min: 1,
             max: 100,
             labelText: 'Invested Amount (in Lakhs)',
             suffix: 'Lakhs',
           ),
         ),
          Padding(
            padding: const EdgeInsets.only(left:8.0, right: 8.0),
            child: LabeledSlider(
              onChanged: (value){
                setState(() {
                  expectedRoi = value;
                });

              },

              validator: (value){

              },
              min: 1,
              max:30,
              labelText: 'Expected return ',
              sliderValue: expectedRoi,
              suffix: '%      ',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:8.0, right: 8.0),
            child: LabeledSlider(
              onChanged: (value){
                setState(() {
                  investmentDuration = value.round();
                });

              },


              validator: (value){

              },
              min: 1,
              max: 30,
              labelText: 'Time Period',
              sliderValue: investmentDuration.toDouble(),
              suffix: 'Years',
            ),
          ),
          Center(
            child: CommandButton(
              buttonColor: kPresentTheme.alternateColor,
              //icon: Icons.save,
              textColor: kPresentTheme.highLightColor,
              buttonText: 'Save Investment',
              onPressed:(){



                  print('duration: ${investmentDuration}');
                  print('amount: ${investedAmount}');
                  print('ROI :${expectedRoi}');



            }, borderRadius: BorderRadius.circular(10),),
          ),

        ],
      ),
    );
  }
}




